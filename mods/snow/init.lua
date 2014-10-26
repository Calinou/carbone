minetest.register_node("snow:snow_brick", {
	description = "Snow Brick",
	tiles = {"snow_snow_brick.png"},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
    output = "snow:snow_brick 4",
    recipe = {
        {"default:snowblock", "default:snowblock"},
        {"default:snowblock", "default:snowblock"},
    },
})

local snow_altitude = tonumber(minetest.setting_get("snow_altitude")) or 26

if minetest.setting_getbool("generate_snow") ~= false then
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:dirt_with_snow",
		wherein        = "default:dirt_with_grass",
		clust_scarcity = 1 * 1 * 1,
		clust_num_ores = 5,
		clust_size     = 2,
		height_min     = snow_altitude, 
		height_max     = 31000,
	})
	
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "air",
		wherein        = "default:junglegrass",
		clust_scarcity = 1 * 1 * 1,
		clust_num_ores = 5,
		clust_size     = 2,
		height_min     = snow_altitude, 
		height_max     = 31000,
	})
end

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [snow] loaded.")
end
