from dooit.ui.api import DooitAPI, subscribe
from dooit.ui.api.events import Startup
from rich.style import Style
from dooit_extras.formatters import *
from dooit_extras.bar_widgets import *
from dooit_extras.scripts import *
from rich.text import Text
from dooit.api.theme import DooitThemeBase


# -------- Everforest Dark Hard (High Contrast) --------
class EverforestDarkHardHC(DooitThemeBase):
    _name = "dooit-everforest-dark-hard-hc"

    # Background shades (unchanged for atmosphere)
    background1: str = "#272e33"  # Darkest
    background2: str = "#2e383c"  # Slightly lighter
    background3: str = "#374145"  # Lightest background

    # Foreground shades (brightened for readability)
    foreground1: str = "#e8e4cf"  # Brighter than #d3c6aa
    foreground2: str = "#cfcab5"  # Brighter than #9da9a0
    foreground3: str = "#b3b09b"  # Brighter than #859289

    # Core palette (kept but brightened where possible)
    red: str = "#f08080"     # slightly lighter red
    orange: str = "#e6a97a"  # brighter than bell border
    yellow: str = "#e6c37f"  # soft bright yellow
    green: str = "#b0ce8c"   # brighter green
    blue: str = "#8cd1c8"    # slightly more vivid cyan-blue
    purple: str = "#dda6c1"  # brighter purple
    magenta: str = "#dda6c1"
    cyan: str = "#91d0a6"    # brighter cyan

    # Accent colors (for borders, highlights, titles)
    primary: str = "#b0ce8c"   # vivid green for key highlights
    secondary: str = "#8cd1c8" # bright blue for secondary highlights


# @subscribe(Startup)
# def setup(api: DooitAPI, _):
#    api.keys.set("<tab>", api.no_op)
#    api.keys.set(" ", api.switch_focus)


@subscribe(Startup)
def setup_theme(api: DooitAPI, _):
    api.css.set_theme(EverforestDarkHardHC)


@subscribe(Startup)
def setup_formatters(api: DooitAPI, _):
    fmt = api.formatter
    theme = api.vars.theme

    # ------- WORKSPACES -------
    format = Text(" ({}) ", style=theme.primary).markup
    fmt.workspaces.description.add(description_children_count(format))

    # --------- TODOS ---------
    fmt.todos.status.add(status_icons(completed=" ", pending="󰞋 ", overdue="󰅗 "))

    u_icons = {1: "  󰎤", 2: "  󰎧", 3: "  󰎪", 4: "  󰎭"}
    fmt.todos.urgency.add(urgency_icons(icons=u_icons))

    fmt.todos.due.add(due_casual_format())
    fmt.todos.due.add(due_icon(completed=" ", pending=" ", overdue=" "))

    format = Text("  {completed_count}/{total_count}", style=theme.green).markup
    fmt.todos.description.add(todo_description_progress(fmt=format))
    fmt.todos.description.add(description_highlight_tags(fmt=" {}"))


@subscribe(Startup)
def setup_bar(api: DooitAPI, _):
    theme = api.vars.theme

    widgets = [
        Mode(api),
        Spacer(api, width=0),
        StatusIcons(api, bg=theme.background2),
        TextBox(api, text="  ", fg=theme.foreground1, bg=theme.primary),
        TextBox(api, text=" -4°C ", fg=theme.foreground1, bg=theme.background3),
        TextBox(api, text=" 󰥔 ", fg=theme.foreground1, bg=theme.primary),
        Clock(api, format="%I:%M %p", fg=theme.foreground1, bg=theme.background3),
    ]
    api.bar.set(widgets)


@subscribe(Startup)
def setup_dashboard(api: DooitAPI, _):
    from datetime import datetime

    theme = api.vars.theme

    now = datetime.now()
    formatted_date = now.strftime(" 󰸘 %A, %d %b ")

    header = Text(
        "Today’s forecast: 100% chance of getting stuff done… maybe.",
        style=Style(color=theme.primary, bold=True, italic=True),
    )

    ascii_art = r"""
                           (  (                  /\
                            (_)                 /  \  /\
                    ________[_]________      /\/    \/  \
           /\      /\        ______    \    /   /\/\  /\/\
          /  \    //_\       \    /\    \  /\/\/    \/    \
   /\    / /\/\  //___\       \__/  \    \/
  /  \  /\/    \//_____\       \ |[]|     \
 /\/\/\/       //_______\       \|__|      \
/      \      /XXXXXXXXXX\                  \
        \    /_I_II  I__I_\__________________\
               I_I|  I__I_____[]_|_[]_____I
               I_II  I__I_____[]_|_[]_____I
               I II__I  I     XXXXXXX     I
            ~~~~~"   "~~~~~~~~~~~~~~~~~~~~~~~~
    """

    items = [
        header,
        "",
        Text(ascii_art, style=api.vars.theme.primary),
        "",
        Text(
            formatted_date,
            style=Style(color=theme.secondary, bold=True, italic=True),
        ),
    ]
    api.dashboard.set(items)
