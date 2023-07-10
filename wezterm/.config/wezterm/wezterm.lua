-- Pull in the wezterm API
local wezterm = require 'wezterm'

local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
local mykeys = {}

for i = 1, 8 do
    table.insert(mykeys, {
        key = tostring(i),
        mods = 'ALT',
        action = { ActivateTab = i - 1 }
    })
end

table.insert(mykeys, { key = 'c', mods = 'ALT', action = act.ActivateCopyMode })
table.insert(mykeys, { key = 's', mods = 'ALT', action = act.Search({ CaseSensitiveString = '' }) })
table.insert(mykeys, { key = 'f', mods = 'ALT', action = 'ToggleFullScreen' })
table.insert(mykeys, { key = 'n', mods = 'ALT', action = act({ SpawnTab = 'CurrentPaneDomain' }) })

table.insert(mykeys, { key = '[', mods = 'ALT', action = act.MoveTabRelative(-1) })
table.insert(mykeys, { key = ']', mods = 'ALT', action = act.MoveTabRelative(1) })

table.insert(mykeys, { key = '-', mods = 'ALT', action = act({ SplitVertical = { domain = 'CurrentPaneDomain' } }) })
table.insert(mykeys,
    { key = '\\', mods = 'ALT', action = act({ SplitHorizontal = { domain = 'CurrentPaneDomain' } }) })

table.insert(mykeys, { key = 'h', mods = 'ALT', action = act({ ActivatePaneDirection = 'Left' }) })
table.insert(mykeys, { key = 'j', mods = 'ALT', action = act({ ActivatePaneDirection = 'Down' }) })
table.insert(mykeys, { key = 'k', mods = 'ALT', action = act({ ActivatePaneDirection = 'Up' }) })
table.insert(mykeys, { key = 'l', mods = 'ALT', action = act({ ActivatePaneDirection = 'Right' }) })

table.insert(mykeys, { key = 'h', mods = 'ALT|SHIFT', action = act.AdjustPaneSize({ 'Left', 1 }) })
table.insert(mykeys, { key = 'j', mods = 'ALT|SHIFT', action = act.AdjustPaneSize({ 'Down', 1 }) })
table.insert(mykeys, { key = 'k', mods = 'ALT|SHIFT', action = act.AdjustPaneSize({ 'Up', 1 }) })
table.insert(mykeys, { key = 'l', mods = 'ALT|SHIFT', action = act.AdjustPaneSize({ 'Right', 1 }) })

config.keys = mykeys

config.font = wezterm.font('Hack Nerd Font Mono', { weight = 'Medium', italic = false, stretch = 'Normal' })

config.harfbuzz_features = {
    'calt=1',
    'clig=1',
    'liga=1',
    'zero',
    'onum',
    'ss1',
    'ss2',
    'ss3',
    'ss4',
    'ss5',
    'ss6',
    'ss7',
    'ss8',
    'ss9',
    'ss10',
    'cv01',
    'cv02',
    'cv03',
    'cv04',
    'cv05',
    'cv06',
    'cv07',
    'cv08',
    'cv09',
    'cv10',
    'cv11',
    'cv12',
    'cv13',
    'cv14',
    'cv15',
    'cv16',
    'cv17',
    'cv18',
    'cv19',
    'cv20',
    'cv21',
    'cv22',
    'cv23',
    'cv24',
    'cv25',
    'cv26',
    'cv27',
    'cv28',
    'cv29',
    'cv30',
    'cv31',
}

config.audible_bell = 'Disabled'
config.window_background_opacity = 0.9
config.scrollback_lines = 10000

-- and finally, return the configuration to wezterm
return config
