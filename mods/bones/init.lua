-- Minetest 0.4 mod: bones
-- See README.txt for licensing and other information.

local function is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name then
		return true
	end
	return false
end

gui_slots = "listcolors[#606060AA;#808080;#101010;#202020;#FFF]"

minetest.register_node("bones:bones", {
	description = "Bones",
	tiles = {"bones_bones.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	climbable = true,
	drowning = 2,
	light_source = 11,
	drawtype = "glasslike_framed",
	post_effect_color = {a=96, r= 0, g= 0, b= 0},
	drop = "",
	groups = {dig_immediate = 3},

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		return is_owner(pos, player:get_player_name()) or inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if meta:get_string("owner") ~= "" and meta:get_inventory():is_empty("main") then
			meta:set_string("infotext", meta:get_string("owner").."'s old bones")
			meta:set_string("formspec", "")
			meta:set_string("owner", "")
		end
	end,

	on_punch = function(pos, node, player)
		if not is_owner(pos, player:get_player_name()) then return end

		local inv = minetest.get_meta(pos):get_inventory()
		local player_inv = player:get_inventory()
		local has_space = true

		for i= 1,inv:get_size("main") do
			local stk = inv:get_stack("main", i)
			if player_inv:room_for_item("main", stk) then
				inv:set_stack("main", i, nil)
				player_inv:add_item("main", stk)
			else
				has_space = false
				break
			end
		end

		-- Remove bones if player emptied them.
		if has_space then minetest.dig_node(pos) end
	end,

	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local publish = 600
		if tonumber(minetest.setting_get("bones_share_time")) then
			publish = tonumber(minetest.setting_get("bones_share_time"))
		end
		if publish == 0 then
			return
		end
		if minetest.get_gametime() >= meta:get_int("time") + publish then
			meta:set_string("infotext", meta:get_string("owner").."'s old bones")
			meta:set_string("owner", "")
		else
			return true
		end
	end,
})

minetest.register_on_dieplayer(function(player)
	local pos = player:getpos()
	minetest.sound_play("player_death", {pos = pos, gain = 1})
	pos.x = math.floor(pos.x + 0.5)
	pos.y = math.floor(pos.y + 0.5)
	pos.z = math.floor(pos.z + 0.5)
	local param2 = minetest.dir_to_facedir(player:get_look_dir())
	local player_name = player:get_player_name()
	local player_inv = player:get_inventory()
	minetest.chat_send_all("[#] " .. player_name .. " died at " ..
	minetest.pos_to_string(pos) .. ".")
	minetest.log("action", player_name .. " died at " ..
	minetest.pos_to_string(pos) .. ".")
	
	-- Don't do anything below in creative mode or on players without interact.
	if minetest.setting_getbool("creative_mode") or minetest.setting_getbool("keep_items_on_death")
	or not minetest.check_player_privs(player_name, {interact = true}) then return end

	local nn = minetest.get_node(pos).name
	if minetest.registered_nodes[nn].can_dig and
		not minetest.registered_nodes[nn].can_dig(pos, player) then

		-- Drop items instead of delete.
		for i= 1,player_inv:get_size("main") do
			minetest.add_item(pos, player_inv:get_stack("main", i))
		end
		for i= 1,player_inv:get_size("craft") do
			minetest.add_item(pos, player_inv:get_stack("craft", i))
		end
		player_inv:set_list("main", {})	-- Empty the main inventory.
		player_inv:set_list("craft", {}) -- Empty the crafting grid, as it can store items.
		return
	end

	minetest.dig_node(pos)
	minetest.add_node(pos, {name="bones:bones", param2= param2})

	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("main", 8*4)
	inv:set_list("main", player_inv:get_list("main"))
	player_inv:set_list("main", {})
	player_inv:set_list("craft", {})

	for i= 1,player_inv:get_size("craft") do
		local stack = player_inv:get_stack("craft", i)
		if inv:room_for_item("main", stack) then
			inv:add_item("main", stack)
		else
			minetest.add_item(pos, stack) -- Drop items as entities if there's no space.
		end
	end

	meta:set_string("formspec", "size[8,9;]" .. gui_slots ..
			"list[current_name;main;0,0;8,4;]" ..
			"list[current_player;main;0,5;8,4;]" ..
			default.get_hotbar_bg(0, 5) ..
			default.get_hotbar_bg(0, 6))
	meta:set_string("infotext", player_name .. "'s fresh bones")
	meta:set_string("owner", player_name)
	meta:set_int("time", minetest.get_gametime())

	local timer = minetest.get_node_timer(pos)
	timer:start(10)
end)

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [bones] loaded.")
end
