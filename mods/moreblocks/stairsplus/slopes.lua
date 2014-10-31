local S -- Load translation library if intllib is installed:
if intllib then
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function(s) return s end
end

-- Node will be called <modname>:slope_<subname>

function register_slope(modname, subname, recipeitem, groups, images, description, drop, light)
	return stairsplus:register_slope(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_slope(modname, subname, recipeitem, fields)
	local defs = {
		[""] = {
			mesh = "moreblocks_slope.obj",
		},
		["_half"] = {
			mesh = "moreblocks_slope_half.obj",
		},
	}

	local desc = S("%s Slope"):format(fields.description)
	for alternate, def in pairs(defs) do
		def.drawtype = "mesh"
		def.paramtype = "light"
		def.paramtype2 = "facedir"
		def.on_place = minetest.rotate_node
		for k, v in pairs(fields) do
			def[k] = v
		end
		def.description = desc
		if fields.drop then
			def.drop = modname.. ":slope_" ..fields.drop..alternate
		end
		minetest.register_node(":" ..modname.. ":slope_" ..subname..alternate, def)
	end

	-- Some saw-less recipes:
	
	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. " 10"
		recipe = {
			{modname .. ":stair_" .. subname, "", ""},
			{recipeitem, modname .. ":stair_" .. subname, ""},
			{recipeitem, recipeitem, modname .. ":stair_" .. subname},
		}
	})

	minetest.register_craft({
		output = modname .. ":slope_" .. subname .. " 10",
		recipe = {
			{"", "", modname .. ":stair_" .. subname},
			{"", modname .. ":stair_" .. subname, recipeitem},
			{modname .. ":stair_" .. subname, recipeitem, recipeitem},
		},
	})
end
