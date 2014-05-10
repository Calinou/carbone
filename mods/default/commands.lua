kill_list = {}
hp_list = {}

minetest.register_chatcommand("hp", {
	params = "<name> <hp>",
	description = "Change a player's health points, setting it to 0 kills them",
	privs = {give=true},
	func = function(name, param)
		if param == "" then
			minetest.chat_send_player(name, "Usage: /hp <name> <hp>")
			return
		end
		user, hp = string.match(param, " *([%w%-]+) *(%d*)")
		hp = tonumber(hp) 
		if type(hp) ~= "number" then
			minetest.chat_send_player(name, "You must supply a positive integer.")
			return
		end
		if minetest.env:get_player_by_name(user) then
			table.insert(hp_list, {user, hp})
			minetest.chat_send_player(name, user .. "'s HP was set to " .. hp .. ".")
			minetest.log("action", name .. " has set " .. user .. "'s HP to " .. hp .. ".")
			return
		end
	end
})


minetest.register_globalstep(
   function(dtime)
			for j,hps in ipairs(hp_list) do
				minetest.env:get_player_by_name(hps[1]):set_hp(hps[2])                            
				table.remove(hp_list,j)
			end
	end
)

--------------------------------------------------------------------------------

minetest.register_chatcommand("broadcast", {
	params = "<message>",
	description = "Broadcast a message anonymously",
	privs = {ban=true},
	func = function(name, param)
		if param == "" then
			minetest.chat_send_player(name, "Usage: /broadcast <message>")
			return
		end
			minetest.chat_send_all("*** " .. param)
			minetest.log("action", name .. " broadcast \"" .. param .. "\".")
			return
		end
})

--------------------------------------------------------------------------------

-- Texture Stick code by PilzAdam.

minetest.register_craftitem("default:infotool", {
    description = "Infotool",
    inventory_image = "default_infotool.png",
    wield_image = "default_infotool.png^[transformR90",
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
