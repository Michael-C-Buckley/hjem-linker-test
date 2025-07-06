{
  description = "Hjem Linker Testing";

  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem = {
      url = "git+https://github.com/Michael-C-Buckley/hjem?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    microvm,
    ...
  } @ inputs: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forAllSystems = nixpkgs.lib.genAttrs systems;
    importPkgs = system:
      import nixpkgs {
        inherit system;
        config = {allowUnfree = true;};
      };

    system = "x86_64-linux"; # I am testing from an X86 systems

    mkVM = modules:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs microvm;};
        inherit system;
        modules =
          [
            microvm.nixosModules.microvm
            ./config/microvm
            ./config/nixos
          ]
          ++ modules;
      };
  in {
    devShells = forAllSystems (system: let
      pkgs = importPkgs system;
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          microvm.packages.${system}.microvm
          alejandra
        ];
      };
    });

    packages = forAllSystems (system: {
      default = self.nixosConfigurations.hjem.config.microvm.declaredRunner;
    });

    nixosConfigurations = {
      hjem = mkVM [];
    };
  };
}
