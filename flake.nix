{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unbroken.url = "github:nixos/nixpkgs/64e75cd44acf";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixpkgs-unstable,
      nixpkgs-unbroken,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      overlay = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
        unbroken = import nixpkgs-unbroken {
          inherit system;
          config.allowUnfree = true;
        };
      };

    in
    # # This is a function that generates an attribute by calling a function you
    # # pass to it, with each system as an argument
    # forAllSystems = nixpkgs.lib.genAttrs systems;
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      #                   'nh os switch /path'
      nixosConfigurations = {
        amitofu = nixpkgs.lib.nixosSystem {
          modules = [
            (
              { ... }:
              {
                nixpkgs.overlays = [ overlay ];
              }
            )
            ./nixos/configuration.nix
            ./pkgs
            ./nix.nix
            nixos-hardware.nixosModules.framework-12th-gen-intel
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "mainusr@amitofu" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          modules = [
            (
              { ... }:
              {
                nixpkgs.overlays = [ overlay ];
              }
            )
            # > Our main home-manager configuration file <
            ./home/default.nix
          ];
        };
      };
    };
}
