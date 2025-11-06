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
        mango = {
            url = "github:DreamMaoMao/mango";
            inputs.nixpkgs.follows = "unstable-pkgs";
        };
        lem = {
            url = "github:Ki11erRabbit/lem/2ef9ad7";
            inputs.nixpkgs.follows = "unstable-pkgs";
        };
    };
    outputs = inputs@{ self, nixpkgs, home-manager, unstable-pkgs, old-pkgs, nixos-cosmic, zen-browser, mango, lem, ... }: 
    let 
        system = "x86_64-linux";
        system_arm = "aarch64-linux";
        system_mac = "aarch64-darwin";
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
        unstable_arm = import unstable-pkgs { system = "${system_arm}"; config = { allowUnfree = true; }; };
        oldpkgs_arm = import old-pkgs { system = "${system_arm}"; config = { allowUnfree = true; }; };
    in {
        packages = import ./pkgs nixpkgs.legacyPackages.${system};
        overlays = import ./overlays {inherit inputs;};
        home-mangager.users.root = import ./root/home.nix;
        nixosConfigurations = {
            primary-desktop = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit pkgs unstable;
                };
                system = "x86_64-linux";
                modules = [
                    mango.nixosModules.mango
                    ./hosts/shared/common-pc.nix
                    ./hosts/desktop/configuration.nix
                    ./hosts/unstable/configuration.nix
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
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs lem; };
                modules = [
                    mango.hmModules.mango
                    ./home/universal-home.nix
                    ./home/linux-shared-home.nix
                    ./home/linux-home.nix
                    ./home/linux-x86-home.nix
                    ./home/desktop-home.nix
                    ./home/unstable-home.nix
                    ./home/old-home.nix
                ];
            };
            "fedorawork" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs; };
                modules = [
                    mango.hmModules.mango
                    ./home/universal-home.nix
                    ./home/linux-home.nix
                    ./home/linux-x86-home.nix
                    ./home/laptop-home.nix
                    ./home/unstable-home.nix
                    ./home/old-home.nix
                    ./home/fedora-home.nix
                ];
            };
            "mac-fedora" = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { 
                    system = "${system_arm}"; 
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
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs; };
                modules = [
                    mango.hmModules.mango
                    ./home/universal-home.nix
                    ./home/linux-shared-home.nix
                    ./home/linux-home.nix
                    ./home/linux-arm-home.nix
                    ./home/unstable-home.nix
                    ./home/old-home.nix
                    ./home/mac-fedora.nix
                ];
            };
            "macos" = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs { 
                    system = "${system_mac}"; 
                    config = { allowUnfree = true; nvidia.acceptLicense = true; }; 
                };
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs inputs; };
                modules = [
                    mango.hmModules.mango
                    ./home/universal-home.nix
                    ./home/macos-home.nix
                    ./home/unstable-home.nix
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
