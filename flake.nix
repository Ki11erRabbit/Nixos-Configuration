{
    description = "My NixOS shared Config";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        unstable-pkgs.url = "nixpkgs/nixos-unstable";
        old-pkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            # The `follows` keyword in inputs is used for inheritance.
            # Here, `inputs.nixpkgs` of home-manager is kept consistent with
            # the `inputs.nixpkgs` of the current flake,
            # to avoid problems caused by different versions of nixpkgs.
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = inputs@{ self, nixpkgs, home-manager, unstable-pkgs, old-pkgs, ... }: 
    let 
        system = "x86_64-linux";
        pkgs = import nixpkgs { system = "${system}"; config = { allowUnfree = true; nvidia.acceptLicense = true; }; };
        unstable = import unstable-pkgs { system = "${system}"; config = { allowUnfree = true; }; };
        oldpkgs = import old-pkgs { system = "${system}"; config = { allowUnfree = true; }; };
    in {

        #home-mangager.users.root = import ./root/home.nix;
        nixosConfigurations = {
            primary-desktop = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit pkgs;
                };
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common.nix
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
                    ./hosts/shared/common.nix
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
                    ./hosts/shared/common.nix
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
                    ./hosts/shared/common.nix
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
                    ./hosts/shared/common.nix
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
        };
        homeConfigurations = {
            "desktop" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs; };
                modules = [
                    ./home/shared-home.nix
                    ./home/desktop-home.nix
                    ./home/unstable-home.nix
                    ./home/old-home.nix
                ];
            };
            "servernas" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs; };
                modules = [
                    ./home/shared-home.nix
                    ./home/server-nas-home.nix
                ];
            };
            "t440p" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs;};
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
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs;};
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
                extraSpecialArgs = {inherit nixpkgs unstable oldpkgs;};
                modules = [
                    ./home/shared-home.nix
                    ./home/laptop-home.nix
                    ./home/unstable-home.nix
                    ./home/t430s-home.nix
                    ./home/old-home.nix
                ];
            };
        };
    };
    
}
