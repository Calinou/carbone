minetest.register_node("snow:snow_brick", {
	description = "Snow Brick",
	tiles = {"snow_snow_brick.png"},
	groups = {cracky = 2},
	drop = "snow:snow_brick",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
    output = "snow:snow_brick 4",
    recipe = {
        {"default:snowblock", "default:snowblock"},
        {"default:snowblock", "default:snowblock"},
    },
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:dirt_with_snow",
	wherein        = "default:dirt_with_grass",
	clust_scarcity = 1*1*1,
	clust_num_ores = 5,
	clust_size     = 2,
	height_min     = 30, 
	height_max     = 31000,
})
