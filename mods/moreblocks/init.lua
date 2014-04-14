--[[
-- More Blocks (moreblocks) by Calinou
-- Licensed under the zlib/libpng license for code and CC BY-SA for textures, see LICENSE.txt for info.
--]]

moreblocks = {}

-- Load translation library if intllib is installed

local S = nil
if intllib then
	S = intllib.Getter()
else
	S = function(s) return s end
end
moreblocks.gettext = S

local modpath = minetest.get_modpath("moreblocks")

dofile(modpath.."/config.lua")
dofile(modpath.."/circular_saw.lua")
dofile(modpath.."/stairsplus/init.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/redefinitions.lua")
dofile(modpath.."/crafting.lua")
dofile(modpath.."/aliases.lua")

if minetest.setting_getbool("log_mod") then
	print(S("[moreblocks] loaded."))
end

