
--
-- Helper functions
--

local function is_water(pos)
	local nn = minetest.env:get_node(pos).name
	return minetest.get_item_group(nn, "water") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = -math.sin(yaw)*v
	local z = math.cos(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

--
-- hover entity
--

local hover = {
	physical = true,
	collisionbox = {-0.8125, -0.3125, -0.8125, 0.8125, 0, 0.8125},
	visual = "mesh",
	mesh = "boat.x",
	textures = {"default_mese.png^[transformR90"},
	driver = nil,
	v = 0,
}

function hover:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	local name = clicker:get_player_name()
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x=0,y=11,z=-3}, {x=0,y=0,z=0})
		self.object:setyaw(clicker:get_look_yaw()-math.pi/2)
	end
end

function hover:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function hover:get_staticdata()
	return tostring(v)
end

function hover:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "hovers:hover")
	end
end

function hover:on_step(dtime)
	self.v = get_v(self.object:getvelocity())*get_sign(self.v)
	if self.driver then
		local ctrl = self.driver:get_player_control()
		if ctrl.up then
			self.v = self.v+0.1
		end
		if ctrl.down then
			self.v = self.v-0.1
		end
		if ctrl.left then
			self.object:setyaw(self.object:getyaw()+math.pi/120+dtime*math.pi/90)
		end
		if ctrl.right then
			self.object:setyaw(self.object:getyaw()-math.pi/120-dtime*math.pi/90)
		end
	end
	local s = get_sign(self.v)
	self.v = self.v - 0.02*s
	if s ~= get_sign(self.v) then
		self.object:setvelocity({x=0, y=0, z=0})
		self.v = 0
		return
	end
	if math.abs(self.v) > 6.75 then
		self.v = 6.75 * get_sign(self.v)
	end
	
	local p = self.object:getpos()
	p.y = p.y-0.5
	if is_water(p) then
		-- self.object:setacceleration({x=0, y=-10, z=0})
		self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
	else
		p.y = p.y+1
			-- self.object:setacceleration({x=0, y=3, z=0})
			local y = self.object:getvelocity().y
			if y > 2 then
				y = 2
			end
			if y < 0 then
			--	self.object:setacceleration({x=0, y=10, z=0})
			end
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
			self.object:setacceleration({x=0, y=0, z=0})
			if math.abs(self.object:getvelocity().y) < 1 then
				local pos = self.object:getpos()
				pos.y = math.floor(pos.y)+0.5
				self.object:setpos(pos)
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
			else
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
			end
	end
end

minetest.register_entity("hovers:hover", hover)


minetest.register_craftitem("hovers:hover", {
	description = "Hover",
	inventory_image = "hovers_inventory.png",
	wield_image = "hovers_wield.png",
	wield_scale = {x=2, y=2, z=1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		pointed_thing.under.y = pointed_thing.under.y + 1
		minetest.env:add_entity(pointed_thing.under, "hovers:hover")
		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_craft({
	output = "hovers:hover",
	recipe = {
		{"default:mese_crystal", "", "default:mese_crystal"},
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
	},
})
