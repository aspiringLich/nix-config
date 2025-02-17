{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nixpkgs-unstable,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      # "aarch64-linux"
      # "i686-linux"
      "x86_64-linux"
      # "aarch64-darwin"
      # "x86_64-darwin"
    ];
    # # This is a function that generates an attribute by calling a function you
    # # pass to it, with each system as an argument
    # forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    #                   'nh os switch /path'
    nixosConfigurations = {
      amitofu = nixpkgs.lib.nixosSystem {
        specialArgs = {
            unstable = nixpkgs-unstable;
        };
        modules = [
          ./nixos/configuration.nix
          ./pkgs
          ./nix.nix
          nixos-hardware.nixosModules.framework-12th-gen-intel
        ];
      };
    };

    # # Standalone home-manager configuration entrypoint
    # # Available through 'home-manager --flake .#your-username@your-hostname'
    # homeConfigurations = {
    #   "mainusr@amitofu" = home-manager.lib.homeManagerConfiguration {
    #     pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
    #     extraSpecialArgs = {inherit inputs outputs;};
    #     modules = [
    #       # > Our main home-manager configuration file <
    #       ./home-manager/home.nix
    #     ];
    #   };
    # };
  };
}
