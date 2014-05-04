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

-- Pro Lumberjack
awards.register_achievement("award_pro_lumberjack",{
	title = S("Semi-pro Lumberjack"),
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

-- Burned to death
awards.register_achievement("award_burn",{
	title = S("You're a witch!"),
	description = S("Burn to death in a fire.")
})

-- 1 sentence
awards.register_achievement("award_chat1",{
	title = S("First Word"),
	description = S("Use the chat to talk to players."),
	trigger = {
		type = "chat",
		target = 1
	}
})

-- Talkative
awards.register_achievement("award_talkative",{
	title = S("Talkative"),
	description = S("Talk a lot. 1,000 lines."),
	trigger = {
		type = "chat",
		target = 1000
	},
	secret = true,
})

-- More Talkative
awards.register_achievement("award_more_talkative",{
	title = S("More Talkative"),
	description = S("Talk a lot. Really, a lot. 10,000 lines."),
	trigger = {
		type = "chat",
		target = 10000
	},
	secret = true,
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
	if pos and minetest.find_node_near(pos, 1, "fire:basic_flame") ~= nil then
		return "award_burn"
	end	
	return nil
end)
