{ lib, inputs, config, pkgs, channels, ... }:
{
    home.username = "ki11errabbit";
    
    home.stateVersion = "25.05"; # Please read the comment before changing.
    nixpkgs.config.allowUnfree = true;

    programs.home-manager.enable = true;

    services.emacs = {
        enable = true;
        package = pkgs.emacs-pgtk;
    };

    programs.git = {
        enable = true;
        userName = "Alec Davis";
        userEmail = "unlikelytitan@gmail.com";
        extraConfig = {
            init = {
                defaultBranch = "main";
            };
            core = {
                editor = "nvim";
            };
        };
    };

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        history.size = 1500;
        history.save = 1000;
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
            emacs = "emacsclient -c -a \"emacs\"";
            mpv = "mpv";
        };
        localVariables = {
            PROMPT = "❬%F{13}%n%f❭ %f%F{13}図書館に%f %F{12}%d\n%f ";
        };

        sessionVariables = {
            BEMENU_OPTS = "--fb '#eff1f5' --ff '#4c4f69' --nb '#eff1f5' --nf '#4c4f69' --tb '#eff1f5' --hb '#eff1f5' --tf '#d20f39' --hf '#df8e1d' --af '#4c4f69' --ab '#eff1f5'";

            PATH = "$PATH:/home/ki11errabbit/.cabal/bin:/home/ki11errabbit/.local/bin:$PATH:/home/ki11errabbit/.local/share/flatpak/exports/bin:/var/lib/flatpak/exports/bin:/home/ki11errabbit/.cargo/bin";
        };

        initContent = ''
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

        eval "$(zoxide init zsh)"
        function refresh-nix() {
            dir=$PWD
            cd ~/
            home-manager switch --flake ./git/Nixos-Configuration/#macos
            cd $dir
        }
        '';

    };

    home.packages = with pkgs; [
        neovim
        wget
        zsh
        rustup
        eza
        cmake
        fd
        jq
        libunwind
        git
        firefox
        thunderbird
        neovide
        keepassxc
        eza
        yazi
        lua-language-server
        universal-ctags
        vscode
        haskellPackages.lsp
        python312Packages.python-lsp-server
        gopls
        libclang
        jdt-language-server
        yaml-language-server
        twitter-color-emoji
        zig
        zls
        idris2
        emacs-pgtk
        stack
        cabal-install
        ghc
        go
        python3
        luajit
        yarn
        nodejs
        fzf
        ripgrep
        bat
        dash
        mpv
        stow
        xournalpp
        trash-cli
        zoxide
        delta
        dust
        fd
        hexyl
        procs
        #jellyfin-media-player
        jdk21
        erlang
        helix
        kakoune
        guile
        awscli2
        ocaml
        hugo
        inkscape
        librsvg
        sshfs
        superhtml
        gdb
        tmux
        typescript
        bitwarden-desktop
        jetbrains.rust-rover
        jetbrains.idea-ultimate
        cargo-generate
        jetbrains.clion
        jetbrains.rider
        fselect
        mask
        rusty-man
        evince
        editorconfig-core-c
        imagemagick
        bc
        podman-desktop
        podman
        podman-compose
        inputs.lem.packages."${system}".lem-sdl2
        
    ];

    programs.alacritty = {
        enable = true;
        settings = {
            colors = {
                draw_bold_text_with_bright_colors = false;
                normal = {
                    black = "0xbcc0cc";
                    blue = "0x1e66f5";
                    cyan = "0x179299";
                    green = "0x40a02b";
                    magenta = "0xea76cb";
                    red = "0xd20f39";
                    white = "0x5c5f77";
                    yellow = "0xdf8e1d";
                };
                bright = {
                    black = "0xacb0be";
                    blue = "0x1e66f5";
                    cyan = "0x179299";
                    green = "0x40a02b";
                    magenta = "0xea76cb";
                    red = "0xd20f39";
                    white = "0x6c6f85";
                    yellow = "0xdf8e1d";
                };
                primary = {
                    background = "0xeff1f5";
                    foreground = "0x4c4f69";
                };

            };
            cursor = {
                style = {
                    blinking = "On";
                    shape = "Beam";
                };
            };
            font = {
                size = 11;
                normal = {
                    family = "monospace";
                    style = "Text";
                };
                bold = {
                    family = "monospace";
                    style = "Bold";
                };
                bold_italic = {
                    family = "monospace";
                    style = "Bold Italic";
                };
                italic = {
                    family = "monospace";
                    style = "Text Italic";
                };

            };
            keyboard.bindings = [{
                action = "SpawnNewInstance";
                key = "Return";
                mods = "Control|Shift";
            }];
            scrolling.history = 50000;
            window.padding = {
                x = 0;
                y = 0;
            };
        };
    };
    
    programs.tmux = {
        enable = true;
        clock24 = false;
        extraConfig = ''
unbind r
bind r source-file ~/.tmux.conf

# For use in kakoune
set -g prefix C-w

bind v split-window -h
bind s split-window -v

unbind '"'
unbind %

set -g mouse on

unbind m
unbind n
unbind e
unbind i

bind m select-pane -L
bind n select-pane -D
bind e select-pane -U
bind i select-pane -R

unbind l
unbind u

bind l select-window -p
bind u select-window -n

set -g status-position top
set -g status-left "#[fg=magenta,bold,bg=#eff1f5] #S "
set -g status-right "#[fg=magenta,bold,bg=#eff1f5] %l:%M %p"
set -g status-style "bg=#eff1f5"
set -g default-terminal "screen-256color"
        '';
    };

    home.sessionVariables = {
        # EDITOR = "emacs";
    };
}
