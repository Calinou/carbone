-- Reference
-- ports = get_real_portstates(pos): gets if inputs are powered from outside
-- newport = merge_portstates(state1, state2): just does result = state1 or state2 for every port
-- action_setports(pos, rule, state): activates/deactivates the mesecons according to the portstates (helper for action)
-- action(pos, ports): Applies new portstates to a luacontroller at pos
-- lc_update(pos): updates the controller at pos by executing the code
-- reset_meta (pos, code, errmsg): performs a software-reset, installs new code and prints error messages
-- reset (pos): performs a hardware reset, turns off all ports
--
-- The Sandbox
-- The whole code of the controller runs in a sandbox,
-- a very restricted environment.
-- However, as this does not prevent you from using e.g. loops,
-- we need to check for these prohibited commands first.
-- Actually the only way to damage the server is to
-- use too much memory from the sandbox.
-- You can add more functions to the environment
-- (see where local env is defined)
-- Something nice to play is is appending minetest.env to it.

local BASENAME = "mesecons_luacontroller:luacontroller"

local rules = {}
rules.a = {x = -1, y = 0, z =  0, name="A"}
rules.b = {x =  0, y = 0, z =  1, name="B"}
rules.c = {x =  1, y = 0, z =  0, name="C"}
rules.d = {x =  0, y = 0, z = -1, name="D"}

------------------
-- Action stuff --
------------------
-- These helpers are required to set the portstates of the luacontroller

function lc_update_real_portstates(pos, rulename, newstate)
	local meta = minetest.get_meta(pos)
	if rulename == nil then
		meta:set_int("real_portstates", 1)
		return
	end
	local n = meta:get_int("real_portstates") - 1
	if n < 0 then
		legacy_update_ports(pos)
		n = meta:get_int("real_portstates") - 1
	end
	local L = {}
	for i = 1, 4 do
		L[i] = n%2
		n = math.floor(n/2)
	end
	if rulename.x == nil then
		for _, rname in ipairs(rulename) do
			local port = ({4, 1, nil, 3, 2})[rname.x+2*rname.z+3]
			L[port] = (newstate == "on") and 1 or 0
		end
	else
		local port = ({4, 1, nil, 3, 2})[rulename.x+2*rulename.z+3]
		L[port] = (newstate == "on") and 1 or 0
	end
	meta:set_int("real_portstates", 1 + L[1] + 2*L[2] + 4*L[3] + 8*L[4])
end

local get_real_portstates = function(pos) -- determine if ports are powered (by itself or from outside)
	local meta = minetest.get_meta(pos)
	local L = {}
	local n = meta:get_int("real_portstates") - 1
	if n < 0 then
		return legacy_update_ports(pos)
	end
	for _, index in ipairs({"a", "b", "c", "d"}) do
		L[index] = ((n%2) == 1)
		n = math.floor(n/2)
	end
	return L
end

local merge_portstates = function (ports, vports)
	local npo = {a=false, b=false, c=false, d=false}
	npo.a = vports.a or ports.a
	npo.b = vports.b or ports.b
	npo.c = vports.c or ports.c
	npo.d = vports.d or ports.d
	return npo
end

local generate_name = function (ports)
	local overwrite = overwrite or {}
	local d = ports.d and 1 or 0
	local c = ports.c and 1 or 0
	local b = ports.b and 1 or 0
	local a = ports.a and 1 or 0
	return BASENAME..d..c..b..a
end

local setport = function (pos, rule, state)
	if state then
		mesecon:receptor_on(pos, {rule})
	else
		mesecon:receptor_off(pos, {rule})
	end
end

local action = function (pos, ports)
	local node = minetest.get_node(pos)
	local name = node.name
	local vports = minetest.registered_nodes[name].virtual_portstates
	local newname = generate_name(ports)

	if name ~= newname and vports then
		local rules_on  = {}
		local rules_off = {}

		minetest.swap_node(pos, {name = newname, param2 = node.param2})

		if ports.a ~= vports.a then setport(pos, rules.a, ports.a) end
		if ports.b ~= vports.b then setport(pos, rules.b, ports.b) end
		if ports.c ~= vports.c then setport(pos, rules.c, ports.c) end
		if ports.d ~= vports.d then setport(pos, rules.d, ports.d) end
	end
