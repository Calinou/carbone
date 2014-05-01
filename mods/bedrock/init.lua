-- A simple bedrock mod by jn and Calinou.

local bedrock = {}

bedrock.layer = -30912 -- Determined as appropriate by experiment. May change in the future.

minetest.register_on_generated(function(minp, maxp)
	if maxp.y >= bedrock.layer and minp.y <= bedrock.layer then
		local pos = {y = bedrock.layer}
		for x = minp.x,maxp.x do
		for z = minp.z,maxp.z do
			pos.x=x; pos.z=z
			minetest.env:set_node(pos, {name = "bedrock:bedrock"})
		end
		end
	end
end)

minetest.register_node("bedrock:bedrock", {
	description = "Bedrock",
	tile_images = {"bedrock.png"},
	groups = {unbreakable = 1},
	sounds = default.node_sound_stone_defaults(),
})
