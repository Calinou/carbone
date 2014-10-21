dofile(minetest.get_modpath("mobs").."/api.lua")

mobs:register_mob("mobs:dirt_monster", {
	type = "monster",
	hp_max = 25,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.x",
	textures = {"mobs_dirt_monster.png"},
	visual_size = {x = 3, y = 2.6},
	makes_footstep_sound = true,
	view_range = 12,
	walk_velocity = 1.1,
	run_velocity = 2.6,
	on_rightclick = nil,
	damage = 4,
	drops = {
		name = "default:dirt",
		chance = 1,
		min = 4,
		max = 4,
		{name = "maptools:silver_coin",
		chance = 1,
		min = 2,
		max = 2,},
	},
	armor = 100,
	drawtype = "front",
	lava_damage = 8,
	light_damage = 1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 18,
		speed_run = 50,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	},
})

minetest.register_craftitem("mobs:dirt_monster", {
	description = "Dirt Monster",
	inventory_image = "mobs_dirt_monster.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:dirt_monster")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a dirt monster at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

mobs:register_mob("mobs:stone_monster", {
	type = "monster",
	hp_max = 30,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.x",
	textures = {"mobs_stone_monster.png"},
	visual_size = {x = 3, y = 2.6},
	makes_footstep_sound = true,
	view_range = 16,
	walk_velocity = 0.4,
	run_velocity = 1.8,
	damage = 6,
	drops = {
		{name = "default:stone",
		chance = 1,
		min = 4,
		max = 4,},
		{name = "maptools:silver_coin",
		chance = 1,
		min = 3,
		max = 3,},
	},
	armor = 80,
	drawtype = "front",
	light_damage = 1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 8,
		speed_run = 40,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	}
})

