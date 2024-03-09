{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "git+https://github.com/nix-community/home-manager?ref=release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "git+https://github.com/numtide/flake-utils?ref=main";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-master, home-manager, flake-utils, nixos-hardware, hyprland } @ inputs:
    let
      inherit (nixpkgs) lib;

      pkgImport = pkgs: system:
        import pkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };

			pkgset = system: {
				pkgs = pkgImport nixpkgs system;
				pkgs-unstable = pkgImport nixpkgs-unstable system;
				pkgs-master = pkgImport nixpkgs-master system;
			};
	  in
	  {
			nixosConfigurations =
        let
          nixosSystem = hostName:
            let
              system = "x86_64-linux";
            in
            lib.nixosSystem {
              inherit system;
              specialArgs = inputs;
              modules = [
                ./hosts/${hostName}
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.extraSpecialArgs = { inherit (pkgset system) pkgs-unstable; };
                  home-manager.useUserPackages = true;
                  home-manager.users.pancook= {
                    imports = [
                      ./home
                    ];
                  };
                }
                ({
                  nixpkgs = {
                    inherit system;
                    inherit (pkgset system) pkgs;
                  };
                })
              ];
            };
          hostNames = builtins.attrNames (lib.filterAttrs (n: v: v == "directory") (builtins.readDir ./hosts));
        in
        lib.genAttrs hostNames nixosSystem;
	};
}
