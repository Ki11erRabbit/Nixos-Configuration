{
    description = "My NixOS shared Config";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        unstable-pkgs.url = "nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            # The `follows` keyword in inputs is used for inheritance.
            # Here, `inputs.nixpkgs` of home-manager is kept consistent with
            # the `inputs.nixpkgs` of the current flake,
            # to avoid problems caused by different versions of nixpkgs.
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = inputs@{ self, nixpkgs, home-manager, unstable-pkgs, ... }: 
    let 
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        unstable = unstable-pkgs.legacyPackages.${system};
    in {

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
                ];
            };
            think-nix-t440p = {
                specialArgs = {
                    inherit pkgs;
                };
                system = "x86_64-linux";
                modules = [
                    ./hosts/shared/common.nix
                    ./hosts/think-nix-t440p/configuration.nix
                    ./hosts/laptop/configuration.nix
                    ./hardware/t440p.nix
                ];
            };
        };
        homeConfigurations = {
            "desktop" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable; };
                modules = [
                    ./home/shared-home.nix
                    ./home/desktop-home.nix
                    ./home/unstable-home.nix
                ];
            };
            "t440p" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit nixpkgs unstable;};
                modules = [
                    ./home/shared-home.nix
                    ./home/laptop-home.nix
                    ./home/unstable-home.nix
                ];
            };
        };
    };
    
}
