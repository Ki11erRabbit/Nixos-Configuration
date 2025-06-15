{
    description = "My NixOS shared Config";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        unstable-pkgs.url = "nixpkgs/nixos-unstable";
        old-pkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            # The `follows` keyword in inputs is used for inheritance.
            # Here, `inputs.nixpkgs` of home-manager is kept consistent with
            # the `inputs.nixpkgs` of the current flake,
            # to avoid problems caused by different versions of nixpkgs.
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixos-cosmic = {
            url = "github:lilyinstarlight/nixos-cosmic";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
            # to have it up to date or simply don't specify the nixpkgs input  
            #inputs.nixpkgs.follows = "nixpkgs";
        };
        quickshell = {
            # remove ?ref=v0.1.0 to track the master branch
            url = "github:quickshell-mirror/quickshell?ref=v0.1.0";

            # THIS IS IMPORTANT
            # Mismatched system dependencies will lead to crashes and other issues.
            inputs.nixpkgs.follows = "unstable-pkgs";
        };
    };
    outputs = inputs@{ self, nixpkgs, home-manager, unstable-pkgs, old-pkgs, nixos-cosmic, zen-browser, quickshell,... }: 
    let 
        system = "x86_64-linux";
        pkgs = import nixpkgs { 
            system = "${system}"; 
            config = { allowUnfree = true; nvidia.acceptLicense = true; }; 
            overlays = [
                (final: prev: {
                    # example = prev.example.overrideAttrs (oldAttrs: rec {
                    # ...
                    # });
                    catppuccin-qt5ct = prev.catppuccin-qt5ct.overrideAttrs (oldAttrs: rec {
                        version = "2025-06-14";
                        src = prev.fetchFromGitHub {
                            owner = "catppuccin";
                            repo = "qt5ct";
                            rev = "cb585307edebccf74b8ae8f66ea14f21e6666535";
                            hash = "sha256-wDj6kQ2LQyMuEvTQP6NifYFdsDLT+fMCe3Fxr8S783w=";
                        };
                        installPhase = ''
                            runHook preInstall
                            mkdir -p $out/share/qt6ct
                            cp -r themes $out/share/qt6ct/colors
                            runHook postInstall
                        '';
                    });
                })
            ];
        };
        unstable = import unstable-pkgs { system = "${system}"; config = { allowUnfree = true; }; };
        oldpkgs = import old-pkgs { system = "${system}"; config = { allowUnfree = true; }; };
        quickshellPkgs = import quickshell { 
            pkgs = unstable-pkgs; 
            lib = unstable-pkgs.lib; 
            xorg = unstable-pkgs.xorg; 
            keepDebugInfo = true;
            breakpad = unstable-pkgs.breakpad;
            cmake = unstable-pkgs.cmake;
            ninja = unstable-pkgs.ninja;
            spirv-tools = unstable-pkgs.spirv-tools;
            qt6 = unstable-pkgs.qt6;
            jemalloc = unstable-pkgs.jemalloc;
            cli11 = unstable-pkgs.cli11;
            wayland = unstable-pkgs.wayland;
            wayland-protocols = unstable-pkgs.wayland-protocols;
            libdrm = unstable-pkgs.libdrm;
            libgbm = unstable-pkgs.libgbm;
            pipewire = unstable-pkgs.pipewire;
            pam = unstable-pkgs.pam;
            nix-gitignore = unstable-pkgs.nix-gitignore;
        };
    in {
        packages = import ./pkgs nixpkgs.legacyPackages.${system};
        overlays = import ./overlays {inherit inputs;};
        home-mangager.users.root = import ./root/home.nix;
        nixosConfigurations = {
            primary-desktop = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit pkgs;
                };
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common-pc.nix
                    ./hosts/desktop/configuration.nix
                    ./hardware/primary-desktop.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.root = import ./root/home.nix;
                    }
                ];
            };
            server-nas = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit pkgs;
                };
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common-server.nix
                    ./hosts/server-nas/configuration.nix
                    ./hardware/server-nas.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.root = import ./root/home.nix;
                    }
                ];
            };
            think-nix-t440p =  nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit pkgs;
                };
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common-pc.nix
                    ./hosts/think-nix-t440p/configuration.nix
                    ./hosts/laptop/configuration.nix
                    ./hardware/t440p.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.root = import ./root/home.nix;
                    }
                ];
            };
            think-nix-x230t = nixpkgs.lib.nixosSystem  {
                specialArgs = {
                    inherit pkgs;
                };
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common-pc.nix
                    ./hosts/think-nix-x230t/configuration.nix
                    ./hosts/laptop/configuration.nix
                    ./hardware/x230t.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.root = import ./root/home.nix;
                    }
                ];
            };
            think-nix-t430s = nixpkgs.lib.nixosSystem  {
                specialArgs = {
                    inherit pkgs;
                };
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common-pc.nix
                    ./hosts/think-nix-t430s/configuration.nix
                    ./hosts/laptop/configuration.nix
                    ./hardware/t430s.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.root = import ./root/home.nix;
                    }
                ];
            };
            think-nix-t480s = nixpkgs.lib.nixosSystem  {
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common-pc.nix
                    ./hosts/think-nix-t480s/configuration.nix
                    ./hosts/laptop/configuration.nix
                    ./hardware/t480s.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.root = import ./root/home.nix;
                    }
                    {
                        nix.settings = {
                            substituters = [ "https://cosmic.cachix.org/" ];
                            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                        };
                    }
                    nixos-cosmic.nixosModules.default
                ];
            };
            think-nix-t480 = nixpkgs.lib.nixosSystem  {
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common-pc.nix
                    ./hosts/think-nix-t480/configuration.nix
                    ./hosts/laptop/configuration.nix
                    ./hardware/t480.nix
                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.root = import ./root/home.nix;
                    }
                    {
                        nix.settings = {
                            substituters = [ "https://cosmic.cachix.org/" ];
                            trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                        };
                    }
                    nixos-cosmic.nixosModules.default
                ];
            };
        };
        homeConfigurations = {
            "desktop" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs quickshellPkgs inputs; };
                modules = [
                    ./home/shared-home.nix
                    ./home/desktop-home.nix
                    ./home/unstable-home.nix
                    ./home/old-home.nix
                ];
            };
            "servernas" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs; };
                modules = [
                    ./home/shared-home.nix
                    ./home/server-nas-home.nix
                ];
            };
            "t440p" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs;};
                modules = [
                    ./home/shared-home.nix
                    ./home/laptop-home.nix
                    ./home/unstable-home.nix
                    ./home/t440p-home.nix
                    ./home/old-home.nix
                ];
            };
            "x230t" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs;};
                modules = [
                    ./home/shared-home.nix
                    ./home/laptop-home.nix
                    ./home/unstable-home.nix
                    ./home/x230t-home.nix
                    ./home/old-home.nix
                ];
            };
            "t430s" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs;};
                modules = [
                    ./home/shared-home.nix
                    ./home/laptop-home.nix
                    ./home/unstable-home.nix
                    ./home/t430s-home.nix
                    ./home/old-home.nix
                ];
            };
            "t480s" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs;};
                modules = [
                    ./home/shared-home.nix
                    ./home/laptop-home.nix
                    ./home/unstable-home.nix
                    ./home/t480s-home.nix
                    ./home/old-home.nix
                ];
            };
            "t480" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs;};
                modules = [
                    ./home/shared-home.nix
                    ./home/laptop-home.nix
                    ./home/unstable-home.nix
                    ./home/t480-home.nix
                    ./home/old-home.nix
                ];
            };
        };
    };
    
}
