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

