-- Hyprland loads this file when it is started without a config, and it prefers
-- it over hyprland.conf. HyDE loads it too, last, as the override layer below.
-- The block keeps the two apart: hyde.lua sets `hyde` on its first line, so it
-- runs only when this file is the entry point and HyDE has not been loaded.
-- Removing it leaves a session with a cursor and nothing else.
if not hyde then
	local share = os.getenv("XDG_DATA_HOME") or (os.getenv("HOME") .. "/.local/share")
	local entry = share .. "/hypr/hyde.lua"
	local handle = io.open(entry, "r")
	if not handle then
		error("HyDE is not installed at " .. entry .. ". Run install.sh -r, or point Hyprland at your own config.")
	end
	handle:close()
	dofile(entry)
end

hl.config({
    input = {
		kb_layout = "fr",
		natural_scroll = false,
		touchpad = {
			natural_scroll = true,
		},
	},
	general = {
		border_size = 2,
		gaps_in = 3,
		gaps_out = 5,
		layout = "master", -- other options: "master", "monocle", "scrolling"
	},
	-- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
	master = {
		mfact = 0.55, -- master area size ratio
		orientation = "left",
	},

	decoration = {
		active_opacity = 1,
		fullscreen_opacity = 1,
		inactive_opacity = 0.75,
		rounding = 15,
		rounding_power = 2,
		blur = {
			enabled = true,
			contrast = 1,
			brightness = 0.8,
		},
	},
})

-- Overriding the code bind since it's a vim bind and I don't use vim, I use code.
hl.bind(hyde.config.modifiers.main .. " + C", hl.dsp.exec_cmd("code"), {
	description = "[Launcher|Apps] code editor",
})

-- Add a bind for the firefox browser, since the default one is brave
hl.bind(hyde.config.modifiers.main .. " + F", hl.dsp.exec_cmd("firefox"), {
	description = "[Launcher|Apps] web browser",
})

-- Remove the bind for the Browser
hl.unbind(hyde.config.modifiers.main .. " + B") 

-- Changing the bind for the help menu
hl.unbind(hyde.config.modifiers.main .. " + slash")
hl.bind(hyde.config.modifiers.main .. " + H", hl.dsp.exec_cmd(hyde.sh.menu.binds()), {
	description = "[Launcher|Apps] help menu",
})

-- Remove the calculator bind, it doesn't work
hl.unbind(hyde.config.modifiers.main.. " + SHIFT + K")

-- Master layout swapwithmaster
hl.bind(hyde.config.modifiers.main .. " + B", hl.dsp.layout("swapwithmaster"), {
	description = "[Layout Management|Master] swap focused window with master",
})

-- Remove the bind for the split layout, because it's dwindle and not master
hl.unbind(hyde.config.modifiers.main .. " + J")


hl.unbind("CTRL + ALT + DELETE") -- Remove the bind for the logout, because I don't use it

_F = {description = "[Window Management] logout menu"}
hl.bind(hyde.config.modifiers.main .. " + BACKSPACE", hl.dsp.exec_cmd(hyde.sh.session.logout.launcher()), _F)


-- Unbinding all the bind for the workspaces that are after the workspace 5
-- This is because they is too many and they are flooding the help menu, and I don't use them anyway. I will rebind the ones I want to use later on.

local kp = {
    [1] = {"KP_1", "KP_End"},
    [2] = {"KP_2", "KP_Down"},
    [3] = {"KP_3", "KP_Next"},
    [4] = {"KP_4", "KP_Left"},
    [5] = {"KP_5", "KP_Begin"},
    [6] = {"KP_6", "KP_Right"},
    [7] = {"KP_7", "KP_Home"},
    [8] = {"KP_8", "KP_Up"},
    [9] = {"KP_9", "KP_Prior"},
    [10] = {"KP_0", "KP_Insert"}
}

for i = 5, 10 do
    hl.unbind(hyde.config.modifiers.main .. " + ALT + " .. ((i == 10) and 0 or i))
end
for i = 5, 10 do
    hl.unbind(hyde.config.modifiers.main .. " + SHIFT + " .. ((i == 10) and 0 or i))
end

for i = 5, 10 do
    hl.unbind(hyde.config.modifiers.main .. " + " .. ((i == 10) and 0 or i))
end

for i = 1, 10 do
    for _, key in ipairs(kp[i]) do
        hl.unbind(hyde.config.modifiers.main .. " + " .. key)
    end
end

for i = 1, 10 do
    for _, key in ipairs(kp[i]) do
        hl.unbind(
            hyde.config.modifiers.main .. " + SHIFT + " .. key
        )
    end
end

-- Your Hyprland configuration. HyDE never overwrites this file.
--
-- It loads after HyDE's own binds, so settings here take precedence. Replacing
-- a bind needs more than that: see below. HyDE's defaults live in
-- ~/.local/share/hypr/lua/ and are overwritten on every update, so edits there
-- do not survive.
--
-- Adding a keybind:
--
--     hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(hyde.sh.gamelauncher()), {
--         description = "[Utilities] game launcher",
--     })
--
-- Replacing one of HyDE's: bind the same combination again and yours takes
-- over, but copy its flags across as well. A bind counts as the same one only
-- when its flags match, and `description` is not a flag — miss one and both
-- binds stay live on that combination. Copy the whole options table from
-- ~/.local/share/hypr/lua/key_binds.lua and change only what you need:
--
--     hl.bind("F9", hl.dsp.exec_cmd(hyde.sh.volumecontrol("-o", "m")), {
--         locked = true,
--         description = "[Hardware Controls|Audio] un/mute output",
--     })
--
-- Press SUPER + / to see what is actually loaded, your own binds included.
-- The full reference is KEYBINDINGS.md in the HyDE repository.
--
-- Other Lua files next to this one can be pulled in with require("name").
