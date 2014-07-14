--	AWARDS
--		by Rubenwardy, CC-BY-SA
-------------------------------------------------------
-- this is the init file for the award mod
-------------------------------------------------------

local S
if (intllib) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function ( s ) return s end
end

dofile(minetest.get_modpath("awards").."/api.lua")

-- Light it up
awards.register_achievement("award_lightitup",{
	title = S("Light It Up"),
	description = S("Place 100 torches."),
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "default:torch",
		target = 100
	}
})

-- Light ALL the things!
awards.register_achievement("award_light_all_the_things",{
	title = S("Light ALL The Things!"),
	description = S("Place 1,000 torches."),
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "default:torch",
		target = 1000
	}
})


-- Saint-Maclou
awards.register_achievement("award_saint_maclou",{
	title = S("Saint-Maclou"),
	description = S("Place 20 coal checkers."),
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "moreblocks:coal_checker",
		target = 20
	}
})

-- Castorama
awards.register_achievement("award_castorama",{
	title = S("Castorama"),
	description = S("Place 20 iron checkers."),
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "moreblocks:iron_checker",
		target = 20
	}
})

-- Sam the Trapper
awards.register_achievement("award_sam_the_trapper",{
	title = S("Sam the Trapper"),
	description = S("Place 2 trap stones."),
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "moreblocks:trap_stone",
		target = 2
	}
})

-- Cave Street
awards.register_achievement("award_cave_street",{
	title = S("Cave Street"),
	description = S("Mine a coin ore."),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone_with_coin",
		target = 1
	}
})

-- Obsessed with Obsidian
awards.register_achievement("award_obsessed_with_obsidian",{
	title = S("Obsessed with Obsidian"),
	description = S("Mine 50 obsidian."),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:obsidian",
		target = 50
	}
})

-- On the way
awards.register_achievement("award_on_the_way",{
	title = S("On The Way"),
	description = S("Place 100 rails."),
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "default:rail",
		target = 100
	}
})

-- Lumberjack
awards.register_achievement("award_lumberjack",{
	title = S("Lumberjack"),
	description = S("Dig 100 tree blocks."),
	trigger = {
		type = "dig",
		node = "default:tree",
		target = 100
	}
})

-- Semi-pro Lumberjack
awards.register_achievement("award_semipro_lumberjack",{
	title = S("Semi-pro Lumberjack"),
	description = S("Dig 1,000 tree blocks."),
	trigger = {
		type = "dig",
		node = "default:tree",
		target = 1000
	}
})

-- Professional Lumberjack
awards.register_achievement("award_professional_lumberjack",{
	title = S("Professional Lumberjack"),
	description = S("Dig 10,000 tree blocks."),
	trigger = {
		type = "dig",
		node = "default:tree",
		target = 10000
	}
})

-- L33T Lumberjack
awards.register_achievement("award_leet_lumberjack",{
	title = S("L33T Lumberjack"),
	description = S("Dig 100,000 tree blocks."),
	trigger = {
		type = "dig",
		node = "default:tree",
		target = 100000
	}
})

-- Junglebaby
awards.register_achievement("award_junglebaby",{
	title = S("Junglebaby"),
	description = S("Dig 100 jungle tree blocks."),
	trigger = {
		type = "dig",
		node = "default:jungletree",
		target = 100
	}
})

-- Jungleman
awards.register_achievement("award_jungleman",{
	title = S("Jungleman"),
	description = S("Dig 1,000 jungle tree blocks."),
	trigger = {
		type = "dig",
		node = "default:jungletree",
		target = 1000
	}
})

-- Found some Mese!
awards.register_achievement("award_mesefind",{
	title = S("First Mese Find"),
	description = S("Find some Mese."),
	icon = "mese.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:mese",
		target = 1
	}
})

-- You're a copper
awards.register_achievement("award_youre_a_copper",{
	title = S("You're a copper"),
	description = S("Dig 1,000 copper ores."),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone_with_copper",
		target = 1000
	}
})

