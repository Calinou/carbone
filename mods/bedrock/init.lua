-- A simple bedrock mod by jn and Calinou.

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "bedrock:bedrock",
	wherein        = "default:stone",
	clust_scarcity = 1*1*1,
	clust_num_ores = 5,
	clust_size     = 2,
	height_min     = -30912,
	height_max     = -30896,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "bedrock:bedrock",
	wherein        = "air",
	clust_scarcity = 1*1*1,
	clust_num_ores = 5,
	clust_size     = 2,
	height_min     = -30912,
	height_max     = -30896,
})

minetest.register_node("bedrock:bedrock", {
	description = "bedrock",
	tile_images = {"bedrock_bedrock.png"},
	groups = {unbreakable = 1},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})