end

--------------------
-- Overheat stuff --
--------------------

local overheat_off = function(pos)
	mesecon:receptor_off(pos, mesecon.rules.flat)
end

-------------------
-- Parsing stuff --
-------------------

local code_prohibited = function(code)
	-- Clean code
	local prohibited = {"while", "for", "repeat", "until", "function", "goto"}
	for _, p in ipairs(prohibited) do
		if string.find(code, p) then
			return "Prohibited command: "..p
		end
	end
end

local safe_print = function(param)
	print(dump(param))
end

deep_copy = function(original, visited) --deep copy that removes functions
	visited = visited or {}
	if visited[original] ~= nil then --already visited this node
		return visited[original]
	end
	if type(original) == 'table' then --nested table
		local copy = {}
		visited[original] = copy
		for key, value in next, original, nil do
			copy[deep_copy(key, visited)] = deep_copy(value, visited)
		end
		setmetatable(copy, deep_copy(getmetatable(original), visited))
		return copy
	elseif type(original) == 'function' then --ignore functions
		return nil
	else --by-value type
		return original
	end
end

local safe_serialize = function(value)
	return minetest.serialize(deep_copy(value))
end

mesecon.queue:add_function("lc_interrupt", function (pos, iid, luac_id)
	-- There is no luacontroller anymore / it has been reprogrammed / replaced
	if (minetest.get_meta(pos):get_int("luac_id") ~= luac_id) then return end
	lc_update(pos, {type="interrupt", iid = iid})
end)

local getinterrupt = function(pos)
	local interrupt = function (time, iid) -- iid = interrupt id
		if type(time) ~= "number" then return end
		luac_id = minetest.get_meta(pos):get_int("luac_id")
		mesecon.queue:add_action(pos, "lc_interrupt", {iid, luac_id}, time, iid, 1)
	end
	return interrupt
end

local getdigiline_send = function(pos)
	if not digiline then return end
	-- Send messages on next serverstep
	return function(channel, msg)
		minetest.after(0, function()
			digiline:receptor_send(pos, digiline.rules.default, channel, msg)
		end)
	end
end

local create_environment = function(pos, mem, event)
	-- Gather variables for the environment
	local vports = minetest.registered_nodes[minetest.get_node(pos).name].virtual_portstates
	vports = {a = vports.a, b = vports.b, c = vports.c, d = vports.d}
	local rports = get_real_portstates(pos)

	return {
			print = safe_print,
			pin = merge_portstates(vports, rports),
			port = vports,
			interrupt = getinterrupt(pos),
			digiline_send = getdigiline_send(pos),
			mem = mem,
			tostring = tostring,
			tonumber = tonumber,
			heat = minetest.get_meta(pos):get_int("heat"),
			heat_max = OVERHEAT_MAX,
			string = {
				byte = string.byte,
				char = string.char,
				find = string.find,
				format = string.format,
				gmatch = string.gmatch,
				gsub = string.gsub,
				len = string.len,
				lower = string.lower,
				upper = string.upper,
				match = string.match,
				rep = string.rep,
				reverse = string.reverse,
				sub = string.sub,
			},
			math = {
				abs = math.abs,
				acos = math.acos,
				asin = math.asin,
				atan = math.atan,
				atan2 = math.atan2,
				ceil = math.ceil,
				cos = math.cos,
				cosh = math.cosh,
				deg = math.deg,
				exp = math.exp,
				floor = math.floor,
				fmod = math.fmod,
				frexp = math.frexp,
				huge = math.huge,
				ldexp = math.ldexp,
				log = math.log,
				log10 = math.log10,
				max = math.max,
				min = math.min,
				modf = math.modf,
				pi = math.pi,
				pow = math.pow,
				rad = math.rad,
				random = math.random,
				sin = math.sin,
				sinh = math.sinh,
				sqrt = math.sqrt,
				tan = math.tan,
				tanh = math.tanh,
			},
			table = {
				insert = table.insert,
				maxn = table.maxn,
				remove = table.remove,
				sort = table.sort
			},
			event = event,
	}
end

