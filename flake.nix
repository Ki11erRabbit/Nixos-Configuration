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
    outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
    let 
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {

        nixosConfigurations = {
            nix-desktop = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit pkgs system home-manager;
                };
                modules = [
                    ./hosts/shared/common.nix
                    ./hosts/desktop/configuration.nix
                ];
                home-manager.users.root = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [
                        ./root-home/shared-home.nix
                    ];
                };
                            
            };
            think-nix-t440p = {
                specialArgs = {
                    inherit pkgs system home-manager;
                };
                modules = [
                    ./hosts/shared/common.nix
                    ./hosts/think-nix-t440p/configuration.nix
                    ./hosts/laptop/configuration.nix
                ];
            };
        };
        homeConfigurations = {
            "nix-desktop" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./home/shared-home.nix
                    ./home/desktop-home.nix
                ];
            };
            "think-nix-t440p" = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./home/shared-home.nix
                    ./home/laptop-home.nix
                ];
            };
        };
    };
    
}
