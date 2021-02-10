scripts.ui.fancy = scripts.ui.fancy or {
	enabled = false
}

function scripts.ui.fancy:init()
	debugc("___________________ FANCY INIT______________\n")
	self.ui_ready_handler = scripts.event_register:register_singleton_event_handler(self.ui_ready_handler, "uiReady", function () self:setup() end)
end

function scripts.ui.fancy:setup()
	debugc("___________________ SETUP ______________\n")
	if not self.enabled then
		debugc("___________________ SETUP ret1______________\n")
		return
	end

	if not scripts.ui.fancy.enabled then
		debugc("___________________ SETUP ret2____________________________\n")
		return
	end
	debugc("___________________ SETUP override ______________\n")
	scripts.ui.fancy.object_icons = {
		["mezczyzna"] = "🧑🏻",
		["kobieta"] = "👩🏻‍🦰",
		["straznik"] = "💂",
		["elf"] = "🧝",
		["elfka"] = "🧝‍",
		["drwal"] = "🧔🏻",
		["ogr"] = "👹",
		["ogrzyca"] = "👹",
		["krasnolud"] = "🎅🏻",
		["krasnoludka"] = "🎅🏻",
		["gnom"] = "👨🏽‍🦰",
		["gnomka"] = "👩🏽‍🦰",
		["niziolek"] = "👨🏻‍🍳",
		["halfling"] = "👨🏻‍🍳",
		["niziolka"] = "👨🏻‍🍳",
		["halflinka"] = "👨🏻‍🍳",
		["wilk"] = "🐺",
		["zajac"] = "🐰",
		["krolik"] = "🐰",
		["lis"] = "🦊",
		["mysz"] = "🐭",
		["szczur"] = "",
		["krowa"] = "🐮",
		["swinia"] = "🐷",
		["niedzwiedz"] = "🐻",
		["smok"] = "🐲",
		["pies"] = "🐕",
		["waz"] = "🐍",
		["nietoperz"] = "🦇",
		["kogut"] = "🐔",
		["kura"] = "",
		["kon"] = "🐴",
		["wiewiorka"] = "🐿",
		["kot"] = "🐱",
		["jaszczurka"] = "🦎",
		["jaszczur"] = "🦎",
		["kaczka"] = "🦆",
		["owca"] = "🐑",
		["koza"] = "🐐",
		["baran"] = "🐏",
		["dzik"] = "🐗",
		["zombie"] = "🧟",
		["ghoul"] = "🧟",
		["szkielet"] = "💀",
		["kosciotrup"] = "💀",
		["goblin"] = "👺",
		["dziewczynka"] = "👧🏻",
		["chlopiec"] = "👦🏻",
		["dziecko"] = "👶🏻"
	}

	states = { [6] = "<green>▇▇▇▇▇▇▇😎<reset>", [5] = "<dark_green>▇<green>▇▇▇▇▇▇🙂<reset>", [4] = "<ansi_yellow>▇▇<yellow>▇▇▇▇▇😐<reset>", [3] = "<saddle_brown>▇▇▇<orange>▇▇▇▇😕<reset>", [2] = "<ansi_red>▇▇▇▇<red>▇▇▇😞<reset>", [1] = "<ansi_red>▇▇▇▇▇<deep_pink>▇▇😫<reset>", [0] = "<ansi_red>▇▇▇▇▇▇<deep_pink>▇💀<reset>" }

	states_normal = { [6] = "<ansi_cyan>▇▇▇▇▇▇▇👤<reset>", [5] = "<dark_slate_grey>▇<ansi_cyan>▇▇▇▇▇▇👤<reset>", [4] = "<dark_slate_grey>▇▇<ansi_cyan>▇▇▇▇▇👤<reset>", [3] = "<dark_slate_grey>▇▇▇<ansi_cyan>▇▇▇▇👤<reset>", [2] = "<dark_slate_grey>▇▇▇▇<ansi_cyan>▇▇▇👤<reset>", [1] = "<dark_slate_grey>▇▇▇▇▇<cyan>▇▇👤<reset>", [0] = "<dark_slate_grey>▇▇▇▇▇▇<cyan>▇💀<reset>" }

	states_enemy = { [6] = "<firebrick>▇▇▇▇▇▇▇😈<reset>", [5] = "<ansi_red>▇<firebrick>▇▇▇▇▇▇😈<reset>", [4] = "<ansi_red>▇▇<firebrick>▇▇▇▇▇👿<reset>", [3] = "<ansi_red>▇▇▇<firebrick>▇▇▇▇👿<reset>", [2] = "<ansi_red>▇▇▇▇<red>▇▇▇😡<reset>", [1] = "<ansi_red>▇▇▇▇▇<red>▇▇🥵<reset>", [0] = "<ansi_red>▇▇▇▇▇▇<deep_pink>▇💀<reset>" }

	states_enemy_no_color = { [6] = "▇▇▇▇▇▇▇😈", [5] = "▇▇▇▇▇▇▇😈", [4] = "▇▇▇▇▇▇▇👿", [3] = "▇▇▇▇▇▇▇👿", [2] = "▇▇▇▇▇▇▇😡", [1] = "▇▇▇▇▇▇▇🥵", [0] = "▇▇▇▇▇▇▇💀" }

	scripts.ui:setup_states_window()
	debugc("___________________ FANCY END ______________\n")
end
debugc("___________________ FANCY LOADED______________\n")
scripts.ui.fancy:init()