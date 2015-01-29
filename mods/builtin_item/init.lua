minetest.register_entity(":__builtin:item", {
	initial_properties = {
		hp_max = 1,
		physical = true,
		collisionbox = {-0.175, -0.175, -0.175, 0.175, 0.175, 0.175},
		collide_with_objects = false,
		visual = "sprite",
		visual_size = {x=0.5, y=0.5},
		textures = {""},
		spritediv = {x=1, y=1},
		initial_sprite_basepos = {x=0, y=0},
		is_visible = false,
		timer = 0,
	},
	
	itemstring = "",
	physical_state = true,

	set_item = function(self, itemstring)
		self.itemstring = itemstring
		local stack = ItemStack(itemstring)
		local itemtable = stack:to_table()
		local itemname = nil
		if itemtable then
			itemname = stack:to_table().name
		end
		local item_texture = nil
		local item_type = ""
		if minetest.registered_items[itemname] then
			item_texture = minetest.registered_items[itemname].inventory_image
			item_type = minetest.registered_items[itemname].type
		end
		local prop = {
			is_visible = true,
			visual = "sprite",
			textures = {"unknown_item.png"}
		}
		if item_texture and item_texture ~= "" then
			prop.visual = "wielditem"
			prop.textures = {itemname}
			prop.visual_size = {x=0.25, y=0.25}
		else
			prop.visual = "wielditem"
			prop.textures = {itemname}
			prop.visual_size = {x=0.25, y=0.25}
			prop.automatic_rotate = math.pi * 0.5
		end
		self.object:set_properties(prop)
	end,

	get_staticdata = function(self)
		--return self.itemstring
		return minetest.serialize({
			itemstring = self.itemstring,
			always_collect = self.always_collect,
			timer = self.timer,
		})
	end,

	on_activate = function(self, staticdata, dtime_s)
		if string.sub(staticdata, 1, string.len("return")) == "return" then
			local data = minetest.deserialize(staticdata)
			if data and type(data) == "table" then
				self.itemstring = data.itemstring
				self.always_collect = data.always_collect
				self.timer = data.timer
				if not self.timer then
					self.timer = 0
				end
				self.timer = self.timer+dtime_s
			end
		else
			self.itemstring = staticdata
		end
		self.object:set_armor_groups({immortal=1})
		self.object:setvelocity({x=0, y=2, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
		self:set_item(self.itemstring)
	end,
	
	on_step = function(self, dtime)
		local time = tonumber(minetest.setting_get("remove_items"))
		if not time then time = 600 end
		if not self.timer then self.timer = 0 end
		
		self.timer = self.timer + dtime
		if time ~= 0 and (self.timer > time) then
			self.object:remove()
		end
		
		local p = self.object:getpos()
		
		local name = minetest.get_node(p).name
		if minetest.registered_nodes[name].damage_per_second > 0 or name == "maptools:igniter" then
			minetest.sound_play("builtin_item_lava", {pos = self.object:getpos(), gain = 0.45})
			self.object:remove()
			return
		end
		
		p.y = p.y - 0.3
		local nn = minetest.get_node(p).name
		-- If node is not registered or node is walkably solid:
		if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable then
			if self.physical_state then
				self.object:setvelocity({x=0,y=0,z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				self.physical_state = false
				self.object:set_properties({
					physical = false
				})
			end
		else
			if not self.physical_state then
				self.object:setvelocity({x=0,y=0,z=0})
				self.object:setacceleration({x=0, y=-10, z=0})
				self.physical_state = true
				self.object:set_properties({
					physical = true
				})
			end
		end
	end,
	--[[ -- This causes a duplication glitch if a player walks upon an item and clicks on it at the same time:
	on_punch = function(self, hitter)
		if self.itemstring ~= "" then
			local left = hitter:get_inventory():add_item("main", self.itemstring)
			if not left:is_empty() then
				self.itemstring = left:to_string()
				return
			end
		end
		self.object:remove()
	end,
	--]]
})

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [builtin_item] loaded.")
end
