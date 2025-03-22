{
  description = "My Home Manager configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
      defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;

      homeConfigurations = {
        "subcom@subcom" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./subcom.nix ];
        };
        "gokul@gokul" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./personal.nix ];
        };
      };
    };
}
