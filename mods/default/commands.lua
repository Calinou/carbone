-- Texture Stick code by PilzAdam.

minetest.register_craftitem("default:infotool", {
    description = "Infotool",
    inventory_image = "default_infotool.png",
    wield_image = "default_infotool.png^[transformR90",
    groups = {not_in_creative_inventory = 1},
    on_use = function(_, user, pt)
	if pt.type ~= "node" then
	    return
	end
	local nn = minetest.get_node(pt.under).name
	local def = minetest.registered_nodes[nn]
	if not def then
	    return
	end
	local textures = def.tiles
	local description = def.description
	if not textures then
	    textures = {"unknown_node.png"}
	end
	if not description then
	    description = {"(no description)"}
		end
	for i = 1,6 do
	    if not textures[i] then
		textures[i] = textures[i-1]
	    end
	end
	local dir = vector.subtract(pt.above, pt.under)
	local index
	-- This doesn't work for facedir or other drawtypes yet.
	if dir.y == 1 then
	    index = 1
	elseif dir.y == -1 then
	    index = 2
	else
	    if dir.x == 1 then
		index = 3
	    elseif dir.x == -1 then
		index = 4
	    else
		if dir.z == 1 then
		    index = 5
		else
		    index = 6
		end
	    end
	end
	minetest.chat_send_player(user:get_player_name(), description .. ": " .. nn .. " (" .. textures[index] .. ")")
    end,
})

minetest.register_chatcommand("info", {
	description = "Gives an Infotool, click to receive information on the pointed node",
	func = function(name)
		local receiverref = minetest.get_player_by_name(name)
		receiverref:get_inventory():add_item("main", "default:infotool")
		minetest.chat_send_player(name, "\"default:infotool\" added to inventory.")
	end,
})

minetest.register_chatcommand("clearinventory", {
	params = "<inventory>",
	description = "Clears an entire inventory, \"main\" if unspecified, \"craft\" is another possible choice",
	func = function(name, param)
	    local player = minetest.get_player_by_name(name)
	    local player_inv = player:get_inventory()
		if not player then
			minetest.log("error", "Unable to clear inventory, no player.")
			return false, "Unable to clear inventory, no player."
		end
		if param == "" then
		    player_inv:set_list("main", {})
			return true, "Inventory \"main\" cleared."
		    else
			player_inv:set_list(param, {})
			return true, "Inventory \"" .. param .. "\" cleared."
		end
	end,
})
