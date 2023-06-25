import catppuccin

# load your autoconfig, use this if the rest of your config is empty!
config.load_autoconfig()


config.bind("J", "tab-prev")
config.bind("K", "tab-next")
# set the flavour you'd like to use
# valid options are 'mocha', 'macchiato', 'frappe', and 'latte'

font_size = "16"
terminal = "/opt/homebrew/bin/alacritty"

c.fonts.web.family.fantasy = "Arial"
c.fonts.statusbar = f"{font_size}pt default_family"
c.fonts.completion.entry = f"{font_size}pt  default_family"
c.fonts.tabs.selected = f"{font_size}pt default_family"
c.fonts.tabs.unselected = f"{font_size}pt default_family"
c.fonts.completion.category = f"bold {font_size}pt default_family"

c.content.javascript.can_access_clipboard = True
c.content.pdfjs = True

c.tabs.title.format = "{current_title}"
c.tabs.indicator.width = 0
c.tabs.show = "switching"

c.statusbar.show = "never"

c.editor.command = [terminal, "-e", "/opt/homebrew/bin/nvim", "{}"]
c.fileselect.folder.command = [terminal, "ranger", "--choosedir={}"]
c.fileselect.single_file.command = [terminal, "ranger", "--choosefile={}"]
c.fileselect.multiple_files.command = [terminal, "ranger", "--choosefiles={}"]

c.content.blocking.enabled = True
c.content.blocking.hosts.block_subdomains = True
c.content.blocking.method = "adblock"


config.bind("pf", "spawn --userscript password_fill")

# config.set(
#     "bindings.commands",
#     {
#         "normal": {
#             "j": "scroll-px 0 30",
#             "k": "scroll-px 0 -30",
#         }
#     },
# )

# for home office
c.zoom.default = "125"


catppuccin.setup(c, "mocha")
