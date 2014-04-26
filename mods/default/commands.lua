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
            minetest.log("action", name .. " has set " .. user .. "'s HP to " .. hp ..".")
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



