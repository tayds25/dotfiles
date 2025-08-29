-- Wezterm Configuration
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Load Plugins
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

config.default_prog = { "/bin/zsh" }

-- === Plugin Configuration ===

-- loads the state whenever I create a new workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
    local workspace_state = resurrect.workspace_state

    workspace_state.restore_workspace(resurrect.state_manager.load_state(label, "workspace"), {
        window = window,
        relative = true,
        restore_text = true,
        on_pane_restore = resurrect.tab_state.default_on_pane_restore,
    })
end)

-- Saves the state whenever I select a workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
    local workspace_state = resurrect.workspace_state
    resurrect.state_manager.save_state(workspace_state.get_workspace_state())
end)


-- Add the selected path to the right status bar when choosing a workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, workspace)
    local gui_win = window:gui_window()
    local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
    gui_win:set_right_status(wezterm.format({
        { Foreground = { Color = "green" } },
        { Text = base_path .. "  " },
    }))
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, workspace)
    local gui_win = window:gui_window()
    local base_path = string.gsub(workspace, "(.*[/\\])(.*)", "%2")
    gui_win:set_right_status(wezterm.format({
        { Foreground = { Color = "green" } },
        { Text = base_path .. "  " },
    }))
end)

-- Workspace Formatter
workspace_switcher.workspace_formatter = function(label)
    return wezterm.format({
        { Attribute = { Italic = true } },
        { Foreground = { Color = "#a7c080" } },
        { Text = "󱂬: " .. label },
    })
end


-- === Appearance & Theme ===
config.window_background_opacity = 0.9
config.window_padding = {
    left = 20,
    right = 20,
    top = 16,
    bottom = 16,
}

-- Everforest color schemes with custom tab bar
local selected_scheme = "Everforest Dark Hard"
local everforest_scheme = {
    foreground = '#d3c6aa',
    background = '#272e33',
    cursor_bg = '#d3c6aa',
    cursor_fg = '#2e383c',
    cursor_border = '#d3c6aa',
    selection_fg = '#9da9a0',
    selection_bg = '#464e53',
    ansi = {
        '#343f44',
        '#e67e80',
        '#a7c080',
        '#dbbc7f',
        '#7fbbb3',
        '#d699b6',
        '#83c092',
        '#859289',
    },
    brights = {
        '#868d80',
        '#e67e80',
        '#a7c080',
        '#dbbc7f',
        '#7fbbb3',
        '#d699b6',
        '#83c092',
        '#9da9a0',
    }
}

-- Custom tab bar colors based on Everforest theme
local C_ACTIVE_BG = everforest_scheme.selection_bg
local C_ACTIVE_FG = everforest_scheme.ansi[6] -- cyan
local C_BG = everforest_scheme.background
local C_HL_1 = everforest_scheme.ansi[5] -- magenta
local C_HL_2 = everforest_scheme.ansi[4] -- blue
local C_INACTIVE_FG = everforest_scheme.ansi[8] -- gray

-- Add tab bar configuration to the scheme
everforest_scheme.tab_bar = {
    background = C_BG,
    new_tab = {
        bg_color = C_BG,
        fg_color = C_HL_2,
    },
    active_tab = {
        bg_color = C_ACTIVE_BG,
        fg_color = C_ACTIVE_FG,
    },
    inactive_tab = {
        bg_color = C_BG,
        fg_color = C_INACTIVE_FG,
    },
    inactive_tab_hover = {
        bg_color = C_BG,
        fg_color = C_INACTIVE_FG,
    }
}

config.color_schemes = {
    [selected_scheme] = everforest_scheme,
}
-- Set your preferred color scheme here:
config.color_scheme = selected_scheme