minetest.register_craftitem("mobs:stone_monster", {
	description = "Stone Monster",
	inventory_image = "mobs_stone_monster.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:stone_monster")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a stone monster at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

mobs:register_mob("mobs:sand_monster", {
	type = "monster",
	hp_max = 15,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_sand_monster.x",
	textures = {"mobs_sand_monster.png"},
	visual_size = {x =8,y =8},
	makes_footstep_sound = true,
	view_range = 20,
	walk_velocity = 1.8,
	run_velocity = 3.6,
	damage = 2,
	drops = {
		{name = "default:sand",
		chance = 1,
		min = 4,
		max = 4,},
		{name = "maptools:silver_coin",
		chance = 1,
		min = 3,
		max = 3,},
	},
	armor = 100,
	drawtype = "front",
	lava_damage = 8,
	light_damage = 1,
	attack_type = "dogfight",
	animation = {
		speed_normal = 35,
		speed_run = 45,
		stand_start = 0,
		stand_end = 39,
		walk_start = 41,
		walk_end = 72,
		run_start = 74,
		run_end = 105,
		punch_start = 74,
		punch_end = 105,
	},
})

minetest.register_craftitem("mobs:sand_monster", {
	description = "Sand Monster",
	inventory_image = "mobs_sand_monster.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:sand_monster")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a sand monster at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

mobs:register_mob("mobs:sheep", {
	type = "animal",
	hp_max = 15,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {"mobs_sheep.png"},
	visual = "mesh",
	mesh = "mobs_sheep.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 100,
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 2,},
		{name = "maptools:copper_coin",
		chance = 1,
		min = 5,
		max = 5,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 8,
	animation = {
		speed_normal = 17,
		stand_start = 0,
		stand_end = 80,
		walk_start = 81,
		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 6,
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "farming:wheat" then
			if not self.tamed then
				if not minetest.setting_getbool("creative_mode") then
					item:take_item()
					clicker:set_wielded_item(item)
				end
				self.tamed = true
				self.object:set_hp(self.object:get_hp() + 3)
				if self.object:get_hp() > 15 then self.object:set_hp(15) end
			else
				if not minetest.setting_getbool("creative_mode") and self.naked then
					item:take_item()
					clicker:set_wielded_item(item)
				end
				self.food = (self.food or 0) + 1
				if self.food >= 8 then
					self.food = 0
					self.naked = false
					self.object:set_properties({
						textures = {"mobs_sheep.png"},
						mesh = "mobs_sheep.x",
					})
				end
				self.object:set_hp(self.object:get_hp() + 3)
				if self.object:get_hp() > 15 then self.object:set_hp(15) return end
				if not self.naked then
					item:take_item()
					clicker:set_wielded_item(item)
				end
			end
			return
		end
		if clicker:get_inventory() and not self.naked then
			self.naked = true
			if minetest.registered_items["wool:white"] then
				clicker:get_inventory():add_item("main", ItemStack("wool:white 2"))
				clicker:get_inventory():add_item("main", ItemStack("maptools:copper_coin"))
				minetest.sound_play("default_snow_footstep", {object = self.object, gain = 0.5,})
			end
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.x",
			})
		end
	end,
})

minetest.register_craftitem("mobs:sheep", {
	description = "Sheep",
	inventory_image = "mobs_sheep.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:sheep")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a sheep at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

minetest.register_craftitem("mobs:meat_raw", {
	description = "Raw Meat",
	inventory_image = "mobs_meat_raw.png",
})

minetest.register_craftitem("mobs:meat", {
	description = "Meat",
	inventory_image = "mobs_meat.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:meat",
	recipe = "mobs:meat_raw",
	cooktime = 25,
})

mobs:register_mob("mobs:rat", {
	type = "animal",
	hp_max = 1,
	collisionbox = {-0.25, -0.01, -0.25, 0.25, 0.35, 0.25},
	collide_with_objects = false,
	visual = "mesh",
	mesh = "mobs_rat.x",
	textures = {"mobs_rat.png"},
	makes_footstep_sound = false,
	walk_velocity = 0.8,
	armor = 200,
	drops = {
		{name = "mobs:rat",
		chance = 1,
		min = 1,
		max = 1,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 8,
	follow = "default:scorched_stuff",
	view_range = 4,
})

minetest.register_craftitem("mobs:rat", {
	description = "Rat",
	inventory_image = "mobs_rat_inventory.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:rat")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a rat at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})
	
minetest.register_craftitem("mobs:rat_cooked", {
	description = "Cooked Rat",
	inventory_image = "mobs_cooked_rat.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	type = "cooking",
	output = "mobs:rat_cooked",
	recipe = "mobs:rat",
	cooktime = 15,
})

minetest.register_craft({
	type = "cooking",
	output = "default:scorched_stuff",
	recipe = "mobs:rat_cooked",
	cooktime = 10,
})

minetest.register_craft({
	type = "shapeless",
	output = "dye:black",
	recipe = {"default:scorched_stuff"},
})

mobs:register_mob("mobs:oerkki", {
	type = "monster",
	hp_max = 45,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_oerkki.x",
	textures = {"mobs_oerkki.png"},
	visual_size = {x =5, y =5},
	makes_footstep_sound = false,
	view_range = 16,
	walk_velocity = 0.5,
	run_velocity = 3,
	damage = 5,
	drops = {
		{name = "default:obsidian",
		chance = 1,
		min = 4,
		max = 4,},
		{name = "maptools:silver_coin",
		chance = 1,
		min = 5,
		max = 5,},
	},
	armor = 100,
	drawtype = "front",
	lava_damage = 8,
	light_damage = 1,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 23,
		walk_start = 24,
		walk_end = 36,
		run_start = 37,
		run_end = 49,
		punch_start = 37,
		punch_end = 49,
		speed_normal = 10,
		speed_run = 18,
	},
})

minetest.register_craftitem("mobs:oerkki", {
	description = "Oerkki",
	inventory_image = "mobs_oerkki.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:oerkki")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed an oerkki at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

mobs:register_mob("mobs:tree_monster", {
	type = "monster",
	hp_max = 60,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_tree_monster.x",
	textures = {"mobs_tree_monster.png"},
	visual_size = {x = 4.5,y = 4.5},
	makes_footstep_sound = true,
	view_range = 32,
	walk_velocity = 0,
	run_velocity = 1.6,
	damage = 6,
	drops = {
		{name = "default:sapling",
		chance = 1,
		min = 4,
		max = 4,},
		{name = "default:junglesapling",
		chance = 1,
		min = 4,
		max = 4,},
		{name = "maptools:silver_coin",
		chance = 1,
		min = 6,
		max = 6,},
	},
	armor = 80,
	drawtype = "front",
	lava_damage = 8,
	light_damage = 1,
	disable_fall_damage = true,
	attack_type = "dogfight",
	animation = {
		speed_normal = 8,
		speed_run = 20,
		stand_start = 0,
		stand_end = 24,
		walk_start = 25,
		walk_end = 47,
		run_start = 48,
		run_end = 62,
		punch_start = 48,
		punch_end = 62,
	},
})

minetest.register_craftitem("mobs:tree_monster", {
	description = "Tree Monster",
	inventory_image = "mobs_tree_monster.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:tree_monster")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a tree monster at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

mobs:register_mob("mobs:trooper", {
	type = "monster",
	hp_max = 20,
	collisionbox = {-0.3, -1.0, -0.3, 0.3, 0.8, 0.3},
	visual = "mesh",
	mesh = "character.x",
	textures = {"character.png"},
	visual_size = {x = 1, y = 1},
	makes_footstep_sound = true,
	view_range = 8,
	lava_damage = 8,
	walk_velocity = 1.6,
	run_velocity = 3.2,
	damage = 2,
	drops = {
		{name = "mobs:trooper",
		chance = 1,
		min = 1,
		max = 1,},
	},
	armor = 100,
	drawtype = "front",
	attack_type = "dogfight",
	animation = {
		speed_normal = 17,
		speed_run = 35,
		stand_start = 0,
		stand_end = 40,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	}
})

minetest.register_craftitem("mobs:trooper", {
	description = "Trooper",
	inventory_image = "player.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			pointed_thing.above.y = pointed_thing.above.y + 0.5
			minetest.add_entity(pointed_thing.above, "mobs:trooper")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a trooper at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

mobs:register_mob("mobs:dungeon_master", {
	type = "monster",
	hp_max = 50,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 2.6, 0.7},
	visual = "mesh",
	mesh = "mobs_dungeon_master.x",
	textures = {"mobs_dungeon_master.png"},
	visual_size = {x =8, y =8},
	makes_footstep_sound = true,
	view_range = 12,
	walk_velocity = 0.4,
	run_velocity = 2,
	damage = 10,
	drops = {
		{name = "default:mese_crystal",
		chance = 1,
		min = 1,
		max = 1,},
		{name = "maptools:silver_coin",
		chance = 1,
		min = 8,
		max = 8,},
	},
	armor = 60,
	drawtype = "front",
	lava_damage = 8,
	light_damage = 200,
	on_rightclick = nil,
	attack_type = "shoot",
	arrow = "mobs:fireball",
	shoot_interval = 2.5,
	sounds = {
		attack = "mobs_fireball",
	},
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 8,
		speed_run = 5,
	},
})

minetest.register_craftitem("mobs:dungeon_master", {
	description = "Dungeon Master",
	inventory_image = "mobs_dungeon_master.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:dungeon_master")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a dungeon master at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

mobs:register_arrow("mobs:fireball", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"mobs_fireball.png"},
	velocity = 9,
	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x = s.x - p.x, y = s.y - p.y, z = s.z - p.z}
		player:punch(self.object, 1.0,  {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 10},
		}, vec)
		local pos = self.object:getpos()
		for dx = -1, 1 do
			for dy = -1, 1 do
				for dz = -1, 1 do
					local p = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}
					local n = minetest.get_node(pos).name
					if n ~= "bedrock:bedrock"
					and n ~= "default:chest_locked"
					and n ~= "bones:bones"
					and n ~= "default:chest"
					and n ~= "default:furnace" then
						minetest.dig_node(p)
					end
						minetest.sound_play("mobs_fireball_explode", {
						pos = pos,
						gain = 0.1,
						max_hear_distance = 48})
				end
			end
		end
	end,
	hit_node = function(self, pos, node)
		for dx = -1, 1 do
			for dy = -2, 1 do
				for dz = -1, 1 do
					local p = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}
					local n = minetest.get_node(pos).name
					if n ~= "bedrock:bedrock"
					and n ~= "default:chest_locked"
					and n ~= "bones:bones"
					and n ~= "default:chest"
					and n ~= "default:furnace" then
						minetest.dig_node(p)
					end
						minetest.sound_play("mobs_fireball_explode", {
						pos = pos,
						gain = 0.1,
						max_hear_distance = 48})
				end
			end
		end
	end
})

