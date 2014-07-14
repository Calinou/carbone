local homes_file = minetest.get_worldpath() .. "/homes"
local homepos = {}

local function loadhomes()
    local input = io.open(homes_file, "r")
    if input then
		repeat
            local x = input:read("*n")
            if x == nil then
            	break
            end
            local y = input:read("*n")
            local z = input:read("*n")
            local name = input:read("*l")
            homepos[name:sub(2)] = {x = x, y = y, z = z}
        until input:read(0) == nil
        io.close(input)
    else
        homepos = {}
    end
end

loadhomes()

minetest.register_privilege("home", "Can use /sethome and /home")
minetest.register_privilege("spawn", "Can use /spawn")

local changed = false

minetest.register_chatcommand("home", {
    description = "Teleports you to your home point",
    privs = {home = true},
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player == nil then return false -- Check to prevent the server crashing.
        end
        if homepos[player:get_player_name()] then
            player:setpos(homepos[player:get_player_name()])
            minetest.chat_send_player(name, "[T] Teleporting to home.")
        else
            minetest.chat_send_player(name, "[T] Use /sethome to set a home first.")
        end
    end,
})

minetest.register_chatcommand("sethome", {
    description = "Sets your home point",
    privs = {home = true},
    func = function(name)
        local player = minetest.get_player_by_name(name)
        local pos = player:getpos()
        homepos[player:get_player_name()] = pos
        minetest.chat_send_player(name, "[T] Home set.")
        changed = true
        if changed then
        	local output = io.open(homes_file, "w")
            for i, v in pairs(homepos) do
                output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
            end
            io.close(output)
            changed = false
        end
    end,
})

minetest.register_chatcommand("spawn", {
    description = "Teleports you to the spawn point",
    privs = {spawn = true},
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player == nil then return false end -- Check to prevent the server crashing.
        if minetest.setting_get("static_spawnpoint") then
            player:setpos(minetest.setting_get_pos("static_spawnpoint"))
            minetest.chat_send_player(name, "[T] Teleporting to spawn.")
        else
            minetest.chat_send_player(name, "[T] No static spawn point is set.")
        end
    end,
})

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [sethome] loaded.")
end
