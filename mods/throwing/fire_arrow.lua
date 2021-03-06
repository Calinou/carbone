minetest.register_craftitem("throwing:arrow_fire", {
	description = "Torch Arrow",
	inventory_image = "throwing_arrow_fire.png",
})

minetest.register_node("throwing:arrow_fire_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			-- Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			-- Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},
			
			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"throwing_arrow_fire.png", "throwing_arrow_fire.png", "throwing_arrow_fire_back.png", "throwing_arrow_fire_front.png", "throwing_arrow_fire_2.png", "throwing_arrow_fire.png"},
	groups = {not_in_creative_inventory = 1},
})

local THROWING_ARROW_ENTITY = {
	physical = false,
	timer = 0,
	visual = "wielditem",
	visual_size = {x = 0.125, y = 0.125},
	textures = {"throwing:arrow_fire_box"},
	lastpos= {},
	collisionbox = {0, 0, 0, 0, 0, 0},
}

THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.2 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "throwing:arrow_fire_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					if self.node ~= "" then
						minetest.set_node(self.lastpos, {name="default:torch"})
						minetest.sound_play("default_place_node", {pos = self.lastpos})
					end
					self.object:remove()
				end
			else
				if self.node ~= "" then
					minetest.set_node(self.lastpos, {name="default:torch"})
					minetest.sound_play("default_place_node", {pos = self.lastpos})
				end
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if self.node ~= "" then
				minetest.set_node(self.lastpos, {name="default:torch"})
				minetest.sound_play("default_place_node", {pos = self.lastpos})
			end
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end

minetest.register_entity("throwing:arrow_fire_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
	output = "throwing:arrow_fire 1",
	recipe = {
		{"default:stick", "default:stick", "default:torch"},
	},
})

minetest.register_craft({
	output = "throwing:arrow_fire 1",
	recipe = {
		{"default:torch", "default:stick", "default:stick"},
	},
})
