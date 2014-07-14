minetest.register_on_newplayer(function(player)
	minetest.log("action", player:get_player_name() .. " joined for the first time.")
	if minetest.setting_getbool("give_initial_stuff") then
		minetest.log("action", "Giving initial stuff to player " .. player:get_player_name() .. ".")
		player:get_inventory():add_item("main", "default:pick_wood")
		player:get_inventory():add_item("main", "default:torch 10")
		player:get_inventory():add_item("main", "default:sapling 10")
		player:get_inventory():add_item("main", "default:apple 10")
		player:get_inventory():add_item("main", "default:chest_locked 1")
		player:get_inventory():add_item("main", "default:furnace_locked 1")
	end
end)

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [give_initial_stuff] loaded.")
end
