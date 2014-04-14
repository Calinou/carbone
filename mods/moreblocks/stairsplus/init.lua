
-- Nodes will be called <modname>:{stair,slab,panel,micro}_<subname>

local modpath = minetest.get_modpath("moreblocks").."/stairsplus"

stairsplus = {}
stairsplus.expect_infinite_stacks = false

if not minetest.get_modpath("unified_inventory") and
		minetest.setting_getbool("creative_mode") then
	stairsplus.expect_infinite_stacks = true
end

function stairsplus:register_all(modname, subname, recipeitem, fields)
	fields = fields or {}
	fields.groups = fields.groups or {}
	if not moreblocks.config.show_stairsplus_creative_inv then
		fields.groups.not_in_creative_inventory = 1
	end
	self:register_stair(modname, subname, recipeitem, fields)
	self:register_slab (modname, subname, recipeitem, fields)
	self:register_panel(modname, subname, recipeitem, fields)
	self:register_micro(modname, subname, recipeitem, fields)
	self:register_6dfacedir_conversion(modname, subname)
	circular_saw.known_nodes[recipeitem] = {modname, subname}
end

function register_stair_slab_panel_micro(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_all(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light
	})
end

dofile(modpath.."/conversion.lua")
dofile(modpath.."/stairs.lua")
dofile(modpath.."/slabs.lua")
dofile(modpath.."/panels.lua")
dofile(modpath.."/microblocks.lua")
dofile(modpath.."/aliases.lua")
dofile(modpath.."/registrations.lua")