-- You're winner
awards.register_achievement("award_youre_winner",{
	title = S("YOU'RE WINNER!"),
	description = S("Dig 1 mossy cobblestone."),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:mossycobble",
		target = 1
	},
	secret = true,
})

-- Found a Nyan cat!
awards.register_achievement("award_nyanfind",{
	title = S("OMG, Nyan Cat!"),
	description = S("Find a nyan cat."),
	trigger = {
		type = "dig",
		node = "default:nyancat",
		target = 1
	}
})

-- Just entered the mine
awards.register_achievement("award_mine1",{
	title = S("Entering the mine"),
	description = S("Dig 10 stone blocks."),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 10
	}
})

-- Mini Miner
awards.register_achievement("award_mine2",{
	title = S("Mini Miner"),
	description = S("Dig 100 stone blocks."),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 100
	}
})

-- Hardened Miner
awards.register_achievement("award_mine3",{
	title = S("Hardened Miner"),
	description = S("Dig 1,000 stone blocks"),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 1000
	}
})

-- Master Miner
awards.register_achievement("award_mine4",{
	title = S("Master Miner"),
	description = S("Dig 10,000 stone blocks."),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 10000
	}
})

-- Marchand de sable
awards.register_achievement("award_marchand_de_sable",{
	title = S("Marchand De Sable"),
	description = S("Dig 1,000 sand."),
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:sand",
		target = 1000
	}
})

-- First Death
awards.register_achievement("award_death1",{
	title = S("First Death"),
	description = S("You have more lives than a cat!"),
	trigger = {
		type = "death",
		target = 1
	}
})

-- Dying Spree
awards.register_achievement("award_dying_spree",{
	title = S("Dying Spree"),
	description = S("Die 5 times."),
	trigger = {
		type = "death",
		target = 5
	}
})

-- Bot-like
awards.register_achievement("award_bot_like",{
	title = S("Bot-like"),
	description = S("Die 10 times."),
	trigger = {
		type = "death",
		target = 10
	}
})

-- You Suck!
awards.register_achievement("award_you_suck",{
	title = S("You Suck!"),
	description = S("Die 100 times."),
	trigger = {
		type = "death",
		target = 100
	},
	secret = true
})

-- Burned to death
awards.register_achievement("award_burn",{
	title = S("You're a witch!"),
	description = S("Burn to death in a fire.")
})

-- Died in flowing lava
awards.register_achievement("award_in_the_flow",{
	title = S("In the Flow"),
	description = S("Die in flowing lava.")
})

-- Die near diamond ore
awards.register_achievement("award_this_is_sad",{
	title = S("This is Sad"),
	description = S("Die near diamond ore.")
})

-- Die near diamond ore
awards.register_achievement("award_the_stack",{
	title = S("The Stack"),
	description = S("Die near bones.")
})

-- Join
awards.register_achievement("award_join1",{
	title = S("Welcome! Press ESCAPE to continue."),
	description = S("Connect to the server."),
	trigger = {
		type = "join",
		target = 1
	}
})

awards.register_achievement("award_join2",{
	title = S("Frequent Visitor"),
	description = S("Connect to the server 50 times."),
	trigger = {
		type = "join",
		target = 50
	},
	secret = true
})

awards.register_onDeath(function(player,data)
	local pos = player:getpos()
	if pos and minetest.find_node_near(pos, 2, "fire:basic_flame") ~= nil then
		return "award_burn"
	end	
	return nil
end)

awards.register_onDeath(function(player,data)
	local pos = player:getpos()
	if pos and minetest.find_node_near(pos, 2, "default:lava_flowing") ~= nil then
		return "award_in_the_flow"
	end	
	return nil
end)

awards.register_onDeath(function(player,data)
	local pos = player:getpos()
	if pos and minetest.find_node_near(pos, 5, "default:stone_with_diamond") ~= nil then
		return "award_this_is_sad"
	end	
	return nil
end)

awards.register_onDeath(function(player,data)
	local pos = player:getpos()
	if pos and minetest.find_node_near(pos, 5, "bones:bones") ~= nil then
		return "award_the_stack"
	end	
	return nil
end)