local create_sandbox = function (code, env)
	-- Create Sandbox
	if code:byte(1) == 27 then
		return _, "You Hacker You! Don't use binary code!"
	end
	f, msg = loadstring(code)
	if not f then return _, msg end
	setfenv(f, env)
	return f
end

local lc_overheat = function (pos, meta)
	if mesecon.do_overheat(pos) then -- if too hot
		local node = minetest.get_node(pos)
		minetest.swap_node(pos, {name = BASENAME.."_burnt", param2 = node.param2})
		minetest.after(0.2, overheat_off, pos) -- wait for pending operations
		return true
	end
end

local load_memory = function(meta)
	return minetest.deserialize(meta:get_string("lc_memory")) or {}
end

local save_memory = function(meta, mem)
	meta:set_string("lc_memory", safe_serialize(mem))
end

local ports_invalid = function (var)
	if type(var) == "table" then
		return false
	end
	return "The ports you set are invalid"
end

----------------------
-- Parsing function --
----------------------

lc_update = function (pos, event)
	local meta = minetest.get_meta(pos)
	if lc_overheat(pos) then return end

	-- load code & mem from memory
	local mem  = load_memory(meta)
	local code = meta:get_string("code")

	-- make sure code is ok and create environment
	local prohibited = code_prohibited(code)
	if prohibited then return prohibited end
	local env = create_environment(pos, mem, event)

	-- create the sandbox and execute code
	local chunk, msg = create_sandbox (code, env)
	if not chunk then return msg end
	local success, msg = pcall(f)
	if not success then return msg end
	if ports_invalid(env.port) then return ports_invalid(env.port) end

	save_memory(meta, mem)

	-- Actually set the ports
	action(pos, env.port)
end

local reset_meta = function(pos, code, errmsg)
	local meta = minetest.get_meta(pos)
	meta:set_string("code", code)
	code = minetest.formspec_escape(code or "")
	errmsg = minetest.formspec_escape(errmsg or "")
	meta:set_string("formspec", "size[10,8]"..
		"background[-0.2,-0.25;10.4,8.75;jeija_luac_background.png]"..
		"textarea[0.2,0.6;10.2,5;code;;"..code.."]"..
		"image_button[3.75,6;2.5,1;jeija_luac_runbutton.png;program;]"..
		"image_button_exit[9.72,-0.25;0.425,0.4;jeija_close_window.png;exit;]"..
		"label[0.1,5;"..errmsg.."]")
	meta:set_int("heat", 0)
	meta:set_int("luac_id", math.random(1, 1000000))
end

local reset = function (pos)
	action(pos, {a=false, b=false, c=false, d=false})
end

--        ______
--       |
--       |
--       |        __       ___  _   __         _  _
-- |   | |       |  | |\ |  |  |_| |  | |  |  |_ |_|
-- |___| |______ |__| | \|  |  | \ |__| |_ |_ |_ |\
-- |
-- |
--

-----------------------
-- Node Registration --
-----------------------

local output_rules={}
local input_rules={}

local nodebox = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -8/16, 8/16, -7/16, 8/16 }, -- bottom slab
			{ -5/16, -7/16, -5/16, 5/16, -6/16, 5/16 }, -- circuit board
			{ -3/16, -6/16, -3/16, 3/16, -5/16, 3/16 }, -- IC
		}
	}

local selectionbox = {
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -5/16, 8/16 },
	}

local digiline = {
	receptor = {},
	effector = {
		action = function (pos, node, channel, msg)
			lc_update (pos, {type = "digiline", channel = channel, msg = msg})
		end
	}
}

for a = 0, 1 do -- 0 = off; 1 = on
for b = 0, 1 do
for c = 0, 1 do
for d = 0, 1 do

local cid = tostring(d)..tostring(c)..tostring(b)..tostring(a)
local nodename = BASENAME..cid
local top = "jeija_luacontroller_top.png"
if a == 1 then
	top = top.."^jeija_luacontroller_LED_A.png"
end
if b == 1 then
	top = top.."^jeija_luacontroller_LED_B.png"
end
if c == 1 then
	top = top.."^jeija_luacontroller_LED_C.png"
end
if d == 1 then
	top = top.."^jeija_luacontroller_LED_D.png"
