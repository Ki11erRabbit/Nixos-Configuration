{ lib, inputs, config, pkgs, channels,  ... }:

{
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    home.username = "ki11errabbit";
    home.homeDirectory = "/Users/ki11errabbit";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "25.05"; # Please read the comment before changing.
    nixpkgs.config.allowUnfree = true;

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
        firefox
        thunderbird
        discord
        neovide
        keepassxc
        eza
        slack
        obs-studio
        libreoffice
        yazi
        neofetch
        lua-language-server
        universal-ctags
        vscode
        haskellPackages.lsp
        rust-analyzer
        python312Packages.python-lsp-server
        gopls
        libclang
        jdt-language-server
        yaml-language-server
        twitter-color-emoji
        zig
        zls
        idris2
        emacs
        stack
        cabal-install
        ghc
        go
        python3
        racket
        luajit
        google-chrome
        yarn
        nodejs
        fzf
        ripgrep
        bat
        dash
        mpv
        transmission-remote-gtk
        transmission_4-gtk
        stow
        haskellPackages.kmonad
        xournalpp
        gimp
        godot-mono
        trash-cli
        zoxide
        delta
        du-dust
        fd
        hexyl
        procs
        jellyfin-media-player
        jdk21
        erlang
        audacious
        helix
        kakoune
        guile
        awscli2
        coq
        ocaml
        hugo
        inkscape
        librsvg
        sshfs
        filezilla
        superhtml
        python312Packages.debugpy
        gdb
        tmux
        tutanota-desktop
        typescript
        bitwarden
        jetbrains.rust-rover
        imv
        cargo-generate
        pcmanfm
        ldtk
        jetbrains.clion
        jetbrains.rider
        fselect
        mask
        rusty-man
        evince
        editorconfig-core-c
        imagemagick
        bc
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
        ".local/bin/nix-config.sh" = {
            executable = true;
            text = ''
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
        };
        ".config/bat/themes/Catppuccin Latte.tmTheme".text = ''
                <?xml version="1.0" encoding="UTF-8"?>
                <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
                <plist version="1.0">
                  <dict>
                    <key>name</key>
                    <string>Catppuccin Latte</string>
                    <key>semanticClass</key>
                    <string>theme.light.catppuccin-latte</string>
                    <key>uuid</key>
                    <string>96a262cd-4b2f-49f5-9125-8dd0077cbfe1</string>
                    <key>author</key>
                    <string>Catppuccin Org</string>
                    <key>colorSpaceName</key>
                    <string>sRGB</string>
                    <key>settings</key>
                    <array>
                      <dict>
                        <key>settings</key>
                        <dict>
                          <key>background</key>
                          <string>#eff1f5</string>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                          <key>caret</key>
                          <string>#dc8a78</string>
                          <key>lineHighlight</key>
                          <string>#ccd0da</string>
                          <key>misspelling</key>
                          <string>#d20f39</string>
                          <key>accent</key>
                          <string>#8839ef</string>
                          <key>selection</key>
                          <string>#7c7f934d</string>
                          <key>activeGuide</key>
                          <string>#bcc0cc</string>
                          <key>findHighlight</key>
                          <string>#a9daf0</string>
                          <key>gutterForeground</key>
                          <string>#8c8fa1</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Basic text &amp; variable names (incl. leading punctuation)</string>
                        <key>scope</key>
                        <string>text, source, variable.other.readwrite, punctuation.definition.variable</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Parentheses, Brackets, Braces</string>
                        <key>scope</key>
                        <string>punctuation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7c7f93</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Comments</string>
                        <key>scope</key>
                        <string>comment, punctuation.definition.comment</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#9ca0b0</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>string, punctuation.definition.string</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>constant.character.escape</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Booleans, constants, numbers</string>
                        <key>scope</key>
                        <string>constant.numeric, variable.other.constant, entity.name.constant, constant.language.boolean, constant.language.false, constant.language.true, keyword.other.unit.user-defined, keyword.other.unit.suffix.floating-point</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>keyword, keyword.operator.word, keyword.operator.new, variable.language.super, support.type.primitive, storage.type, storage.modifier, punctuation.definition.keyword</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>entity.name.tag.documentation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Punctuation</string>
                        <key>scope</key>
                        <string>keyword.operator, punctuation.accessor, punctuation.definition.generic, meta.function.closure punctuation.section.parameters, punctuation.definition.tag, punctuation.separator.key-value</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>entity.name.function, meta.function-call.method, support.function, support.function.misc, variable.function</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Classes</string>
                        <key>scope</key>
                        <string>entity.name.class, entity.other.inherited-class, support.class, meta.function-call.constructor, entity.name.struct</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Enum</string>
                        <key>scope</key>
                        <string>entity.name.enum</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Enum member</string>
                        <key>scope</key>
                        <string>meta.enum variable.other.readwrite, variable.other.enummember</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Object properties</string>
                        <key>scope</key>
                        <string>meta.property.object</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Types</string>
                        <key>scope</key>
                        <string>meta.type, meta.type-alias, support.type, entity.name.type</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Decorators</string>
                        <key>scope</key>
                        <string>meta.annotation variable.function, meta.annotation variable.annotation.function, meta.annotation punctuation.definition.annotation, meta.decorator, punctuation.decorator</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>variable.parameter, meta.function.parameters</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Built-ins</string>
                        <key>scope</key>
                        <string>constant.language, support.function.builtin</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>entity.other.attribute-name.documentation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Preprocessor directives</string>
                        <key>scope</key>
                        <string>keyword.control.directive, punctuation.definition.directive</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Type parameters</string>
                        <key>scope</key>
                        <string>punctuation.definition.typeparameters</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Namespaces</string>
                        <key>scope</key>
                        <string>entity.name.namespace</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Property names (left hand assignments in json/yaml/css)</string>
                        <key>scope</key>
                        <string>support.type.property-name.css</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>This/Self keyword</string>
                        <key>scope</key>
                        <string>variable.language.this, variable.language.this punctuation.definition.variable</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Object properties</string>
                        <key>scope</key>
                        <string>variable.object.property</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>String template interpolation</string>
                        <key>scope</key>
                        <string>string.template variable, string variable</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>`new` as bold</string>
                        <key>scope</key>
                        <string>keyword.operator.new</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string>bold</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C++ extern keyword</string>
                        <key>scope</key>
                        <string>storage.modifier.specifier.extern.cpp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C++ scope resolution</string>
                        <key>scope</key>
                        <string>entity.name.scope-resolution.template.call.cpp, entity.name.scope-resolution.parameter.cpp, entity.name.scope-resolution.cpp, entity.name.scope-resolution.function.definition.cpp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C++ doc keywords</string>
                        <key>scope</key>
                        <string>storage.type.class.doxygen</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C++ operators</string>
                        <key>scope</key>
                        <string>storage.modifier.reference.cpp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C# Interpolated Strings</string>
                        <key>scope</key>
                        <string>meta.interpolation.cs</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>C# xml-style docs</string>
                        <key>scope</key>
                        <string>comment.block.documentation.cs</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Classes, reflecting the className color in JSX</string>
                        <key>scope</key>
                        <string>source.css entity.other.attribute-name.class.css, entity.other.attribute-name.parent-selector.css punctuation.definition.entity.css</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Operators</string>
                        <key>scope</key>
                        <string>punctuation.separator.operator.css</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Pseudo classes</string>
                        <key>scope</key>
                        <string>source.css entity.other.attribute-name.pseudo-class</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>source.css constant.other.unicode-range</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>source.css variable.parameter.url</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>CSS vendored property names</string>
                        <key>scope</key>
                        <string>support.type.vendored.property-name</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Less/SCSS right-hand variables (@/$-prefixed)</string>
                        <key>scope</key>
                        <string>source.css meta.property-value variable, source.css meta.property-value variable.other.less, source.css meta.property-value variable.other.less punctuation.definition.variable.less, meta.definition.variable.scss</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>CSS variables (--prefixed)</string>
                        <key>scope</key>
                        <string>source.css meta.property-list variable, meta.property-list variable.other.less, meta.property-list variable.other.less punctuation.definition.variable.less</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>CSS Percentage values, styled the same as numbers</string>
                        <key>scope</key>
                        <string>keyword.other.unit.percentage.css</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>CSS Attribute selectors, styled the same as strings</string>
                        <key>scope</key>
                        <string>source.css meta.attribute-selector</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSON/YAML keys, other left-hand assignments</string>
                        <key>scope</key>
                        <string>keyword.other.definition.ini, punctuation.support.type.property-name.json, support.type.property-name.json, punctuation.support.type.property-name.toml, support.type.property-name.toml, entity.name.tag.yaml, punctuation.support.type.property-name.yaml, support.type.property-name.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSON/YAML constants</string>
                        <key>scope</key>
                        <string>constant.language.json, constant.language.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>YAML anchors</string>
                        <key>scope</key>
                        <string>entity.name.type.anchor.yaml, variable.other.alias.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>TOML tables / ini groups</string>
                        <key>scope</key>
                        <string>support.type.property-name.table, entity.name.section.group-title.ini</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>TOML dates</string>
                        <key>scope</key>
                        <string>constant.other.time.datetime.offset.toml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>YAML anchor puctuation</string>
                        <key>scope</key>
                        <string>punctuation.definition.anchor.yaml, punctuation.definition.alias.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>YAML triple dashes</string>
                        <key>scope</key>
                        <string>entity.other.document.begin.yaml</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markup Diff</string>
                        <key>scope</key>
                        <string>markup.changed.diff</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Diff</string>
                        <key>scope</key>
                        <string>meta.diff.header.from-file, meta.diff.header.to-file, punctuation.definition.from-file.diff, punctuation.definition.to-file.diff</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Diff Inserted</string>
                        <key>scope</key>
                        <string>markup.inserted.diff</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Diff Deleted</string>
                        <key>scope</key>
                        <string>markup.deleted.diff</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>dotenv left-hand side assignments</string>
                        <key>scope</key>
                        <string>variable.other.env</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>dotenv reference to existing env variable</string>
                        <key>scope</key>
                        <string>string.quoted variable.other.env</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GDScript functions</string>
                        <key>scope</key>
                        <string>support.function.builtin.gdscript</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GDScript constants</string>
                        <key>scope</key>
                        <string>constant.language.gdscript</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Comment keywords</string>
                        <key>scope</key>
                        <string>comment meta.annotation.go</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>go:embed, go:build, etc.</string>
                        <key>scope</key>
                        <string>comment meta.annotation.parameters.go</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Go constants (nil, true, false)</string>
                        <key>scope</key>
                        <string>constant.language.go</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GraphQL variables</string>
                        <key>scope</key>
                        <string>variable.graphql</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GraphQL aliases</string>
                        <key>scope</key>
                        <string>string.unquoted.alias.graphql</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#dd7878</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GraphQL enum members</string>
                        <key>scope</key>
                        <string>constant.character.enum.graphql</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>GraphQL field in types</string>
                        <key>scope</key>
                        <string>meta.objectvalues.graphql constant.object.key.graphql string.unquoted.graphql</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#dd7878</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>HTML/XML DOCTYPE as keyword</string>
                        <key>scope</key>
                        <string>keyword.other.doctype, meta.tag.sgml.doctype punctuation.definition.tag, meta.tag.metadata.doctype entity.name.tag, meta.tag.metadata.doctype punctuation.definition.tag</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>HTML/XML-like &lt;tags/&gt;</string>
                        <key>scope</key>
                        <string>entity.name.tag</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Special characters like &amp;amp;</string>
                        <key>scope</key>
                        <string>text.html constant.character.entity, text.html constant.character.entity punctuation, constant.character.entity.xml, constant.character.entity.xml punctuation, constant.character.entity.js.jsx, constant.charactger.entity.js.jsx punctuation, constant.character.entity.tsx, constant.character.entity.tsx punctuation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>HTML/XML tag attribute values</string>
                        <key>scope</key>
                        <string>entity.other.attribute-name</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Components</string>
                        <key>scope</key>
                        <string>support.class.component, support.class.component.jsx, support.class.component.tsx, support.class.component.vue</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Annotations</string>
                        <key>scope</key>
                        <string>punctuation.definition.annotation, storage.type.annotation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Java enums</string>
                        <key>scope</key>
                        <string>constant.other.enum.java</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Java imports</string>
                        <key>scope</key>
                        <string>storage.modifier.import.java</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Javadoc</string>
                        <key>scope</key>
                        <string>comment.block.javadoc.java keyword.other.documentation.javadoc.java</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Exported Variable</string>
                        <key>scope</key>
                        <string>meta.export variable.other.readwrite.js</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JS/TS constants &amp; properties</string>
                        <key>scope</key>
                        <string>variable.other.constant.js, variable.other.constant.ts, variable.other.property.js, variable.other.property.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSDoc; these are mainly params, so styled as such</string>
                        <key>scope</key>
                        <string>variable.other.jsdoc, comment.block.documentation variable.other</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSDoc keywords</string>
                        <key>scope</key>
                        <string>storage.type.class.jsdoc</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>support.type.object.console.js</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Node constants as keywords (module, etc.)</string>
                        <key>scope</key>
                        <string>support.constant.node, support.type.object.module.js</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>implements as keyword</string>
                        <key>scope</key>
                        <string>storage.modifier.implements</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Builtin types</string>
                        <key>scope</key>
                        <string>constant.language.null.js, constant.language.null.ts, constant.language.undefined.js, constant.language.undefined.ts, support.type.builtin.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>variable.parameter.generic</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Arrow functions</string>
                        <key>scope</key>
                        <string>keyword.declaration.function.arrow.js, storage.type.function.arrow.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Decorator punctuations (decorators inherit from blue functions, instead of styleguide peach)</string>
                        <key>scope</key>
                        <string>punctuation.decorator.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Extra JS/TS keywords</string>
                        <key>scope</key>
                        <string>keyword.operator.expression.in.js, keyword.operator.expression.in.ts, keyword.operator.expression.infer.ts, keyword.operator.expression.instanceof.js, keyword.operator.expression.instanceof.ts, keyword.operator.expression.is, keyword.operator.expression.keyof.ts, keyword.operator.expression.of.js, keyword.operator.expression.of.ts, keyword.operator.expression.typeof.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Julia macros</string>
                        <key>scope</key>
                        <string>support.function.macro.julia</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Julia language constants (true, false)</string>
                        <key>scope</key>
                        <string>constant.language.julia</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Julia other constants (these seem to be arguments inside arrays)</string>
                        <key>scope</key>
                        <string>constant.other.symbol.julia</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>LaTeX preamble</string>
                        <key>scope</key>
                        <string>text.tex keyword.control.preamble</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>LaTeX be functions</string>
                        <key>scope</key>
                        <string>text.tex support.function.be</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>LaTeX math</string>
                        <key>scope</key>
                        <string>constant.other.general.math.tex</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#dd7878</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Lua docstring keywords</string>
                        <key>scope</key>
                        <string>comment.line.double-dash.documentation.lua storage.type.annotation.lua</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Lua docstring variables</string>
                        <key>scope</key>
                        <string>comment.line.double-dash.documentation.lua entity.name.variable.lua, comment.line.double-dash.documentation.lua variable.lua</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.1.markdown punctuation.definition.heading.markdown, heading.1.markdown, markup.heading.atx.1.mdx, markup.heading.atx.1.mdx punctuation.definition.heading.mdx, markup.heading.setext.1.markdown, markup.heading.heading-0.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.2.markdown punctuation.definition.heading.markdown, heading.2.markdown, markup.heading.atx.2.mdx, markup.heading.atx.2.mdx punctuation.definition.heading.mdx, markup.heading.setext.2.markdown, markup.heading.heading-1.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.3.markdown punctuation.definition.heading.markdown, heading.3.markdown, markup.heading.atx.3.mdx, markup.heading.atx.3.mdx punctuation.definition.heading.mdx, markup.heading.heading-2.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.4.markdown punctuation.definition.heading.markdown, heading.4.markdown, markup.heading.atx.4.mdx, markup.heading.atx.4.mdx punctuation.definition.heading.mdx, markup.heading.heading-3.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.5.markdown punctuation.definition.heading.markdown, heading.5.markdown, markup.heading.atx.5.mdx, markup.heading.atx.5.mdx punctuation.definition.heading.mdx, markup.heading.heading-4.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>heading.6.markdown punctuation.definition.heading.markdown, heading.6.markdown, markup.heading.atx.6.mdx, markup.heading.atx.6.mdx punctuation.definition.heading.mdx, markup.heading.heading-5.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.bold</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                          <key>fontStyle</key>
                          <string>bold</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.italic</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.strikethrough</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#6c6f85</string>
                          <key>fontStyle</key>
                          <string>strikethrough</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown auto links</string>
                        <key>scope</key>
                        <string>punctuation.definition.link, markup.underline.link</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown links</string>
                        <key>scope</key>
                        <string>text.html.markdown punctuation.definition.link.title, string.other.link.title.markdown, markup.link, punctuation.definition.constant.markdown, constant.other.reference.link.markdown, markup.substitution.attribute-reference</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7287fd</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown code spans</string>
                        <key>scope</key>
                        <string>punctuation.definition.raw.markdown, markup.inline.raw.string.markdown, markup.raw.block.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown triple backtick language identifier</string>
                        <key>scope</key>
                        <string>fenced_code.block.language</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown triple backticks</string>
                        <key>scope</key>
                        <string>markup.fenced_code.block punctuation.definition, markup.raw support.asciidoc</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7c7f93</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown quotes</string>
                        <key>scope</key>
                        <string>markup.quote, punctuation.definition.quote.begin</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown separators</string>
                        <key>scope</key>
                        <string>meta.separator.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Markdown list bullets</string>
                        <key>scope</key>
                        <string>punctuation.definition.list.begin.markdown, markup.list.bullet</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Nix attribute names</string>
                        <key>scope</key>
                        <string>entity.other.attribute-name.multipart.nix, entity.other.attribute-name.single.nix</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Nix parameter names</string>
                        <key>scope</key>
                        <string>variable.parameter.name.nix</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Nix interpolated parameter names</string>
                        <key>scope</key>
                        <string>meta.embedded variable.parameter.name.nix</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7287fd</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Nix paths</string>
                        <key>scope</key>
                        <string>string.unquoted.path.nix</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHP Attributes</string>
                        <key>scope</key>
                        <string>support.attribute.builtin, meta.attribute.php</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHP Parameters (needed for the leading dollar sign)</string>
                        <key>scope</key>
                        <string>meta.function.parameters.php punctuation.definition.variable.php</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHP Constants (null, __FILE__, etc.)</string>
                        <key>scope</key>
                        <string>constant.language.php</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHP functions</string>
                        <key>scope</key>
                        <string>text.html.php support.function</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>PHPdoc keywords</string>
                        <key>scope</key>
                        <string>keyword.other.phpdoc.php</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python argument functions reset to text, otherwise they inherit blue from function-call</string>
                        <key>scope</key>
                        <string>support.variable.magic.python, meta.function-call.arguments.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python double underscore functions</string>
                        <key>scope</key>
                        <string>support.function.magic.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python `self` keyword</string>
                        <key>scope</key>
                        <string>variable.parameter.function.language.special.self.python, variable.language.special.self.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python keyword flow/logical (for ... in)</string>
                        <key>scope</key>
                        <string>keyword.control.flow.python, keyword.operator.logical.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python storage type</string>
                        <key>scope</key>
                        <string>storage.type.function.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python function support</string>
                        <key>scope</key>
                        <string>support.token.decorator.python, meta.function.decorator.identifier.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python function calls</string>
                        <key>scope</key>
                        <string>meta.function-call.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python function decorators</string>
                        <key>scope</key>
                        <string>entity.name.function.decorator.python, punctuation.definition.decorator.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python placeholder reset to normal string</string>
                        <key>scope</key>
                        <string>constant.character.format.placeholder.other.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python exception &amp; builtins such as exit()</string>
                        <key>scope</key>
                        <string>support.type.exception.python, support.function.builtin.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>entity.name.type</string>
                        <key>scope</key>
                        <string>support.type.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>python constants (True/False)</string>
                        <key>scope</key>
                        <string>constant.language.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Arguments accessed later in the function body</string>
                        <key>scope</key>
                        <string>meta.indexed-name.python, meta.item-access.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python f-strings/binary/unicode storage types</string>
                        <key>scope</key>
                        <string>storage.type.string.python</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Python type hints</string>
                        <key>scope</key>
                        <string>meta.function.parameters.python</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex string begin/end in JS/TS</string>
                        <key>scope</key>
                        <string>string.regexp punctuation.definition.string.begin, string.regexp punctuation.definition.string.end</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex anchors (^, $)</string>
                        <key>scope</key>
                        <string>keyword.control.anchor.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex regular string match</string>
                        <key>scope</key>
                        <string>string.regexp.ts</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex group parenthesis &amp; backreference (\1, \2, \3, ...)</string>
                        <key>scope</key>
                        <string>punctuation.definition.group.regexp, keyword.other.back-reference.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#40a02b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex character class []</string>
                        <key>scope</key>
                        <string>punctuation.definition.character-class.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex character classes (\d, \w, \s)</string>
                        <key>scope</key>
                        <string>constant.other.character-class.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex range</string>
                        <key>scope</key>
                        <string>constant.other.character-class.range.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#dc8a78</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex quantifier</string>
                        <key>scope</key>
                        <string>keyword.operator.quantifier.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex constant/numeric</string>
                        <key>scope</key>
                        <string>constant.character.numeric.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Regex lookaheads, negative lookaheads, lookbehinds, negative lookbehinds</string>
                        <key>scope</key>
                        <string>punctuation.definition.group.no-capture.regexp, meta.assertion.look-ahead.regexp, meta.assertion.negative-look-ahead.regexp</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust attribute</string>
                        <key>scope</key>
                        <string>meta.annotation.rust, meta.annotation.rust punctuation, meta.attribute.rust, punctuation.definition.attribute.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust attribute strings</string>
                        <key>scope</key>
                        <string>meta.attribute.rust string.quoted.double.rust, meta.attribute.rust string.quoted.single.char.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust keyword</string>
                        <key>scope</key>
                        <string>entity.name.function.macro.rules.rust, storage.type.module.rust, storage.modifier.rust, storage.type.struct.rust, storage.type.enum.rust, storage.type.trait.rust, storage.type.union.rust, storage.type.impl.rust, storage.type.rust, storage.type.function.rust, storage.type.type.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust u/i32, u/i64, etc.</string>
                        <key>scope</key>
                        <string>entity.name.type.numeric.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                          <key>fontStyle</key>
                          <string/>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust generic</string>
                        <key>scope</key>
                        <string>meta.generic.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust impl</string>
                        <key>scope</key>
                        <string>entity.name.impl.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust module</string>
                        <key>scope</key>
                        <string>entity.name.module.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust trait</string>
                        <key>scope</key>
                        <string>entity.name.trait.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust struct</string>
                        <key>scope</key>
                        <string>storage.type.source.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust union</string>
                        <key>scope</key>
                        <string>entity.name.union.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust enum member</string>
                        <key>scope</key>
                        <string>meta.enum.rust storage.type.source.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust macro</string>
                        <key>scope</key>
                        <string>support.macro.rust, meta.macro.rust support.function.rust, entity.name.function.macro.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust lifetime</string>
                        <key>scope</key>
                        <string>storage.modifier.lifetime.rust, entity.name.type.lifetime</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust string formatting</string>
                        <key>scope</key>
                        <string>string.quoted.double.rust constant.other.placeholder.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust return type generic</string>
                        <key>scope</key>
                        <string>meta.function.return-type.rust meta.generic.rust storage.type.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust functions</string>
                        <key>scope</key>
                        <string>meta.function.call.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust angle brackets</string>
                        <key>scope</key>
                        <string>punctuation.brackets.angle.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#04a5e5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust constants</string>
                        <key>scope</key>
                        <string>constant.other.caps.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust function parameters</string>
                        <key>scope</key>
                        <string>meta.function.definition.rust variable.other.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#e64553</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust closure variables</string>
                        <key>scope</key>
                        <string>meta.function.call.rust variable.other.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust self</string>
                        <key>scope</key>
                        <string>variable.language.self.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Rust metavariable names</string>
                        <key>scope</key>
                        <string>variable.other.metavariable.name.rust, meta.macro.metavariable.rust keyword.operator.macro.dollar.rust</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell shebang</string>
                        <key>scope</key>
                        <string>comment.line.shebang, comment.line.shebang punctuation.definition.comment, comment.line.shebang, punctuation.definition.comment.shebang.shell, meta.shebang.shell</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell shebang command</string>
                        <key>scope</key>
                        <string>comment.line.shebang constant.language</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell interpolated command</string>
                        <key>scope</key>
                        <string>meta.function-call.arguments.shell punctuation.definition.variable.shell, meta.function-call.arguments.shell punctuation.section.interpolation, meta.function-call.arguments.shell punctuation.definition.variable.shell, meta.function-call.arguments.shell punctuation.section.interpolation</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell interpolated command variable</string>
                        <key>scope</key>
                        <string>meta.string meta.interpolation.parameter.shell variable.other.readwrite</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                          <key>fontStyle</key>
                          <string>italic</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>source.shell punctuation.section.interpolation, punctuation.definition.evaluation.backticks.shell</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell EOF</string>
                        <key>scope</key>
                        <string>entity.name.tag.heredoc.shell</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Shell quoted variable</string>
                        <key>scope</key>
                        <string>string.quoted.double.shell variable.other.normal.shell</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#4c4f69</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSON Keys</string>
                        <key>scope</key>
                        <string>source.json meta.mapping.key string</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>JSON key surrounding quotes</string>
                        <key>scope</key>
                        <string>source.json meta.mapping.key punctuation.definition.string.begin, source.json meta.mapping.key punctuation.definition.string.end</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#7c7f93</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.synopsis.man, markup.heading.title.man, markup.heading.other.man, markup.heading.env.man</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#8839ef</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.commands.man</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#1e66f5</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.env.man</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#ea76cb</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>name</key>
                        <string>Man page options</string>
                        <key>scope</key>
                        <string>entity.name</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#179299</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.1.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#d20f39</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.2.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#fe640b</string>
                        </dict>
                      </dict>
                      <dict>
                        <key>scope</key>
                        <string>markup.heading.markdown</string>
                        <key>settings</key>
                        <dict>
                          <key>foreground</key>
                          <string>#df8e1d</string>
                        </dict>
                      </dict>
                    </array>
                  </dict>
                </plist>
        '';

        ".config/btop/themes/catppuccin_latte.theme".text = ''
            # Main background, empty for terminal default, need to be empty if you want transparent background
            theme[main_bg]="#eff1f5"

            # Main text color
            theme[main_fg]="#4c4f69"

            # Title color for boxes
            theme[title]="#4c4f69"

            # Highlight color for keyboard shortcuts
            theme[hi_fg]="#1e66f5"

            # Background color of selected item in processes box
            theme[selected_bg]="#bcc0cc"

            # Foreground color of selected item in processes box
            theme[selected_fg]="#1e66f5"

            # Color of inactive/disabled text
            theme[inactive_fg]="#8c8fa1"

            # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
            theme[graph_text]="#dc8a78"

            # Background color of the percentage meters
            theme[meter_bg]="#bcc0cc"

            # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
            theme[proc_misc]="#dc8a78"

            # CPU, Memory, Network, Proc box outline colors
            theme[cpu_box]="#8839ef" #Mauve
            theme[mem_box]="#40a02b" #Green
            theme[net_box]="#e64553" #Maroon
            theme[proc_box]="#1e66f5" #Blue

            # Box divider line and small boxes line color
            theme[div_line]="#9ca0b0"

            # Temperature graph color (Green -> Yellow -> Red)
            theme[temp_start]="#40a02b"
            theme[temp_mid]="#df8e1d"
            theme[temp_end]="#d20f39"

            # CPU graph colors (Teal -> Lavender)
            theme[cpu_start]="#179299"
            theme[cpu_mid]="#209fb5"
            theme[cpu_end]="#7287fd"

            # Mem/Disk free meter (Mauve -> Lavender -> Blue)
            theme[free_start]="#8839ef"
            theme[free_mid]="#7287fd"
            theme[free_end]="#1e66f5"

            # Mem/Disk cached meter (Sapphire -> Lavender)
            theme[cached_start]="#209fb5"
            theme[cached_mid]="#1e66f5"
            theme[cached_end]="#7287fd"

            # Mem/Disk available meter (Peach -> Red)
            theme[available_start]="#fe640b"
            theme[available_mid]="#e64553"
            theme[available_end]="#d20f39"

            # Mem/Disk used meter (Green -> Sky)
            theme[used_start]="#40a02b"
            theme[used_mid]="#179299"
            theme[used_end]="#04a5e5"

            # Download graph colors (Peach -> Red)
            theme[download_start]="#fe640b"
            theme[download_mid]="#e64553"
            theme[download_end]="#d20f39"

            # Upload graph colors (Green -> Sky)
            theme[upload_start]="#40a02b"
            theme[upload_mid]="#179299"
            theme[upload_end]="#04a5e5"

            # Process box color gradient for threads, mem and cpu usage (Sapphire -> Mauve)
            theme[process_start]="#209fb5"
            theme[process_mid]="#7287fd"
            theme[process_end]="#8839ef"
        '';

        ".config/btop/config".text = ''
        --theme="Catppuccin Latte"
        '';
        
        ".editorconfig".text = ''
root = true

[*]
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 4

[*.yml]
indent_size = 2

[Makefile]
indent_style = tab

[makefile]
indent_style = tab
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
            #PROMPT = "❬%F{13}%n%f❭ %f%F{13}図書館に%f %F{12}%d\n%f ";
        };

        sessionVariables = {
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
        '';

    };

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

    services.emacs = {
        enable = true;
        package = pkgs.emacs;
    };

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

    programs.home-manager.enable = true;
}