-- === Tab Bar Configuration ===
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- Custom tab title formatting
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    if tab.is_active then
        return {
            {Foreground={Color=C_HL_1}},
            {Text=" " .. tab.tab_index+1},
            {Foreground={Color=C_HL_2}},
            {Text=": "},
            {Foreground={Color=C_ACTIVE_FG}},
            {Text=tab.active_pane.title .. " "},
            {Background={Color=C_BG}},
            {Foreground={Color=C_HL_1}},
            {Text="|"},
        }
    end
    return {
        {Foreground={Color=C_HL_1}},
        {Text=" " .. tab.tab_index+1},
        {Foreground={Color=C_HL_2}},
        {Text=": "},
        {Foreground={Color=C_INACTIVE_FG}},
        {Text=tab.active_pane.title .. " "},
        {Foreground={Color=C_HL_1}},
        {Text="|"},
    }
end)

-- === Font ===
config.font = wezterm.font_with_fallback { 'JetBrainsMono Nerd Font' }
config.font_size = 11.0

-- === Cursor ===
config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_rate = 800

-- === Scrollback ===
config.scrollback_lines = 10000

-- === Preferences ===
config.audible_bell = 'Disabled'
config.window_close_confirmation = 'NeverPrompt'
config.hide_tab_bar_if_only_one_tab = true
config.pane_focus_follows_mouse = true

-- === Performance ===
config.max_fps = 200
config.animation_fps = 1
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 }
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- === Keybindings ===
local act = wezterm.action

config.leader = {
    key = 'a',
    mods = 'CTRL',
    timeout_milliseconds = 2000,
}

config.keys = {
    -- === Tab Management ===
    -- Create new tab
    { key = 't', mods = 'CTRL|SHIFT', action = act.SpawnTab 'CurrentPaneDomain' },
    -- Close current tab
    { key = 'q', mods = 'CTRL|SHIFT', action = act.CloseCurrentTab { confirm = false } },

    -- Navigate tabs
    { key = 't', mods = 'LEADER', action = act.ShowTabNavigator },
    -- Next/Previous tab
    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },

    -- === Pane Management ===
    -- Split panes
    { key = 'v', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
    { key = 'h', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    -- Navigate panes (CTRL + vim keys)
    { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection 'Left' },
    { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
    { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection 'Up' },
    { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection 'Down' },
    -- Resize panes (ALT + vim keys)
    { key = 'h', mods = 'ALT', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'l', mods = 'ALT', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'k', mods = 'ALT', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'j', mods = 'ALT', action = act.AdjustPaneSize { 'Down', 1 } },
    -- Close pane
    { key = 'q', mods = 'LEADER', action = act.CloseCurrentPane { confirm = false } },
    -- Toggle pane zoom
    { key = 'f', mods = 'ALT', action = act.TogglePaneZoomState },

    -- === Font Size ===
    -- Zoom in/out
    { key = '=', mods = 'CTRL', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },

    -- === Copy/Paste & Search ===
    -- Copy/Paste (standard Linux shortcuts)
    { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
    -- Search
    { key = 'f', mods = 'CTRL|SHIFT', action = act.Search 'CurrentSelectionOrEmptyString' },

    -- === Quick Actions ===
    -- Clear screen
    { key = 'k', mods = 'CTRL|ALT', action = act.ClearScrollback 'ScrollbackAndViewport' },
    -- Show launcher (command palette)
    { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
    -- Toggle fullscreen
    { key = 'F11', action = act.ToggleFullScreen },

    -- === Scrolling ===
    -- Scroll up/down by page
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    -- Scroll to top/bottom
    { key = 'Home', mods = 'SHIFT', action = act.ScrollToTop },
    { key = 'End', mods = 'SHIFT', action = act.ScrollToBottom },

    -- === Workspace Management ===

    -- Create new workspace
    { key = 's', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },

    -- Saving a workspace
    { key = 's', mods = 'CTRL', action = act.SwitchToWorkspace { name = 'default' } },

    -- Rename workspace
    { key = 'r', mods = 'LEADER', action = wezterm.action.PromptInputLine({
        description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { Color = C_HL_1 } },
            { Text = 'Enter new name for the workspace:' },
        },
        action = wezterm.action_callback(function(window, pane, line)
            if line then
                wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
            end
        end),
        }),
    },

    -- To delete a workspace, do not hit ctrl+s when leaving a workspace
}

return config