end

if a + b + c + d ~= 0 then
	groups = {dig_immediate=2, not_in_creative_inventory=1, overheat = 1}
else
	groups = {dig_immediate=2, overheat = 1}
end

output_rules[cid] = {}
input_rules[cid] = {}
if (a == 1) then table.insert(output_rules[cid], rules.a) end
if (b == 1) then table.insert(output_rules[cid], rules.b) end
if (c == 1) then table.insert(output_rules[cid], rules.c) end
if (d == 1) then table.insert(output_rules[cid], rules.d) end

if (a == 0) then table.insert(input_rules[cid], rules.a) end
if (b == 0) then table.insert(input_rules[cid], rules.b) end
if (c == 0) then table.insert(input_rules[cid], rules.c) end
if (d == 0) then table.insert(input_rules[cid], rules.d) end

local mesecons = {
	effector =
	{
		rules = input_rules[cid],
		action_change = function (pos, _, rulename, newstate)
			lc_update_real_portstates(pos, rulename, newstate)
			lc_update(pos, {type=newstate,  pin=rulename})
		end,
	},
	receptor =
	{
		state = mesecon.state.on,
		rules = output_rules[cid]
	}
}

minetest.register_node(nodename, {
	description = "Luacontroller",
	drawtype = "nodebox",
	tiles = {
		top,
		"jeija_microcontroller_bottom.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png"
		},

	inventory_image = top,
	paramtype = "light",
	groups = groups,
	drop = BASENAME.."0000",
	sunlight_propagates = true,
	selection_box = selectionbox,
	node_box = nodebox,
	on_construct = reset_meta,
	on_receive_fields = function(pos, formname, fields)
		if not fields.program then
			return
		end
		reset(pos)
		reset_meta(pos, fields.code)
		local err = lc_update(pos, {type="program"})
		if err then
			print(err)
			reset_meta(pos, fields.code, err)
		end
	end,
	on_timer = handle_timer,
	sounds = default.node_sound_stone_defaults(),
	mesecons = mesecons,
	digiline = digiline,
	virtual_portstates = {	a = a == 1, -- virtual portstates are
				b = b == 1, -- the ports the the
				c = c == 1, -- controller powers itself
				d = d == 1},-- so those that light up
	after_dig_node = function (pos, node)
		mesecon:receptor_off(pos, output_rules)
	end,
	is_luacontroller = true,
})
end
end
end
end

------------------------------
-- overheated luacontroller --
------------------------------

local mesecons_burnt = {
	effector =
	{
		rules = mesecon.rules.flat,
		action_change = function (pos, _, rulename, newstate)
			-- only update portstates when changes are triggered
			lc_update_real_portstates(pos, rulename, newstate)
		end
	}
}

minetest.register_node(BASENAME .. "_burnt", {
	drawtype = "nodebox",
	tiles = {
		"jeija_luacontroller_burnt_top.png",
		"jeija_microcontroller_bottom.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png"
	},
	inventory_image = "jeija_luacontroller_burnt_top.png",
	paramtype = "light",
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	drop = BASENAME.."0000",
	sunlight_propagates = true,
	selection_box = selectionbox,
	node_box = nodebox,
	on_construct = reset_meta,
	on_receive_fields = function(pos, formname, fields)
		if fields.quit then
			return
		end
		reset(pos)
		reset_meta(pos, fields.code)
		local err = lc_update(pos, {type="program"})
		if err then
			print(err)
			reset_meta(pos, fields.code, err)
		end
	end,
	sounds = default.node_sound_stone_defaults(),
	virtual_portstates = {a = false, b = false, c = false, d = false},
	mesecons = mesecons_burnt,
})

------------------------
-- Craft Registration --
------------------------

minetest.register_craft({
	output = BASENAME.."0000 2",
	recipe = {
		{'mesecons_materials:silicon', 'mesecons_materials:silicon', 'group:mesecon_conductor_craftable'},
		{'mesecons_materials:silicon', 'mesecons_materials:silicon', 'group:mesecon_conductor_craftable'},
		{'group:mesecon_conductor_craftable', 'group:mesecon_conductor_craftable', ''},
	}
})