mobs:register_mob("mobs:rhino", {
	type = "monster",
	hp_max = 25,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
	visual = "mesh",
	mesh = "mobs_sand_monster.x",
	textures = {"mobs_rhino.png"},
	visual_size = {x = 8, y = 8},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 1.2,
	run_velocity = 2.4,
	damage = 2,
	drops = {
		{name = "default:steel_ingot",
		chance = 1,
		min = 10,
		max = 10,},
		{name = "maptools:silver_coin",
		chance = 1,
		min = 12,
		max = 12,},
	},
	armor = 60,
	drawtype = "front",
	lava_damage = 8,
	light_damage = 1,
	on_rightclick = nil,
	attack_type = "shoot",
	arrow = "mobs:bullet",
	shoot_interval = 0.5,
	sounds = {
		attack = "mobs_bullet",
	},
	animation = {
		speed_normal = 25,
		speed_run = 45,
		stand_start = 0,
		stand_end = 39,
		walk_start = 41,
		walk_end = 72,
		run_start = 74,
		run_end = 105,
		punch_start = 74,
		punch_end = 105,
	},
})

minetest.register_craftitem("mobs:rhino", {
	description = "Rhino",
	inventory_image = "mobs_rhino.png",
	wield_scale = {x = 1.25, y = 1.25, z = 2.5},
	groups = {not_in_creative_inventory = 1},
	
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.above then
			minetest.add_entity(pointed_thing.above, "mobs:rhino")
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item() end
			minetest.log("action", placer:get_player_name() .. " placed a rhino at " .. minetest.pos_to_string(pointed_thing.above) .. ".")
		end
		return itemstack
	end,
})

