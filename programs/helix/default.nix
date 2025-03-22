{ pkgs, ... }:
{
  imports = [
    ./config.nix
    ./langauges.nix
  ];

  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      nil
      nixfmt-rfc-style
    ];
  };
}
