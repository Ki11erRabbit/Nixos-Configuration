{
    description = "My NixOS shared Config";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            # The `follows` keyword in inputs is used for inheritance.
            # Here, `inputs.nixpkgs` of home-manager is kept consistent with
            # the `inputs.nixpkgs` of the current flake,
            # to avoid problems caused by different versions of nixpkgs.
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = inputs@{ self, nixpkgs, home-manager, ... }: {

        nixosConfigurations = {
            nix-desktop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {inherit inputs;};
                modules = [
                    ./hosts/shared/common.nix
                    ./hosts/desktop/configuration.nix
                ];
            };
            think-nix-t440p = {
                system = "x86_64-linux";
                specialArgs = {inherit inputs;};
                modules = [
                    ./hosts/shared/common.nix
                    ./hosts/think-nix-t440p/configuration.nix
                    ./hosts/laptop/configuration.nix
                ];
            };
        };
        homeConfigurations = {
            "ki11errabbit@nix-desktop" = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./home-manager/shared-home.nix
                    ./home-manager/desktop-home.nix
                ];
            };
            "ki11errabbit@think-nix-t440p" = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./home-manager/shared-home.nix
                    ./home-manager/laptop-home.nix
                ];
            };
        };
    };
    
}