mobs:register_arrow("mobs:bullet", {
	visual = "sprite",
	visual_size = {x = 0.75, y = 0.75},
	textures = {"mobs_bullet.png"},
	velocity = 18,
	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x =s.x-p.x, y =s.y-p.y, z =s.z-p.z}
		player:punch(self.object, 1.0,  {
			full_punch_interval= 1.0,
			damage_groups = {fleshy = 2},
		}, vec)
		local pos = self.object:getpos()
		for dx = -1, 1 do
			for dy = -1, 1 do
				for dz = -1, 1 do
					local p = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}
					local n = minetest.get_node(pos).name
				end
			end
		end
	end,
	hit_node = function(self, pos, node)
		for dx = -1, 1 do
			for dy = -2, 1 do
				for dz = -1, 1 do
					local p = {x = pos.x + dx, y = pos.y + dy, z = pos.z + dz}
					local n = minetest.get_node(pos).name
				end
			end
		end
	end
})

-- mobs:register_spawn(name, description, nodes, max_light, min_light, chance, active_object_count, max_height)

if not minetest.setting_getbool("creative_mode") then
	if minetest.setting_getbool("spawn_friendly_mobs") ~= false then -- “If not defined or set to true then”
		local rn = {"default:stone", "default:leaves", "default:jungleleaves", "default:cactus"}
		local sn = {"default:dirt_with_grass"}
		mobs:register_spawn("mobs:rat", "two rats",                    rn, 16, -1, 7500, 6, 100)
		mobs:register_spawn("mobs:sheep", "a sheep",                   sn, 16, 8, 20000, 2, 100)
	end
	if minetest.setting_getbool("spawn_hostile_mobs") ~= false then -- “If not defined or set to true then”
		local mn = {"default:stone", "default:desert_stone"}
		local tn = {"default:dirt_with_grass", "default:sand", "default:desert_sand", "default:dirt_with_snow"}
		mobs:register_spawn("mobs:dirt_monster", "a dirt monster",     mn, 1, -1, 15000, 6, 0)
		mobs:register_spawn("mobs:stone_monster", "a stone monster",   mn, 1, -1, 15000, 4, 0)
		mobs:register_spawn("mobs:sand_monster", "a sand monster",     mn, 1, -1, 15000, 4, 0)
		mobs:register_spawn("mobs:oerkki", "an oerkki",                mn, 1, -1, 20000, 4, 0)
		mobs:register_spawn("mobs:tree_monster", "a tree monster",     mn, 1, -1, 25000, 2, 0)
		
		mobs:register_spawn("mobs:dungeon_master", "a dungeon master", mn, 1, -1, 25000, 2, -50)
		mobs:register_spawn("mobs:rhino", "a rhino",                   mn, 1, -1, 25000, 2, 0)
	end
	if minetest.setting_getbool("spawn_troopers") ~= false then -- “If not defined or set to true then”
		local tn = {"default:dirt_with_grass", "default:sand", "default:desert_sand", "default:dirt_with_snow"}
		mobs:register_spawn("mobs:trooper", "a trooper",               tn, 16, -1, 50000, 4, 100)
	end
end

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [mobs] loaded.")
end
