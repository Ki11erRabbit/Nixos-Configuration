{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ki11errabbit";
  home.homeDirectory = "/home/ki11errabbit";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    stow
    fnott
    wdisplays
    xournalpp
    gimp
    powershell
    godot_4
    trash-cli
    zoxide
    delta
    du-dust
    fd
    hexyl
    procs
    pavucontrol
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
        ".local/bin/nix-config.sh".text = ''
            #!/bin/sh

            items="system
            hardware
            home"

            item=$(echo "$items" | bemenu -pfi "NixOS Config")


            case $item in
                system) neovide /etc/nixos/configuration.nix;;
                hardware) neovide /etc/nixos/hardware-configuration.nix;;
                home) neovide /home/ki11errabbit/.config/home-manager/home.nix;;
                *) exit 1;;
            esac
        '';
        ".config/alacritty/alacritty.toml".text = ''
            [colors]
            draw_bold_text_with_bright_colors = false

            [colors.bright]
            black = "0x47505e"
            blue = "0x5db3ef"
            cyan = "0x51dbff"
            green = "0x9bbe6e"
            magenta = "0xc882dd"
            red = "0xff7877"
            white = "0xc4c8cf"
            yellow = "0xecc286"

            [colors.normal]
            black = "0x282c34"
            blue = "0x51afef"
            cyan = "0x46d9ff"
            green = "0x98be65"
            magenta = "0xc678dd"
            red = "0xff6c6b"
            white = "0xbbc2cf"
            yellow = "0xecbe7b"

            [colors.primary]
            background = "0x282c34"
            foreground = "0xbbc2cf"

            [cursor.style]
            blinking = "On"
            shape = "Beam"

            [font]
            size = 11

            [font.bold]
            family = "monospace"
            style = "Bold"

            [font.bold_italic]
            family = "monospace"
            style = "Bold Italic"

            [font.italic]
            family = "monospace"
            style = "Text Italic"

            [font.normal]
            family = "monospace"
            style = "Text"

            [[keyboard.bindings]]
            action = "SpawnNewInstance"
            key = "Return"
            mods = "Control|Shift"

            [scrolling]
            history = 50000

            [window.padding]
            x = 0
            y = 0
        '';
        ".config/yazi/keymap.toml".text = ''
            # A TOML linter such as https://taplo.tamasfe.dev/ can use this schema to validate your config.
            # If you encounter any issues, please make an issue at https://github.com/yazi-rs/schemas.
            "$schema" = "https://yazi-rs.github.io/schemas/keymap.json"

            [manager]

            keymap = [
                { on = [ "<Esc>" ], exec = "escape",             desc = "Exit visual mode, clear selected, or cancel search" },
                { on = [ "q" ],     exec = "quit",               desc = "Exit the process" },
                { on = [ "Q" ],     exec = "quit --no-cwd-file", desc = "Exit the process without writing cwd-file" },
                { on = [ "<C-q>" ], exec = "close",              desc = "Close the current tab, or quit if it is last tab" },
                { on = [ "<C-z>" ], exec = "suspend",            desc = "Suspend the process" },

                # Navigation
                { on = [ "e" ], exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "n" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "E" ], exec = "arrow -5", desc = "Move cursor up 5 lines" },
                { on = [ "N" ], exec = "arrow 5",  desc = "Move cursor down 5 lines" },

                { on = [ "<S-Up>" ],   exec = "arrow -5", desc = "Move cursor up 5 lines" },
                { on = [ "<S-Down>" ], exec = "arrow 5",  desc = "Move cursor down 5 lines" },

                { on = [ "<C-u>" ], exec = "arrow -50%",  desc = "Move cursor up half page" },
                { on = [ "<C-d>" ], exec = "arrow 50%",   desc = "Move cursor down half page" },
                { on = [ "<C-b>" ], exec = "arrow -100%", desc = "Move cursor up one page" },
                { on = [ "<C-f>" ], exec = "arrow 100%",  desc = "Move cursor down one page" },

                { on = [ "<C-PageUp>" ],   exec = "arrow -50%",  desc = "Move cursor up half page" },
                { on = [ "<C-PageDown>" ], exec = "arrow 50%",   desc = "Move cursor down half page" },
                { on = [ "<PageUp>" ],     exec = "arrow -100%", desc = "Move cursor up one page" },
                { on = [ "<PageDown>" ],   exec = "arrow 100%",  desc = "Move cursor down one page" },

                { on = [ "m" ], exec = [ "leave", "escape --visual --select" ], desc = "Go back to the parent directory" },
                { on = [ "i" ], exec = [ "enter", "escape --visual --select" ], desc = "Enter the child directory" },

                { on = [ "M" ], exec = "back",    desc = "Go back to the previous directory" },
                { on = [ "I" ], exec = "forward", desc = "Go forward to the next directory" },

                { on = [ "<A-e>" ], exec = "seek -5", desc = "Seek up 5 units in the preview" },
                { on = [ "<A-n>" ], exec = "seek 5",  desc = "Seek down 5 units in the preview" },
                { on = [ "<A-PageUp>" ],   exec = "seek -5", desc = "Seek up 5 units in the preview" },
                { on = [ "<A-PageDown>" ], exec = "seek 5",  desc = "Seek down 5 units in the preview" },

                { on = [ "<Up>" ],    exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "<Down>" ],  exec = "arrow 1",  desc = "Move cursor down" },
                { on = [ "<Left>" ],  exec = "leave",    desc = "Go back to the parent directory" },
                { on = [ "<Right>" ], exec = "enter",    desc = "Enter the child directory" },

                { on = [ "g", "g" ], exec = "arrow -99999999", desc = "Move cursor to the top" },
                { on = [ "G" ],      exec = "arrow 99999999",  desc = "Move cursor to the bottom" },

                # Selection
                { on = [ "<Space>" ], exec = [ "select --state=none", "arrow 1" ], desc = "Toggle the current selection state" },
                { on = [ "v" ],       exec = "visual_mode",                        desc = "Enter visual mode (selection mode)" },
                { on = [ "V" ],       exec = "visual_mode --unset",                desc = "Enter visual mode (unset mode)" },
                { on = [ "<C-a>" ],   exec = "select_all --state=true",            desc = "Select all files" },
                { on = [ "<C-r>" ],   exec = "select_all --state=none",            desc = "Inverse selection of all files" },

                # Operation
                { on = [ "o" ],         exec = "open",                                                 desc = "Open the selected files" },
                { on = [ "O" ],         exec = "open --interactive",                                   desc = "Open the selected files interactively" },
                { on = [ "<Enter>" ],   exec = "open",                                                 desc = "Open the selected files" },
                { on = [ "<C-Enter>" ], exec = "open --interactive",                                   desc = "Open the selected files interactively" },
                { on = [ "y" ],         exec = [ "yank", "escape --visual --select" ],                 desc = "Copy the selected files" },
                { on = [ "Y" ],         exec = [ "unyank", "escape --visual --select" ],               desc = "Cancel the yank status of files" },
                { on = [ "x" ],         exec = [ "yank --cut", "escape --visual --select" ],           desc = "Cut the selected files" },
                { on = [ "p" ],         exec = "paste",                                                desc = "Paste the files" },
                { on = [ "P" ],         exec = "paste --force",                                        desc = "Paste the files (overwrite if the destination exists)" },
                { on = [ "-" ],         exec = "link",                                                 desc = "Symlink the absolute path of files" },
                { on = [ "_" ],         exec = "link --relative",                                      desc = "Symlink the relative path of files" },
                { on = [ "d" ],         exec = [ "remove", "escape --visual --select" ],               desc = "Move the files to the trash" },
                { on = [ "D" ],         exec = [ "remove --permanently", "escape --visual --select" ], desc = "Permanently delete the files" },
                { on = [ "a" ],         exec = "create",                                               desc = "Create a file or directory (ends with / for directories)" },
                { on = [ "r" ],         exec = "rename --cursor=before_ext",                           desc = "Rename a file or directory" },
                { on = [ ";" ],         exec = "shell",                                                desc = "Run a shell command" },
                { on = [ ":" ],         exec = "shell --block",                                        desc = "Run a shell command (block the UI until the command finishes)" },
                { on = [ "." ],         exec = "hidden toggle",                                        desc = "Toggle the visibility of hidden files" },
                { on = [ "s" ],         exec = "search fd",                                            desc = "Search files by name using fd" },
                { on = [ "S" ],         exec = "search rg",                                            desc = "Search files by content using ripgrep" },
                { on = [ "<C-s>" ],     exec = "search none",                                          desc = "Cancel the ongoing search" },
                { on = [ "z" ],         exec = "jump zoxide",                                          desc = "Jump to a directory using zoxide" },
                { on = [ "Z" ],         exec = "jump fzf",                                             desc = "Jump to a directory, or reveal a file using fzf" },

                # Linemode
                { on = [ "k", "s" ], exec = "linemode size",        desc = "Set linemode to size" },
                { on = [ "k", "p" ], exec = "linemode permissions", desc = "Set linemode to permissions" },
                { on = [ "k", "k" ], exec = "linemode mtime",       desc = "Set linemode to mtime" },
                { on = [ "k", "j" ], exec = "linemode none",        desc = "Set linemode to none" },

                # Copy
                { on = [ "c", "c" ], exec = "copy path",             desc = "Copy the absolute path" },
                { on = [ "c", "d" ], exec = "copy dirname",          desc = "Copy the path of the parent directory" },
                { on = [ "c", "f" ], exec = "copy filename",         desc = "Copy the name of the file" },
                { on = [ "c", "n" ], exec = "copy name_without_ext", desc = "Copy the name of the file without the extension" },

                # Filter
                { on = [ "f" ], exec = "filter --smart", desc = "Filter the files" },

                # Find
                { on = [ "/" ], exec = "find --smart",            desc = "Find next file" },
                { on = [ "?" ], exec = "find --previous --smart", desc = "Find previous file" },
                { on = [ "l" ], exec = "find_arrow",              desc = "Go to next found file" },
                { on = [ "L" ], exec = "find_arrow --previous",   desc = "Go to previous found file" },

                # Sorting
                { on = [ ",", "j" ], exec = "sort modified --dir-first",               desc = "Sort by modified time" },
                { on = [ ",", "J" ], exec = "sort modified --reverse --dir-first",     desc = "Sort by modified time (reverse)" },
                { on = [ ",", "c" ], exec = "sort created --dir-first",                desc = "Sort by created time" },
                { on = [ ",", "C" ], exec = "sort created --reverse --dir-first",      desc = "Sort by created time (reverse)" },
                { on = [ ",", "e" ], exec = "sort extension --dir-first",         	   desc = "Sort by extension" },
                { on = [ ",", "E" ], exec = "sort extension --reverse --dir-first",    desc = "Sort by extension (reverse)" },
                { on = [ ",", "a" ], exec = "sort alphabetical --dir-first",           desc = "Sort alphabetically" },
                { on = [ ",", "A" ], exec = "sort alphabetical --reverse --dir-first", desc = "Sort alphabetically (reverse)" },
                { on = [ ",", "k" ], exec = "sort natural --dir-first",                desc = "Sort naturally" },
                { on = [ ",", "K" ], exec = "sort natural --reverse --dir-first",      desc = "Sort naturally (reverse)" },
                { on = [ ",", "s" ], exec = "sort size --dir-first",                   desc = "Sort by size" },
                { on = [ ",", "S" ], exec = "sort size --reverse --dir-first",         desc = "Sort by size (reverse)" },

                # Tabs
                { on = [ "t" ], exec = "tab_create --current", desc = "Create a new tab using the current path" },

                { on = [ "1" ], exec = "tab_switch 0", desc = "Switch to the first tab" },
                { on = [ "2" ], exec = "tab_switch 1", desc = "Switch to the second tab" },
                { on = [ "3" ], exec = "tab_switch 2", desc = "Switch to the third tab" },
                { on = [ "4" ], exec = "tab_switch 3", desc = "Switch to the fourth tab" },
                { on = [ "5" ], exec = "tab_switch 4", desc = "Switch to the fifth tab" },
                { on = [ "6" ], exec = "tab_switch 5", desc = "Switch to the sixth tab" },
                { on = [ "7" ], exec = "tab_switch 6", desc = "Switch to the seventh tab" },
                { on = [ "8" ], exec = "tab_switch 7", desc = "Switch to the eighth tab" },
                { on = [ "9" ], exec = "tab_switch 8", desc = "Switch to the ninth tab" },

                { on = [ "[" ], exec = "tab_switch -1 --relative", desc = "Switch to the previous tab" },
                { on = [ "]" ], exec = "tab_switch 1 --relative",  desc = "Switch to the next tab" },

                { on = [ "{" ], exec = "tab_swap -1", desc = "Swap the current tab with the previous tab" },
                { on = [ "}" ], exec = "tab_swap 1",  desc = "Swap the current tab with the next tab" },

                # Tasks
                { on = [ "w" ], exec = "tasks_show", desc = "Show the tasks manager" },

                # Goto
                { on = [ "g", "h" ],       exec = "cd ~",             desc = "Go to the home directory" },
                { on = [ "g", "c" ],       exec = "cd ~/.config",     desc = "Go to the config directory" },
                { on = [ "g", "d" ],       exec = "cd ~/Downloads",   desc = "Go to the downloads directory" },
                { on = [ "g", "t" ],       exec = "cd /tmp",          desc = "Go to the temporary directory" },
                { on = [ "g", "<Space>" ], exec = "cd --interactive", desc = "Go to a directory interactively" },

                # Help
                { on = [ "~" ], exec = "help", desc = "Open help" },
            ]

            [tasks]

            keymap = [
                { on = [ "<Esc>" ], exec = "close", desc = "Hide the task manager" },
                { on = [ "<C-q>" ], exec = "close", desc = "Hide the task manager" },
                { on = [ "w" ],     exec = "close", desc = "Hide the task manager" },

                { on = [ "e" ], exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "n" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "<Up>" ],   exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "<Down>" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "<Enter>" ], exec = "inspect", desc = "Inspect the task" },
                { on = [ "x" ],       exec = "cancel",  desc = "Cancel the task" },

                { on = [ "~" ], exec = "help", desc = "Open help" }
            ]

            [select]

            keymap = [
                { on = [ "<C-q>" ],   exec = "close",          desc = "Cancel selection" },
                { on = [ "<Esc>" ],   exec = "close",          desc = "Cancel selection" },
                { on = [ "<Enter>" ], exec = "close --submit", desc = "Submit the selection" },

                { on = [ "e" ], exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "n" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "E" ], exec = "arrow -5", desc = "Move cursor up 5 lines" },
                { on = [ "N" ], exec = "arrow 5",  desc = "Move cursor down 5 lines" },

                { on = [ "<Up>" ],   exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "<Down>" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "<S-Up>" ],   exec = "arrow -5", desc = "Move cursor up 5 lines" },
                { on = [ "<S-Down>" ], exec = "arrow 5",  desc = "Move cursor down 5 lines" },

                { on = [ "~" ], exec = "help", desc = "Open help" }
            ]

            [input]

            keymap = [
                { on = [ "<C-q>" ],   exec = "close",          desc = "Cancel input" },
                { on = [ "<Enter>" ], exec = "close --submit", desc = "Submit the input" },
                { on = [ "<Esc>" ],   exec = "escape",         desc = "Go back the normal mode, or cancel input" },

                # Mode
                { on = [ "t" ], exec = "insert",                              desc = "Enter insert mode" },
                { on = [ "a" ], exec = "insert --append",                     desc = "Enter append mode" },
                { on = [ "T" ], exec = [ "move -999", "insert" ],             desc = "Move to the BOL, and enter insert mode" },
                { on = [ "A" ], exec = [ "move 999", "insert --append" ],     desc = "Move to the EOL, and enter append mode" },
                { on = [ "v" ], exec = "visual",                              desc = "Enter visual mode" },
                { on = [ "V" ], exec = [ "move -999", "visual", "move 999" ], desc = "Enter visual mode and select all" },

                # Character-wise movement
                { on = [ "m" ],       exec = "move -1", desc = "Move back a character" },
                { on = [ "i" ],       exec = "move 1",  desc = "Move forward a character" },
                { on = [ "<Left>" ],  exec = "move -1", desc = "Move back a character" },
                { on = [ "<Right>" ], exec = "move 1",  desc = "Move forward a character" },
                { on = [ "<C-b>" ],   exec = "move -1", desc = "Move back a character" },
                { on = [ "<C-f>" ],   exec = "move 1",  desc = "Move forward a character" },

                # Word-wise movement
                { on = [ "b" ],     exec = "backward",              desc = "Move back to the start of the current or previous word" },
                { on = [ "w" ],     exec = "forward",               desc = "Move forward to the start of the next word" },
                { on = [ "e" ],     exec = "forward --end-of-word", desc = "Move forward to the end of the current or next word" },
                { on = [ "<A-b>" ], exec = "backward",              desc = "Move back to the start of the current or previous word" },
                { on = [ "<A-f>" ], exec = "forward --end-of-word", desc = "Move forward to the end of the current or next word" },

                # Line-wise movement
                { on = [ "0" ],     exec = "move -999", desc = "Move to the BOL" },
                { on = [ "$" ],     exec = "move 999",  desc = "Move to the EOL" },
                { on = [ "<C-a>" ], exec = "move -999", desc = "Move to the BOL" },
                { on = [ "<C-e>" ], exec = "move 999",  desc = "Move to the EOL" },

                # Delete
                { on = [ "<Backspace>" ], exec = "backspace",	        desc = "Delete the character before the cursor" },
                { on = [ "<C-m>" ],       exec = "backspace",         desc = "Delete the character before the cursor" },
                { on = [ "<C-d>" ],       exec = "backspace --under", desc = "Delete the character under the cursor" },

                # Kill
                { on = [ "<C-u>" ], exec = "kill bol",      desc = "Kill backwards to the BOL" },
                { on = [ "<C-k>" ], exec = "kill eol",      desc = "Kill forwards to the EOL" },
                { on = [ "<C-w>" ], exec = "kill backward", desc = "Kill backwards to the start of the current word" },
                { on = [ "<A-d>" ], exec = "kill forward",  desc = "Kill forwards to the end of the current word" },

                # Cut/Yank/Paste
                { on = [ "d" ], exec = "delete --cut",                              desc = "Cut the selected characters" },
                { on = [ "D" ], exec = [ "delete --cut", "move 999" ],              desc = "Cut until the EOL" },
                { on = [ "c" ], exec = "delete --cut --insert",                     desc = "Cut the selected characters, and enter insert mode" },
                { on = [ "C" ], exec = [ "delete --cut --insert", "move 999" ],     desc = "Cut until the EOL, and enter insert mode" },
                { on = [ "x" ], exec = [ "delete --cut", "move 1 --in-operating" ], desc = "Cut the current character" },
                { on = [ "y" ], exec = "yank",           desc = "Copy the selected characters" },
                { on = [ "p" ], exec = "paste",          desc = "Paste the copied characters after the cursor" },
                { on = [ "P" ], exec = "paste --before", desc = "Paste the copied characters before the cursor" },

                # Undo/Redo
                { on = [ "u" ],     exec = "undo", desc = "Undo the last operation" },
                { on = [ "<C-r>" ], exec = "redo", desc = "Redo the last operation" },

                # Help
                { on = [ "~" ], exec = "help", desc = "Open help" }
            ]

            [completion]

            keymap = [
                { on = [ "<C-q>" ],   exec = "close",                                      desc = "Cancel completion" },
                { on = [ "<Tab>" ],   exec = "close --submit",                             desc = "Submit the completion" },
                { on = [ "<Enter>" ], exec = [ "close --submit", "close_input --submit" ], desc = "Submit the completion and input" },

                { on = [ "<A-e>" ], exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "<A-n>" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "<Up>" ],   exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "<Down>" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "~" ], exec = "help", desc = "Open help" }
            ]

            [help]

            keymap = [
                { on = [ "<Esc>" ], exec = "escape", desc = "Clear the filter, or hide the help" },
                { on = [ "q" ],     exec = "close",  desc = "Exit the process" },
                { on = [ "<C-q>" ], exec = "close",  desc = "Hide the help" },

                # Navigation
                { on = [ "e" ], exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "n" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "E" ], exec = "arrow -5", desc = "Move cursor up 5 lines" },
                { on = [ "N" ], exec = "arrow 5",  desc = "Move cursor down 5 lines" },

                { on = [ "<Up>" ],   exec = "arrow -1", desc = "Move cursor up" },
                { on = [ "<Down>" ], exec = "arrow 1",  desc = "Move cursor down" },

                { on = [ "<S-Up>" ],   exec = "arrow -5", desc = "Move cursor up 5 lines" },
                { on = [ "<S-Down>" ], exec = "arrow 5",  desc = "Move cursor down 5 lines" },

                # Filtering
                { on = [ "/" ], exec = "filter", desc = "Apply a filter for the help items" },
            ]
        '';
        ".config/yazi/theme.toml".text = ''
            # A TOML linter such as https://taplo.tamasfe.dev/ can use this schema to validate your config.
            # If you encounter any issues, please make an issue at https://github.com/yazi-rs/schemas.
            "$schema" = "https://yazi-rs.github.io/schemas/theme.json"

            # vim:fileencoding=utf-8:foldmethod=marker

            # : Manager {{{

            [manager]
            cwd = { fg = "cyan" }

            # Hovered
            hovered         = { fg = "black", bg = "lightblue" }
            preview_hovered = { underline = true }

            # Find
            find_keyword  = { fg = "yellow", italic = true }
            find_position = { fg = "magenta", bg = "reset", italic = true }

            # Marker
            marker_selected = { fg = "lightgreen",  bg = "lightgreen" }
            marker_copied   = { fg = "lightyellow", bg = "lightyellow" }
            marker_cut      = { fg = "lightred",    bg = "lightred" }

            # Tab
            tab_active   = { fg = "black", bg = "lightblue" }
            tab_inactive = { fg = "white", bg = "darkgray" }
            tab_width    = 1

            # Border
            border_symbol = "│"
            border_style  = { fg = "gray" }

            # Highlighting
            syntect_theme = ""

            # : }}}


            # : Status {{{

            [status]
            separator_open  = ""
            separator_close = ""
            separator_style = { fg = "darkgray", bg = "darkgray" }

            # Mode
            mode_normal = { fg = "black", bg = "lightblue", bold = true }
            mode_select = { fg = "black", bg = "lightgreen", bold = true }
            mode_unset  = { fg = "black", bg = "lightmagenta", bold = true }

            # Progress
            progress_label  = { bold = true }
            progress_normal = { fg = "blue", bg = "black" }
            progress_error  = { fg = "red", bg = "black" }

            # Permissions
            permissions_t = { fg = "lightgreen" }
            permissions_r = { fg = "lightyellow" }
            permissions_w = { fg = "lightred" }
            permissions_x = { fg = "lightcyan" }
            permissions_s = { fg = "darkgray" }

            # : }}}


            # : Select {{{

            [select]
            border   = { fg = "blue" }
            active   = { fg = "magenta" }
            inactive = {}

            # : }}}


            # : Input {{{

            [input]
            border   = { fg = "blue" }
            title    = {}
            value    = {}
            selected = { reversed = true }

            # : }}}


            # : Completion {{{

            [completion]
            border   = { fg = "blue" }
            active   = { bg = "darkgray" }
            inactive = {}

            # Icons
            icon_file    = ""
            icon_folder  = ""
            icon_command = ""

            # : }}}


            # : Tasks {{{

            [tasks]
            border  = { fg = "blue" }
            title   = {}
            hovered = { underline = true }

            # : }}}


            # : Which {{{

            [which]
            cols            = 3
            mask            = { bg = "black" }
            cand            = { fg = "lightcyan" }
            rest            = { fg = "darkgray" }
            desc            = { fg = "magenta" }
            separator       = "  "
            separator_style = { fg = "darkgray" }

            # : }}}


            # : Help {{{

            [help]
            on      = { fg = "magenta" }
            exec    = { fg = "cyan" }
            desc    = { fg = "gray" }
            hovered = { bg = "darkgray", bold = true }
            footer  = { fg = "black", bg = "white" }

            # : }}}


            # : File-specific styles {{{

            [filetype]

            rules = [
                # Images
                { mime = "image/*", fg = "cyan" },

                # Videos
                { mime = "video/*", fg = "yellow" },
                { mime = "audio/*", fg = "yellow" },

                # Archives
                { mime = "application/zip",             fg = "magenta" },
                { mime = "application/gzip",            fg = "magenta" },
                { mime = "application/x-tar",           fg = "magenta" },
                { mime = "application/x-bzip",          fg = "magenta" },
                { mime = "application/x-bzip2",         fg = "magenta" },
                { mime = "application/x-7z-compressed", fg = "magenta" },
                { mime = "application/x-rar",           fg = "magenta" },
                { mime = "application/xz",              fg = "magenta" },

                # Documents
                { mime = "application/doc",   fg = "green" },
                { mime = "application/pdf",   fg = "green" },
                { mime = "application/rtf",   fg = "green" },
                { mime = "application/vnd.*", fg = "green" },

                # Fallback
                # { name = "*", fg = "white" },
                { name = "*/", fg = "blue" }
            ]

            [icon]

            rules = [
                # Programming
                { name = "*.c"    , text = "" },
                { name = "*.cpp"  , text = "" },
                { name = "*.css"  , text = "" },
                { name = "*.fish" , text = "" },
                { name = "*.go"   , text = "" },
                { name = "*.h"    , text = "" },
                { name = "*.hpp"  , text = "" },
                { name = "*.html" , text = "" },
                { name = "*.java" , text = "" },
                { name = "*.js"   , text = "" },
                { name = "*.jsx"  , text = "" },
                { name = "*.lua"  , text = "" },
                { name = "*.nix"  , text = "" },
                { name = "*.php"  , text = "" },
                { name = "*.py"   , text = "" },
                { name = "*.rb"   , text = "" },
                { name = "*.rs"   , text = "" },
                { name = "*.scss" , text = "" },
                { name = "*.sh"   , text = "" },
                { name = "*.swift", text = "" },
                { name = "*.ts"   , text = "" },
                { name = "*.tsx"  , text = "" },
                { name = "*.vim"  , text = "" },
                { name = "*.vue"  , text = "󰡄" },

                # Text
                { name = "*.conf", text = "" },
                { name = "*.ini" , text = "" },
                { name = "*.json", text = "" },
                { name = "*.md" ,  text = "" },
                { name = "*.toml", text = "" },
                { name = "*.txt",  text = "" },
                { name = "*.yaml", text = "" },
                { name = "*.yml" , text = "" },

                # Archives
                { name = "*.7z" , text = "" },
                { name = "*.bz2", text = "" },
                { name = "*.gz" , text = "" },
                { name = "*.rar", text = "" },
                { name = "*.tar", text = "" },
                { name = "*.xz" , text = "" },
                { name = "*.zip", text = "" },

                # Images
                { name = "*.HEIC", text = "" },
                { name = "*.avif", text = "" },
                { name = "*.bmp" , text = "" },
                { name = "*.gif" , text = "" },
                { name = "*.ico" , text = "" },
                { name = "*.jpeg", text = "" },
                { name = "*.jpg" , text = "" },
                { name = "*.png" , text = "" },
                { name = "*.svg" , text = "" },
                { name = "*.webp", text = "" },

                # Movies
                { name = "*.avi" , text = "" },
                { name = "*.mkv" , text = "" },
                { name = "*.mov" , text = "" },
                { name = "*.mp4" , text = "" },
                { name = "*.webm", text = "" },

                # Audio
                { name = "*.aac" , text = "" },
                { name = "*.flac", text = "" },
                { name = "*.m4a" , text = "" },
                { name = "*.mp3" , text = "" },
                { name = "*.ogg" , text = "" },
                { name = "*.wav" , text = "" },

                # Documents
                { name = "*.csv" , text = "" },
                { name = "*.doc" , text = "" },
                { name = "*.doct", text = "" },
                { name = "*.docx", text = "" },
                { name = "*.dot" , text = "" },
                { name = "*.ods" , text = "" },
                { name = "*.ots" , text = "" },
                { name = "*.pdf" , text = "" },
                { name = "*.pom" , text = "" },
                { name = "*.pot" , text = "" },
                { name = "*.potx", text = "" },
                { name = "*.ppm" , text = "" },
                { name = "*.ppmx", text = "" },
                { name = "*.pps" , text = "" },
                { name = "*.ppsx", text = "" },
                { name = "*.ppt" , text = "" },
                { name = "*.pptx", text = "" },
                { name = "*.xlc" , text = "" },
                { name = "*.xlm" , text = "" },
                { name = "*.xls" , text = "" },
                { name = "*.xlsm", text = "" },
                { name = "*.xlsx", text = "" },
                { name = "*.xlt" , text = "" },

                # Lockfiles
                { name = "*.lock", text = "" },

                # Misc
                { name = "*.bin", text = "" },
                { name = "*.exe", text = "" },
                { name = "*.pkg", text = "" },

                # Dotfiles
                { name = ".DS_Store"     , text = "" },
                { name = ".bashprofile"  , text = "" },
                { name = ".bashrc"       , text = "" },
                { name = ".gitattributes", text = "" },
                { name = ".gitignore"    , text = "" },
                { name = ".gitmodules"   , text = "" },
                { name = ".vimrc"        , text = "" },
                { name = ".zprofile"     , text = "" },
                { name = ".zshenv"       , text = "" },
                { name = ".zshrc"        , text = "" },

                # Named files
                { name = "COPYING"      , text = "󰿃" },
                { name = "Containerfile", text = "󰡨" },
                { name = "Dockerfile"   , text = "󰡨" },
                { name = "LICENSE"      , text = "󰿃" },

                # Directories
                { name = ".config/"    , text = "" },
                { name = ".git/"       , text = "" },
                { name = "Desktop/"    , text = "" },
                { name = "Development/", text = "" },
                { name = "Documents/"  , text = "" },
                { name = "Downloads/"  , text = "" },
                { name = "Library/"    , text = "" },
                { name = "Movies/"     , text = "" },
                { name = "Music/"      , text = "" },
                { name = "Pictures/"   , text = "" },
                { name = "Public/"     , text = "" },
                { name = "Videos/"     , text = "" },

                # Default
                { name = "*" , text = "" },
                { name = "*/", text = "" },
            ]

            # : }}}
        '';
        ".config/yazi/yazi.toml".text = ''
            # A TOML linter such as https://taplo.tamasfe.dev/ can use this schema to validate your config.
            # If you encounter any issues, please make an issue at https://github.com/yazi-rs/schemas.
            "$schema" = "https://yazi-rs.github.io/schemas/yazi.json"

            [manager]
            ratio          = [ 1, 4, 3 ]
            sort_by        = "modified"
            sort_sensitive = true
            sort_reverse   = true
            sort_dir_first = true
            linemode       = "none"
            show_hidden    = false
            show_symlink   = true

            [preview]
            tab_size        = 2
            max_width       = 600
            max_height      = 900
            cache_dir       = ""
            image_filter    = "triangle"
            image_quality   = 75
            sixel_fraction  = 15
            ueberzug_scale  = 1
            ueberzug_offset = [ 0, 0, 0, 0 ]

            [opener]
            edit = [
                { exec = '$EDITOR "$@"', block = true,  for = "unix" },
                { exec = 'code "%*"',    orphan = true, for = "windows" },
            ]
            open = [
                { exec = 'xdg-open "$@"',                desc = "Open", for = "linux" },
                { exec = 'open "$@"',                    desc = "Open", for = "macos" },
                { exec = 'start "" "%1"', orphan = true, desc = "Open", for = "windows" }
            ]
            reveal = [
                { exec = 'open -R "$1"',                          desc = "Reveal", for = "macos" },
                { exec = 'explorer /select, "%1"', orphan = true, desc = "Reveal", for = "windows" },
                { exec = '''exiftool "$1"; echo "Press enter to exit"; read''', block = true, desc = "Show EXIF", for = "unix" },
            ]
            extract = [
                { exec = 'unar "$1"', desc = "Extract here", for = "unix" },
                { exec = 'unar "%1"', desc = "Extract here", for = "windows" },
            ]
            play = [
                { exec = 'mpv "$@"', orphan = true, for = "unix" },
                { exec = 'mpv "%1"', orphan = true, for = "windows" },
                { exec = '''mediainfo "$1"; echo "Press enter to exit"; read''', block = true, desc = "Show media info", for = "unix" },
            ]

            [open]
            rules = [
                { name = "*/", use = [ "edit", "open", "reveal" ] },

                { mime = "text/*",  use = [ "edit", "reveal" ] },
                { mime = "image/*", use = [ "open", "reveal" ] },
                { mime = "video/*", use = [ "play", "reveal" ] },
                { mime = "audio/*", use = [ "play", "reveal" ] },
                { mime = "inode/x-empty", use = [ "edit", "reveal" ] },

                { mime = "application/json", use = [ "edit", "reveal" ] },
                { mime = "*/javascript",     use = [ "edit", "reveal" ] },

                { mime = "application/zip",             use = [ "extract", "reveal" ] },
                { mime = "application/gzip",            use = [ "extract", "reveal" ] },
                { mime = "application/x-tar",           use = [ "extract", "reveal" ] },
                { mime = "application/x-bzip",          use = [ "extract", "reveal" ] },
                { mime = "application/x-bzip2",         use = [ "extract", "reveal" ] },
                { mime = "application/x-7z-compressed", use = [ "extract", "reveal" ] },
                { mime = "application/x-rar",           use = [ "extract", "reveal" ] },
                { mime = "application/xz",              use = [ "extract", "reveal" ] },

                { mime = "*", use = [ "open", "reveal" ] },
            ]

            [tasks]
            micro_workers    = 10
            macro_workers    = 25
            bizarre_retry    = 5
            image_alloc      = 536870912  # 512MB
            image_bound      = [ 0, 0 ]
            suppress_preload = false

            [plugin]

            preloaders = [
                { name = "*", cond = "!mime", exec = "mime", multi = true, prio = "high" },
                # Image
                { mime = "image/vnd.djvu", exec = "noop" },
                { mime = "image/*",        exec = "image" },
                # Video
                { mime = "video/*", exec = "video" },
                # PDF
                { mime = "application/pdf", exec = "pdf" },
            ]
            previewers = [
                { name = "*/", exec = "folder", sync = true },
                # Code
                { mime = "text/*",                 exec = "code" },
                { mime = "*/xml",                  exec = "code" },
                { mime = "*/javascript",           exec = "code" },
                { mime = "*/x-wine-extension-ini", exec = "code" },
                # JSON
                { mime = "application/json", exec = "json" },
                # Image
                { mime = "image/vnd.djvu", exec = "noop" },
                { mime = "image/*",        exec = "image" },
                # Video
                { mime = "video/*", exec = "video" },
                # PDF
                { mime = "application/pdf", exec = "pdf" },
                # Archive
                { mime = "application/zip",             exec = "archive" },
                { mime = "application/gzip",            exec = "archive" },
                { mime = "application/x-tar",           exec = "archive" },
                { mime = "application/x-bzip",          exec = "archive" },
                { mime = "application/x-bzip2",         exec = "archive" },
                { mime = "application/x-7z-compressed", exec = "archive" },
                { mime = "application/x-rar",           exec = "archive" },
                { mime = "application/xz",              exec = "archive" },
                # Fallback
                { name = "*", exec = "file" },
            ]

            [input]
            # cd
            cd_title  = "Change directory:"
            cd_origin = "top-center"
            cd_offset = [ 0, 2, 50, 3 ]

            # create
            create_title  = "Create:"
            create_origin = "top-center"
            create_offset = [ 0, 2, 50, 3 ]

            # rename
            rename_title  = "Rename:"
            rename_origin = "hovered"
            rename_offset = [ 0, 1, 50, 3 ]

            # trash
            trash_title 	= "Move {n} selected file{s} to trash? (y/N)"
            trash_origin	= "top-center"
            trash_offset	= [ 0, 2, 50, 3 ]

            # delete
            delete_title 	= "Delete {n} selected file{s} permanently? (y/N)"
            delete_origin	= "top-center"
            delete_offset	= [ 0, 2, 50, 3 ]

            # filter
            filter_title  = "Filter:"
            filter_origin = "top-center"
            filter_offset = [ 0, 2, 50, 3 ]

            # find
            find_title  = [ "Find next:", "Find previous:" ]
            find_origin = "top-center"
            find_offset = [ 0, 2, 50, 3 ]

            # search
            search_title  = "Search via {n}:"
            search_origin = "top-center"
            search_offset = [ 0, 2, 50, 3 ]

            # shell
            shell_title  = [ "Shell:", "Shell (block):" ]
            shell_origin = "top-center"
            shell_offset = [ 0, 2, 50, 3 ]

            # overwrite
            overwrite_title  = "Overwrite an existing file? (y/N)"
            overwrite_origin = "top-center"
            overwrite_offset = [ 0, 2, 50, 3 ]

            # quit
            quit_title  = "{n} task{s} running, sure to quit? (y/N)"
            quit_origin = "top-center"
            quit_offset = [ 0, 2, 50, 3 ]

            [select]
            open_title  = "Open with:"
            open_origin = "hovered"
            open_offset = [ 0, 1, 50, 7 ]

            [log]
            enabled = false
        '';
        ".config/nvim/init.lua".text = ''
            local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
            if not vim.loop.fs_stat(lazypath) then
              vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable", -- latest stable release
                lazypath,
              })
            end
            vim.opt.rtp:prepend(lazypath)

            require('plugins')
            require('options')
            require('colemak-dh')
            require('lsp')
            require('config')



            vim.cmd('colorscheme doom-one')
        '';
        ".config/nvim/lua/config.lua".text = ''
            require('config.neoscroll')
            require('config.lspkind')
            require('config.which-key')
            require('config.telescope')
            require('config.doom-one')
            require('config.possession')
            require('config.gitsigns')
            require('config.lualine')
            require('config.momento')
            require('config.colorizer')
            require('config.copilot')
            require('config.focus')
            require('config.treesitter')
            require('config.conjure')
            require('config.rainbow-delimiters')
            require('config.indent-blankline')
            require('config.markdown-preview')
            require('config.nvim-cmp')
            require('config.aerial')
            require('config.cursorline')
            require('config.fm-nvim')
            require('config.koka')
        '';
        ".config/nvim/lua/colemak-dh.lua".text = ''
            --| Colemak-DH Remaps |--
            vim.keymap.set('n', 't', 'i') -- insert
            vim.keymap.set('n', 'T', 'I') -- insert at bol

            vim.keymap.set("", 'm', 'h') -- left
            vim.keymap.set("", 'n', 'j') -- down
            vim.keymap.set("", 'e', 'k') -- up
            vim.keymap.set("", 'i', 'l') -- right

            vim.keymap.set("", 'M', 'H') -- screen top
            vim.keymap.set("", 'I', 'L') -- screen bottom
            vim.keymap.set("", 'K', 'M') -- screen mid'l


            vim.keymap.set("", 'j', 'n') -- Find prev
            vim.keymap.set("", 'J', 'N') -- Find next

            vim.keymap.set("", 'h', 'e') -- end WORD
            vim.keymap.set("", 'H', 'E') -- end word

            vim.keymap.set("", 'k', 't') -- back 'till
            vim.keymap.set("", 'K', 'T') -- back 'till

            vim.keymap.set("", '<c-w>m', '<c-w>h') -- left
            vim.keymap.set("", '<c-w>n', '<c-w>j') -- down
            vim.keymap.set("", '<c-w>e', '<c-w>k') -- up
            vim.keymap.set("", '<c-w>i', '<c-w>l') -- right
        '';
        ".config/nvim/lua/lsp.lua".text = ''
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                },
                registries = {
                    "github:Ki11erRabbit/mason-registry"
                }
            })

            require('mason-lspconfig').setup({
                -- A list of servers to automatically install if they're not already installed
                ensure_installed = { 'pylsp', 'gopls', 'lua_ls', 'rust_analyzer', 'clangd', 'hls', 'jdtls', 'yamlls' },
            })




            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require('lspconfig')

            lspconfig.clangd.setup {
                capabilities = capabilities,
            }

            lspconfig.hls.setup {
                capabilities = capabilities,
            }

            lspconfig.jdtls.setup {
                capabilities = capabilities,
            }

            lspconfig.pylsp.setup {
                capabilities = capabilities,
            }

            lspconfig.rust_analyzer.setup {
                capabilities = capabilities,
            }

            lspconfig.gopls.setup {
                capabilities = capabilities,
            }

            lspconfig.koka.setup {
                capabilities = capabilities,
            }

            lspconfig.yamlls.setup {
                capabilities = capabilities,
            }

            lspconfig.zls.setup {
                capabilities = capabilities,
            }





            vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)


            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('UserLspConfig', {}),
              callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'E', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-e>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<space>wl', function()
                  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<space>f', function()
                  vim.lsp.buf.format { async = true }
                end, opts)
              end,
            })
        '';
        ".config/nvim/lua/options.lua".text = ''
            -- Hint: use `:h <option>` to figure out the meaning if needed
            vim.opt.clipboard = 'unnamedplus'   -- use system clipboard 
            vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
            vim.opt.mouse = 'a'                 -- allow the mouse to be used in Nvim

            -- Tab
            vim.opt.tabstop = 4                 -- number of visual spaces per TAB
            vim.opt.softtabstop = 4             -- number of spacesin tab when editing
            vim.opt.shiftwidth = 4              -- insert 4 spaces on a tab
            vim.opt.expandtab = true            -- tabs are spaces, mainly because of python

            -- UI config
            vim.opt.number = true               -- show absolute number
            vim.opt.relativenumber = true       -- add numbers to each line on the left side
            vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
            vim.opt.splitbelow = true           -- open new vertical split bottom
            vim.opt.splitright = true           -- open new horizontal splits right
            vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
            --vim.opt.showmode = false            -- we are experienced, wo don't need the "-- INSERT --" mode hint

            -- Searching
            vim.opt.incsearch = true            -- search as characters are entered
            vim.opt.hlsearch = false            -- do not highlight matches
            vim.opt.ignorecase = true           -- ignore case in searches by default
            vim.opt.smartcase = true            -- but make it case sensitive if an uppercase is entered

            vim.opt.wildmode = 'longest,list,full'

            if vim.g.neovide then
                vim.o.guifont = 'JetBrainsMono_Nerd_Font:h12'

            end

            vim.api.nvim_create_autocmd('VimLeavePre', {
                desc = 'change cwd dir on close',
                pattern = '*',
                callback = function()
                    file = io.open('/tmp/nvim_cwd', 'w')
                    path = vim.loop.cwd()
                    print('Writing to file: ' .. path)
                    file:write(path)
                    io.close(file)
                end
            })
        '';
        ".config/nvim/lua/plugins.lua".text = ''
            plugins = {
                'lambdalisue/suda.vim',
                {
                    'nvim-lualine/lualine.nvim',
                    dependencies = { 'nvim-tree/nvim-web-devicons'}
                },
                --'NTBBloodbath/doom-one.nvim',
                'romgrk/doom-one.vim',
                "neovim/nvim-lspconfig",
                "hrsh7th/nvim-cmp",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "L3MON4D3/LuaSnip",
                "saadparwaiz1/cmp_luasnip",
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",

                "lukas-reineke/indent-blankline.nvim",

                "karb94/neoscroll.nvim",

                {
                    "nvim-telescope/telescope.nvim",
                    dependencies = { "nvim-lua/plenary.nvim" }
                },
                {
                    "nvim-telescope/telescope-file-browser.nvim",
                    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
                },
                "ludovicchabant/vim-gutentags",
                "stevearc/aerial.nvim",
                "folke/which-key.nvim",
                "lewis6991/gitsigns.nvim",
                "zbirenbaum/copilot.lua",
                "zbirenbaum/copilot-cmp",

                {
                    'jedrzejboczar/possession.nvim',
                    dependencies = { 'nvim-lua/plenary.nvim' },
                },
                'gaborvecsei/memento.nvim',

                'norcalli/nvim-colorizer.lua',

                'cohama/lexima.vim',

                { 'nvim-focus/focus.nvim', version = '*' },

                -- install with yarn or npm
                {
                  "iamcco/markdown-preview.nvim",
                  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
                  build = "cd app && yarn install",
                  init = function()
                    vim.g.mkdp_filetypes = { "markdown" }
                  end,
                  ft = { "markdown" },
                },

                'HiPhish/rainbow-delimiters.nvim',

                'nvim-treesitter/nvim-treesitter',
                'onsails/lspkind.nvim',


                {
                    "Olical/conjure",
                    ft = { "clojure", "fennel", "python" }, -- etc
                    -- [Optional] cmp-conjure for cmp
                    dependencies = {
                        {
                            "PaterJason/cmp-conjure",
                        },
                    },
                    config = function(_, opts)
                        require("conjure.main").main()
                        require("conjure.mapping")["on-filetype"]()
                    end,
                    init = function()
                           -- Set configuration options here
                        vim.g["conjure#debug"] = true
                    end,
                },

                'yamatsum/nvim-cursorline',
                'Ki11erRabbit/fm-nvim',
                'elkasztano/nushell-syntax-vim',
                'junegunn/vim-plug',



            }
        '';
        ".config/nvim/lua/config/aerial.lua".text = ''
            require("aerial").setup({
              -- optionally use on_attach to set keymaps when aerial has attached to a buffer
              on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
              end,
            })
            -- You probably also want to set a keymap to toggle aerial
            vim.keymap.set("n", "<space>a", "<cmd>AerialToggle!<CR>")
        '';
        ".config/nvim/lua/config/colorizer.lua".text = "require('colorizer').setup()";
        ".config/nvim/lua/config/conjure.lua".text = '''';
        ".config/nvim/lua/config/copilot.lua".text = ''
            require('copilot').setup({
              panel = {
                enabled = false,
                auto_refresh = true,
                keymap = {
                  jump_prev = "[[",
                  jump_next = "]]",
                  accept = "<CR>",
                  refresh = "gr",
                  open = "<M-CR>"
                },
                layout = {
                  position = "bottom", -- | top | left | right
                  ratio = 0.4
                },
              },
              suggestion = {
                enabled = false,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                  accept = "<M-i>",
                  accept_word = false,
                  accept_line = false,
                  next = "<M-]>",
                  prev = "<M-[>",
                  dismiss = "<C-]>",
                },
              },
              filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
              },
              copilot_node_command = 'node', -- Node.js version must be > 18.x
              server_opts_overrides = {},
            })
        '';
        ".config/nvim/lua/config/cursorline.lua".text = ''
            require('nvim-cursorline').setup {
              cursorline = {
                enable = true,
                timeout = 1000,
                number = false,
              },
              cursorword = {
                enable = true,
                min_length = 3,
                hl = { underline = true },
              }
            }
        '';
        ".config/nvim/lua/config/doom-one.lua".text = "vim.g[\"doom_one_terminal_colors\"] = true";
        ".config/nvim/lua/config/doom-one.vim".text = "let g:doom_one_terminal_colors = v:true";
        ".config/nvim/lua/config/fm-nvim.lua".text = ''
            local function close_func()
                cwd = io.open("/tmp/yazi-cwd", "r")
                path = cwd:read()
                vim.cmd("cd " .. path)
                io.close(cwd)
            end

            require('fm-nvim').setup{
                -- (Vim) Command used to open files
                edit_cmd = "edit",

                -- See `Q&A` for more info
                on_close = { close_func },
                on_open = {},

                -- UI Options
                ui = {
                    -- Default UI (can be "split" or "float")
                    default = "float",

                    float = {
                        -- Floating window border (see ':h nvim_open_win')
                        border    = "none",

                        -- Highlight group for floating window/border (see ':h winhl')
                        float_hl  = "Normal",
                        border_hl = "FloatBorder",

                        -- Floating Window Transparency (see ':h winblend')
                        blend     = 0,

                        -- Num from 0 - 1 for measurements
                        height    = 0.8,
                        width     = 0.8,

                        -- X and Y Axis of Window
                        x         = 0.5,
                        y         = 0.5
                    },

                    split = {
                        -- Direction of split
                        direction = "topleft",

                        -- Size of split
                        size      = 24
                    }
                },

                -- Terminal commands used w/ file manager (have to be in your $PATH)
                cmds = {
                    lf_cmd      = "lf", -- eg: lf_cmd = "lf -command 'set hidden'"
                    fm_cmd      = "fm",
                    nnn_cmd     = "nnn",
                    fff_cmd     = "fff",
                    twf_cmd     = "twf",
                    fzf_cmd     = "fzf", -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
                    fzy_cmd     = "find . | fzy",
                    xplr_cmd    = "xplr",
                    vifm_cmd    = "vifm",
                    skim_cmd    = "sk",
                    broot_cmd   = "broot",
                    gitui_cmd   = "gitui",
                    ranger_cmd  = "ranger",
                    joshuto_cmd = "joshuto",
                    lazygit_cmd = "lazygit",
                    neomutt_cmd = "neomutt",
                    taskwarrior_cmd = "taskwarrior-tui",
                    yazi_cmd = "yazi",
                },

                -- Mappings used with the plugin
                mappings = {
                    vert_split = "<C-v>",
                    horz_split = "<C-h>",
                    tabedit    = "<C-t>",
                    edit       = "<C-e>",
                    ESC        = "<ESC>"
                },

                -- Path to broot config
                broot_conf = vim.fn.stdpath("data") .. "/site/pack/packer/start/fm-nvim/assets/broot_conf.hjson"
            }
        '';
        ".config/nvim/lua/config/focus.lua".text = ''
            require('focus').setup()

            local focusmap = function(direction)
                vim.keymap.set('n', '<Leader>'..direction, function()
                    require('focus').split_command(direction)
                end, { desc = string.format('Create or move to split (%s)', direction) })
            end

            -- Use `<Leader>h` to split the screen to the left, same as command FocusSplitLeft etc
            focusmap('m')
            focusmap('n')
            focusmap('e')
            focusmap('i')
        '';
        ".config/nvim/lua/config/gitsigns.lua".text = ''
            require('gitsigns').setup {
              signs = {
                add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
              },
              signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
              numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
              linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
              word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
              watch_gitdir = {
                interval = 1000,
                follow_files = true
              },
              attach_to_untracked = true,
              current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
              current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
              },
              current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
              sign_priority = 6,
              update_debounce = 100,
              status_formatter = nil, -- Use default
              max_file_length = 40000, -- Disable if file is longer than this (in lines)
              preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
              },
              yadm = {
                enable = false
              },
            }
        '';
        ".config/nvim/lua/config/indent-blankline.lua".text = ''
            require("ibl").setup()

            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup { scope = { highlight = highlight } }

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        '';
        ".config/nvim/lua/config/koka.lua".text = ''
            local vim = vim
            local Plug = vim.fn['plug#']

            vim.call('plug#begin')

            Plug('https://github.com/koka-lang/koka', { ['rtp'] = 'support/vim' })

            vim.call('plug#end')
        '';
        ".config/nvim/lua/config/lspkind.lua".text = ''
            require('lspkind').init({
                -- DEPRECATED (use mode instead): enables text annotations
                --
                -- default: true
                -- with_text = true,

                -- defines how annotations are shown
                -- default: symbol
                -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
                mode = 'symbol_text',

                -- default symbol map
                -- can be either 'default' (requires nerd-fonts font) or
                -- 'codicons' for codicon preset (requires vscode-codicons font)
                --
                -- default: 'default'
                preset = 'default',

                -- override preset symbols
                --
                -- default: {}
                symbol_map = {
                  Text = "󰉿",
                  Method = "󰆧",
                  Function = "󰊕",
                  Constructor = "",
                  Field = "󰜢",
                  Variable = "󰀫",
                  Class = "󰠱",
                  Interface = "",
                  Module = "",
                  Property = "󰜢",
                  Unit = "󰑭",
                  Value = "󰎠",
                  Enum = "",
                  Keyword = "󰌋",
                  Snippet = "",
                  Color = "󰏘",
                  File = "󰈙",
                  Reference = "󰈇",
                  Folder = "󰉋",
                  EnumMember = "",
                  Constant = "󰏿",
                  Struct = "󰙅",
                  Event = "",
                  Operator = "󰆕",
                  TypeParameter = "",
                  Copilot = ""
                },
            })


            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
        '';
        ".config/nvim/lua/config/lualine.lua".text = "require('lualine').setup()";
        ".config/nvim/lua/config/markdown-preview.lua".text = "vim.api.nvim_set_keymap(\"n\",\"<space>mp\", \":MarkdownPreviewToggle<cr>\", { noremap = true })";
        ".config/nvim/lua/config/momento.lua".text = "vim.g.memento_history = 20";
        ".config/nvim/lua/config/neoscroll.lua".text = "require('neoscroll').setup()";
        ".config/nvim/lua/config/nvim-cmp.lua".text = ''
            require('copilot_cmp').setup()

            local cmp = require('cmp')

            local has_words_before = function()
                if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then return false end
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
            end

            cmp.setup {
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = 'luasnip', group_index = 2 },
                    { name = 'copilot', group_index = 2 },
                    { name = 'nvim_lsp', group_index = 2 },
                    { name = 'buffer', group_index = 2 },
                    { name = 'path', group_index = 2 },
                    { name = 'cmdline', group_index = 2},
                    { name = 'conjure', group_index = 2},

                },
                completion = {
                    completeopt = 'menu,menuone',
                },
                mapping = {
                    ['<C-e>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-c>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                    ['<Tab>'] = vim.schedule_wrap(function(fallback)
                        if cmp.visible() and has_words_before() then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            fallback()
                        end
                    end),
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                    require("copilot_cmp.comparators").prioritize,
                    cmp.config.compare.offset,
                    -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                    },
                },
            }
        '';
        ".config/nvim/lua/config/possession.lua".text = ''
            require('possession').setup {
                autosave = {
                    current = true,
                    tmp = true,
                    tmp_name = 'tmp',
                    on_load = true,
                    on_quit = true,
                },
            }
        '';
        ".config/nvim/lua/config/rainbow-delimiters.lua".text = "require('rainbow-delimiters.setup').setup()";
        ".config/nvim/lua/config/telescope.lua".text = ''
            require('telescope').setup {
                extensions = {
                    file_browser = {},
                }
            }

            require('telescope').load_extension('file_browser')
            --require('telescope').load_extension('possession')


            local home = os.getenv('HOME')

            local g = vim.g
            local o = vim.o
            local a = vim.api


            a.nvim_set_keymap("n", "<space>fd", ":Telescope file_browser path=" .. home .. "/.config/nvim<cr>", { noremap = true })
            a.nvim_set_keymap("n", "<space>fw", ":Telescope live_grep<cr>", { noremap = true })
            a.nvim_set_keymap("n", "<space>ff", ":Telescope find_files find_command=rg,--hidden,--files<cr>", { noremap = true })
            a.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser<cr>", { noremap = true })
                    '';
                    ".config/nvim/lua/config/treesitter.lua".text = ''
                        require("lazy").setup({{
                            "nvim-treesitter/nvim-treesitter",
                            build = ":TSUpdate",
                            config = function () 
                              local configs = require("nvim-treesitter.configs")

                              configs.setup({
                                  ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "haskell", "javascript", "html", "c++" },
                                  sync_install = false,
                                  highlight = { enable = false },
                                  indent = { enable = true },  
                                })
                            end,
                         }})

                         require('nvim-treesitter.configs').setup {
                             rainbow = {
                                 enable = true,
                             },
                         }
        '';
        ".config/nvim/lua/config/which-key.lua".text = "require('which-key').setup{}";
        ".config/kmonad/t440p.kbd".text = ''
            (defcfg
                input (device-file "/dev/input/by-path/platform-i8042-serio-0-event-kbd")
                output (uinput-sink "T440p Keyboard")
                cmp-seq ralt
                cmp-seq-delay 5
                fallthrough true
                allow-cmd false
            )

            (defalias 
                srch KeySearch
                vido KeySwitchVideoMode
                cfg  KeyConfig
                lnch KeyScale
                cctl (layer-toggle colemakctl)
                qctl (layer-toggle qwertyctl)
                swchq (layer-switch qwerty)
                swchc (layer-switch colemak)
                fn (layer-toggle function)

            )



            (defsrc
                esc  mute vold volu f20  brdn brup KeySwitchVideoMode wlan  KeyConfig  KeySearch KeyScale file   home  end   ins   del
                grv  1    2    3    4    5    6    7    8    9    0    -    =     bspc
                tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
                caps a    s    d    f    g    h    j    k    l    ;    '    ret
                lsft z    x    c    v    b    n    m    ,    .    /    rsft
                lctl wkup lmet lalt      spc            ralt ssrq rctl pgup up   pgdn
                                                                       left down rght
            )

            (deflayer colemak
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  @srch @lnch file   home  end   ins   del
                grv   1     2     3     4     5    6    7     8     9     0     -     =      caps
                tab   q     w     f     p     b    j    l     u     y     ;     [     ]     \
                bspc  a     r     s     t     g    m    n     e     i     o     '     ret
                lsft  x     c     d     v     z    k    h     ,     .     /     rsft
                @cctl @fn   lalt  lmet        spc             ralt  ssrq  @cctl pgup  up    pgdn
                                                                                left  down  rght
            )
            (deflayer colemakctl
                C-esc   C-mute  C-vold  C-volu  C-f20   C-brdn C-brup C-@vido C-wlan  C-@cfg  C-@srch C-@lnch C-file   C-home  C-end   C-ins   C-del
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-f     C-p     C-b    C-j    C-l     C-u     C-y     C-;     C-[     C-]      C-\
                C-bspc  C-a     C-r     C-s     C-t     C-g    C-m    C-n     C-e     C-i     C-o     C-'     C-ret
                C-lsft  C-x     C-c     C-d     C-v     C-z    C-k    C-h     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchq                C-ralt  C-ssrq  C-rctl  C-pgup  C-up    C-pgdn
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer qwerty
                esc   mute  vold  volu  f20   brdn brup @vido wlan  @cfg  @srch @lnch file   home  end   ins   del
                grv   1     2     3     4     5    6    7     8     9     0     -     =      bspc
                tab   q     w     e     r     t    y    u     i     o     p     [     ]      \
                caps  a     s     d     f     g    h    j     k     l     ;     '     ret
                lsft  z     x     c     v     b    n    m     ,     .     /     rsft
                @qctl @fn   lalt  lmet        spc             ralt  ssrq  @qctl pgup  up    pgdn
                                                                                left  down  rght
            )

            (deflayer qwertyctl
                C-esc   C-mute  C-vold  C-volu  C-f20   C-brdn C-brup C-@vido C-wlan  C-@cfg  C-@srch C-@lnch C-file   C-home  C-end   C-ins   C-del
                C-grv   C-1     C-2     C-3     C-4     C-5    C-6    C-7     C-8     C-9     C-0     C--     C-=      C-caps
                C-tab   C-q     C-w     C-e     C-r     C-t    C-y    C-u     C-i     C-o     C-p     C-[     C-]      C-\
                C-bspc  C-a     C-s     C-d     C-f     C-g    C-h    C-j     C-k     C-l     C-;     C-'     C-ret
                C-lsft  C-z     C-x     C-c     C-v     C-b    C-n    C-m     C-,     C-.     C-/     C-rsft
                _       _       C-lalt  C-lmet          @swchc                C-ralt  C-ssrq  C-rctl  C-pgup  C-up    C-pgdn
                                                                                                      C-left  C-down  C-rght
            )

            (deflayer function
                _    f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12   _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _    _     _   
                _    _    _    _    _    _    _    _    _    _    _    _    _    _
                _    _    _    _    _    _    _    _    _    _    _    _    _  
                _    _    _    _    _    _    _    _    _    _    _    _   
                _    _    _    _         _              _    _    _    _    _    _   
                                                                       _    _    _   
            )
        '';
        ".config/river/init".text = ''
            #!/bin/sh

            # This is the example configuration file for river.
            #
            # If you wish to edit this, you will probably want to copy it to
            # $XDG_CONFIG_HOME/river/init or $HOME/.config/river/init first.
            #
            # See the river(1), riverctl(1), and rivertile(1) man pages for complete
            # documentation.

            # Note: the "Super" modifier is also known as Logo, GUI, Windows, Mod4, etc.

            export PATH="$HOME/.cargo/bin:$PATH"


            # Super+Return to start an instance of foot (https://codeberg.org/dnkl/foot)
            riverctl map normal Super Return spawn alacritty

            riverctl map normal Super+Shift Return spawn neovide

            # Super+D to start an instance of bemenu
            riverctl map normal Super D spawn bemenu-run


            riverctl map normal Super S spawn 'grimshot save area'
            riverctl map normal Super+Shift S spawn 'grimshot copy area'
            riverctl map normal None Print spawn 'grimshot save screen'
            riverctl map normal Shift Print spawn 'grimshot copy screen'

            riverctl map normal Super R spawn dolphin
            riverctl map normal None XF86Explorer spawn 'dolphin'

            riverctl map normal Super+Shift W spawn '/home/ki11errabbit/.local/bin/screen-toggle.sh'

            riverctl map normal None XF86MonBrightnessUp spawn 'light -A 30'
            riverctl map normal None XF86MonBrightnessDown spawn 'light -U 30'

            riverctl map normal None XF86AudioMicMute spawn 'amixer set Capture toggle'

            riverctl map normal None XF86Tools spawn '/home/ki11errabbit/.local/bin/nix-config.sh'

            riverctl map normal None XF86Search spawn 'bemenu-run'
            riverctl map normal None XF86WLAN spawn 'alacritty -e nmtui'
            riverctl map normal None XF86Display spawn 'wdisplays'

            # Super+Q to close the focused view
            riverctl map normal Super Q close

            # Super+Shift+E to exit river
            riverctl map normal Super+Shift Q exit

            # Super+J and Super+K to focus the next/previous view in the layout stack
            riverctl map normal Super N focus-view next
            riverctl map normal Super E focus-view previous

            # Super+Shift+J and Super+Shift+K to swap the focused view with the next/previous
            # view in the layout stack
            riverctl map normal Super+Shift N swap next
            riverctl map normal Super+Shift E swap previous

            # Super+Period and Super+Comma to focus the next/previous output
            riverctl map normal Super Period focus-output next
            riverctl map normal Super Comma focus-output previous

            # Super+Shift+{Period,Comma} to send the focused view to the next/previous output
            riverctl map normal Super+Shift Period send-to-output next
            riverctl map normal Super+Shift Comma send-to-output previous

            # Super+Return to bump the focused view to the top of the layout stack
            riverctl map normal Super+Control Return zoom

            # Super+H and Super+L to decrease/increase the main ratio of rivertile(1)
            riverctl map normal Super M send-layout-cmd rivertile "main-ratio -0.05"
            riverctl map normal Super I send-layout-cmd rivertile "main-ratio +0.05"

            # Super+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
            riverctl map normal Super+Shift M send-layout-cmd rivertile "main-count +1"
            riverctl map normal Super+Shift I send-layout-cmd rivertile "main-count -1"

            # Super+Alt+{H,J,K,L} to move views
            riverctl map normal Super+Alt M move left 100
            riverctl map normal Super+Alt N move down 100
            riverctl map normal Super+Alt E move up 100
            riverctl map normal Super+Alt I move right 100

            # Super+Alt+Control+{H,J,K,L} to snap views to screen edges
            riverctl map normal Super+Alt+Control M snap left
            riverctl map normal Super+Alt+Control N snap down
            riverctl map normal Super+Alt+Control E snap up
            riverctl map normal Super+Alt+Control I snap right

            # Super+Alt+Shift+{H,J,K,L} to resize views
            riverctl map normal Super+Alt+Shift M resize horizontal -100
            riverctl map normal Super+Alt+Shift N resize vertical 100
            riverctl map normal Super+Alt+Shift E resize vertical -100
            riverctl map normal Super+Alt+Shift I resize horizontal 100

            riverctl map normal Super L spawn '/home/ki11errabbit/.cargo/bin/flow cycle-tags previous'
            riverctl map normal Super U spawn '/home/ki11errabbit/.cargo/bin/flow cycle-tags next'

            # Super + Left Mouse Button to move views
            riverctl map-pointer normal Super BTN_LEFT move-view

            # Super + Right Mouse Button to resize views
            riverctl map-pointer normal Super BTN_RIGHT resize-view

            # Super + Middle Mouse Button to toggle float
            riverctl map-pointer normal Super BTN_MIDDLE toggle-float

            for i in $(seq 1 9)
            do
                tags=$((1 << ($i - 1)))

                # Super+[1-9] to focus tag [0-8]
                riverctl map normal Super $i set-focused-tags $tags

                # Super+Shift+[1-9] to tag focused view with tag [0-8]
                riverctl map normal Super+Shift $i set-view-tags $tags

                # Super+Ctrl+[1-9] to toggle focus of tag [0-8]
                riverctl map normal Super+Control $i toggle-focused-tags $tags

                # Super+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
                riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
            done

            # Super+0 to focus all tags
            # Super+Shift+0 to tag focused view with all tags
            all_tags=$(((1 << 32) - 1))
            riverctl map normal Super 0 set-focused-tags $all_tags
            riverctl map normal Super+Shift 0 set-view-tags $all_tags

            # Super+Space to toggle float
            riverctl map normal Super+Shift F toggle-float

            # Super+F to toggle fullscreen
            riverctl map normal Super F toggle-fullscreen

            # Super+{Up,Right,Down,Left} to change layout orientation
            riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
            riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
            riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
            riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

            # Declare a passthrough mode. This mode has only a single mapping to return to
            # normal mode. This makes it useful for testing a nested wayland compositor
            riverctl declare-mode passthrough

            # Super+F11 to enter passthrough mode
            riverctl map normal Super F11 enter-mode passthrough

            # Super+F11 to return to normal mode
            riverctl map passthrough Super F11 enter-mode normal

            # Various media key mapping examples for both normal and locked mode which do
            # not have a modifier
            for mode in normal locked
            do
                # Eject the optical drive (well if you still have one that is)
                riverctl map $mode None XF86Eject spawn 'eject -T'

                # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
                riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5 && pkill -RTMIN+8 waybar'
                riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5 && pkill -RTMIN+8 waybar'
                riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute && pkill -RTMIN+8 waybar'

                # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
                riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
                riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
                riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
                riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

                # Control screen backlight brightness with light (https://github.com/haikarainen/light)
                riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 5'
                riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5'
            done

            # Set background and border color
            #riverctl background-color 0x002b36
            riverctl background-color 0x282c34
            riverctl border-color-focused 0x51afef
            riverctl border-color-unfocused 0x282c34

            # Set keyboard repeat rate
            riverctl set-repeat 50 300

            # Make certain views start floating
            riverctl float-filter-add app-id float
            riverctl float-filter-add title "popup title with spaces"

            # Set app-ids and titles of views which should use client side decorations
            riverctl csd-filter-add app-id "gedit"

            # Set the default layout generator to be rivertile and start it.
            # River will send the process group of the init executable SIGTERM on exit.
            riverctl default-layout rivertile
            rivertile -view-padding 6 -outer-padding 6 &


            waybar &
            fnott &

            riverctl focus-follows-cursor always
            riverctl xcursor-theme Posy_Cursor 32

            /home/ki11errabbit/.local/bin/configure-monitors.sh &

            /home/ki11errabbit/.local/bin/setup-wallpaper.sh &

            /home/ki11errabbit/.local/bin/setup-swayidle.sh &

            /home/ki11errabbit/.local/bin/setup-keyboard.sh &

            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river &
            #dbus-daemon --session --address="unix:path=$XDG_RUNTIME_DIR/bus" &

            nm-applet &
            blueman-applet &
            kdeconnect-indicator &
        '';
        ".config/waybar/scripts/pipewire.sh".text = ''
            #!/bin/sh


            [ $(pamixer --get-mute) = true ] && echo "🔇 " && exit

            vol="$(pamixer --get-volume)"

            if [ "$vol" -gt "99" ]; then
                icon="🔊"
            elif [ "$vol" -gt "70" ]; then
                icon="🔊 "
            elif [ "$vol" -gt "30" ]; then
                icon="🔉 "
            elif [ "$vol" -gt "9" ]; then
                icon="🔉 "
            elif [ "$vol" -gt "0" ]; then
                icon="🔈  "
            else
                    echo " 🔇  $vol%" && exit
            fi

            echo "$icon$vol%"
        '';
        ".config/waybar/scripts/pipewire.sh".text = ''
            #!/bin/sh

            # Displays todays precipication chance (☔) and daily low (🥶) and high (🌞).
            # Usually intended for the statusbar.

            # If we have internet, get a weather report from wttr.in and store it locally.
            # You could set up a shell alias to view the full file in a pager in the
            # terminal if desired. This function will only be run once a day when needed.
            weatherreport="${XDG_DATA_HOME:-$HOME/.local/dashare}/weatherreport"
            getforecast() { curl -sf "wttr.in/$LOCATION" > "$weatherreport" || exit 1 ;}
            currweather=$(curl -sf "wttr.in/$LOCATION?format=%c%t+%h\n")
            # | sed 's/ //')
            #weather_option=$(cat ~/.dwm/blocks-scripts/helper-scripts/weather_option)
            if [ -z $WEATHER_OPTION ]; then
                export WEATHER_OPTION=0
            fi
            # Some very particular and terse stream manipulation. We get the maximum
            # precipitation chance and the daily high and low from the downloaded file and
            # display them with coresponding emojis.
            showweather() { printf "%s" "$(sed '16q;d' "$weatherreport" |
                grep -wo "[0-9]*%" | sort -rn | sed "s/^/☔/g;1q" | tr -d '\n')"
            sed '13q;d' "$weatherreport" | grep -o "m\\([-+]\\)*[0-9]\\+" | sed 's/+//g' | sort -n -t 'm' -k 2n | sed -e 1b -e '$!d' | tr '\n|m' ' ' | awk '{print " 🥶" $1 "°","🌞" $2 "°"}' ;}


            # The test if our forcecast is updated to the day. If it isn't download a new
            # weather report from wttr.in with the above function.
            [ "$(stat -c %y "$weatherreport" 2>/dev/null | cut -d' ' -f1)" = "$(date '+%Y-%m-%d')" ] ||
                getforecast

            case $1 in
                1) getforecast
                   echo "$(showweather) "
                   export WEATHER_OPTION=0 #echo 0 > /tmp/weather_option
                   ;;
                0) echo "$currweather ";;
            esac

            #echo 0 > ~/.dwm/blocks-scripts/helper-scripts/weather_option
        '';
    };


  programs.git = {
    enable = true;
    userName = "Alec Davis";
    userEmail = "unlikelytitan@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.size = 1500;
    history.save = 1000;
    history.path = "${config.xdg.dataHome}/.histfile";
    autocd = true;
    
    shellAliases = {
        cd = "z";
        home = "cd";
        root = "cd /";
        bat = "bat --style plain";
        batf = "bat --style full";
        ls = "exa --icons";
        tree = "exa --tree --icons";
        cp = "cp -iv";
        mv = "mv -iv";
        rm = "trash -v";
        grep = "grep --color=auto";
    };
    localVariables = {
        PROMPT = "❬%F{13}%n%f❭ %f%F{13}図書館に%f %F{12}%d\n%f ";
    };

    sessionVariables = {
        BEMENU_OPTS = "--tb #282c34 --tf #51afef --nb #282c34 --nf #bbc2cf --sb #51afef --sf #444b59 --fb #282c34 --ff #bbc2cf --hb #51afef --hf #444b59 --ab #282c34 --af #bbc2cf";
        PATH = "$PATH:/home/ki11errabbit/.cabal/bin:/home/ki11errabbit/.local/bin:$PATH:/home/ki11errabbit/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/home/ki11errabbit/.cargo/bin";
    };

    initExtra = ''
    setopt globdots
    function ya() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    }


    function neovim() {
        local tmp="/tmp/nvim_cwd"
        nvim "$@" 
        cwd="$(cat -- "$tmp")"
        cd -- "$cwd"
        rm -f -- "$tmp"
    }

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/ki11errabbit/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/ki11errabbit/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/ki11errabbit/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/ki11errabbit/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    eval "$(zoxide init zsh)"
    '';

  };

  services.kdeconnect.indicator = true;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ki11errabbit/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

