worldedit = worldedit or {}
worldedit.version = {major=1, minor=0}
worldedit.version_string = "1.0"

local path = minetest.get_modpath(minetest.get_current_modname())

local loadmodule = function(path)
	local file = io.open(path)
	if not file then
		return
	end
	file:close()
	return dofile(path)
end

loadmodule(path .. "/manipulations.lua")
loadmodule(path .. "/primitives.lua")
loadmodule(path .. "/visualization.lua")
loadmodule(path .. "/serialization.lua")
loadmodule(path .. "/code.lua")
loadmodule(path .. "/compatibility.lua")

if minetest.setting_get("log_mods") then
	minetest.log("action", "[worldedit] loaded.")
end
