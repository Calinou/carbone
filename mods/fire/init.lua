-- minetest/fire/init.lua

minetest.register_node("fire:basic_flame", {
	description = "Fire",
	stack_max = 10000,
	range = 12,
	drawtype = "plantlike",
	tiles = {{
		name = "fire_basic_flame_animated.png",
		animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.75},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {igniter = 2, dig_immediate = 3, hot = 3},
	drop = "",
	walkable = false,
	buildable_to = true,
	damage_per_second = 3,
	post_effect_color = {a = 128, r = 64, g = 64, b = 64},
	after_place_node = function(pos, placer)
		fire.on_flame_add_at(pos)
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		fire.on_flame_remove_at(pos)
	end,
})

fire = {}
fire.D = 6
-- key: position hash of low corner of area
-- value: {handle=sound handle, name=sound name}
fire.sounds = {}

function fire.get_area_p0p1(pos)
	local p0 = {
		x =math.floor(pos.x / fire.D) * fire.D,
		y =math.floor(pos.y / fire.D) * fire.D,
		z =math.floor(pos.z / fire.D) * fire.D,
	}
	local p1 = {
		x = p0.x + fire.D - 1,
		y = p0.y + fire.D - 1,
		z = p0.z + fire.D - 1
	}
	return p0, p1
end

function fire.update_sounds_around(pos)
	local p0, p1 = fire.get_area_p0p1(pos)
	local cp = {x = (p0.x + p1.x) / 2, y = (p0.y + p1.y) / 2, z = (p0.z + p1.z) / 2}
	local flames_p = minetest.find_nodes_in_area(p0, p1, {"fire:basic_flame"})
	--  print("number of flames at "..minetest.pos_to_string(p0).."/"
	--	..minetest.pos_to_string(p1)..": "..#flames_p)
	local should_have_sound = (#flames_p > 0)
	local wanted_sound = nil
	if #flames_p >= 12 then
		wanted_sound = {name = "fire_large"}
	elseif #flames_p > 0 then
		wanted_sound = {name = "fire_small"}
	end
	local p0_hash = minetest.hash_node_position(p0)
	local sound = fire.sounds[p0_hash]
	if not sound then
		if should_have_sound then
			fire.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos = cp, loop = true}),
				name = wanted_sound.name,
			}
		end
	else
		if not wanted_sound then
			minetest.sound_stop(sound.handle)
			fire.sounds[p0_hash] = nil
		elseif sound.name ~= wanted_sound.name then
			minetest.sound_stop(sound.handle)
			fire.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos = cp, loop = true}),
				name = wanted_sound.name,
			}
		end
	end
end

function fire.on_flame_add_at(pos)
	-- print("flame added at "..minetest.pos_to_string(pos))
	fire.update_sounds_around(pos)
end

function fire.on_flame_remove_at(pos)
	-- print("flame removed at "..minetest.pos_to_string(pos))
	fire.update_sounds_around(pos)
end

function fire.find_pos_for_flame_around(pos)
	return minetest.find_node_near(pos, 1, {"air"})
end

function fire.flame_should_extinguish(pos)
	if minetest.setting_getbool("disable_fire") then return true end
	-- return minetest.find_node_near(pos, 1, {"group:puts_out_fire"})
	local p0 = {x = pos.x - 2, y = pos.y, z = pos.z - 2}
	local p1 = {x = pos.x + 2, y = pos.y, z = pos.z + 2}
	local ps = minetest.find_nodes_in_area(p0, p1, {"group:puts_out_fire"})
	return (#ps ~= 0)
end

-- Ignite neighboring nodes
minetest.register_abm({
	nodenames = {"group:flammable"},
	neighbors = {"group:igniter"},
	interval = 2,
	chance = 10,
	action = function(p0, node, _, _)
		-- If there is water or stuff like that around flame, don't ignite.
		if fire.flame_should_extinguish(p0) then
			return
		end
		local p = fire.find_pos_for_flame_around(p0)
		if p then
			minetest.set_node(p, {name = "fire:basic_flame"})
			fire.on_flame_add_at(p)
		end
	end,
})

-- Rarely ignite things from far.
--[[
minetest.register_abm({
	nodenames = {"group:igniter"},
	neighbors = {"air"},
	interval = 2,
	chance = 5,
	action = function(p0, node, _, _)
		local reg = minetest.registered_nodes[node.name]
		if not reg or not reg.groups.igniter or reg.groups.igniter < 2 then
			return
		end
		local d = reg.groups.igniter
		local p = minetest.find_node_near(p0, d, {"group:flammable"})
		if p then
			-- If there is water or stuff like that around flame, don"t ignite
			if fire.flame_should_extinguish(p) then
				return
			end
			local p2 = fire.find_pos_for_flame_around(p)
			if p2 then
				minetest.set_node(p2, {name="fire:basic_flame"})
				fire.on_flame_add_at(p2)
			end
		end
	end,
})
--]]

-- Remove flammable nodes and flame
minetest.register_abm({
	nodenames = {"fire:basic_flame"},
	interval = 2,
	chance = 2,
	action = function(p0, node, _, _)
		-- If there is water or stuff like that around flame, remove flame
		if fire.flame_should_extinguish(p0) then
			minetest.dig_node(p0)
			fire.on_flame_remove_at(p0)
			return
		end
		-- Make the following things rarer.
		if math.random(1, 3) == 1 then
			return
		end
		-- If there are no flammable nodes around flame, remove flame..
		if not minetest.find_node_near(p0, 1, {"group:flammable"}) then
			minetest.dig_node(p0)
			fire.on_flame_remove_at(p0)
			return
		end
		if math.random(1, 4) == 1 then
			-- Remove a flammable node around flame.
			local p = minetest.find_node_near(p0, 1, {"group:flammable"})
			if p then
				-- If there is water or stuff like that around flame, don"t remove.
				if fire.flame_should_extinguish(p0) then
					return
				end
				minetest.dig_node(p)
			end
		else
			-- Remove flame.
			minetest.remove_node(p0)
			fire.on_flame_remove_at(p0)
		end
	end,
})

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [fire] loaded.")
end
