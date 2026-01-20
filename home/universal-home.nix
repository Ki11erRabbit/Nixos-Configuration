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

    programs.git.enable = true;
    programs.git.settings = {
        user.name = "Alec Davis";
        user.email = "unlikelytitan@gmail.com";
        extraConfig = {
            init = {
                defaultBranch = "main";
            };
            core = {
                editor = "nvim";
            };
        };
    };
    
    programs.nushell = {
        enable = true;
        configFile.source = ../files/config.nu;
        shellAliases = {
            cd = "z";
            bat = "bat --style plain";
            batf = "bat --style full";
            #ls = "exa --icons";
            #tree = "exa --tree --icons";
            cp = "cp -iv";
            mv = "mv -iv";
            rm = "trash -v";
            grep = "grep --color=auto";
            emacs = "emacsclient -c -a \"emacs\"";
            
        };
    };

    programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
    };
    
    programs.zoxide = {
        enable = true;
        enableNushellIntegration = true;
    };

    programs.starship = {
        enable = true;
        settings = {
            format = "❬$username❭ $directory\n$character";
            
            username = {
                format = "[$user]($style)";
                style_user = "purple";
                style_root = "bold red";
                show_always = true;
            };

            directory = {
                format = "[$path]($style)";
                style = "fg:cyan";
                truncation_length = 0;
                truncate_to_repo = false;
            };
            add_newline = false;
            character = {
                success_symbol = " ";
                error_symbol = " ";
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
        #initContent = builtins.readFile(../files/zsh);
        initContent = ''
if [[ -o interactive ]]; then
    exec nu
fi
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
        extraConfig = builtins.readFile(../files/tmux);
    };

    home.sessionVariables = {
        # EDITOR = "emacs";
    };
}
