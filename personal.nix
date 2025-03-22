{ pkgs, ... }:
{
  imports = [
    # ./programs/fish.nix
    ./programs/helix
  ];

  home = {
    packages = with pkgs; [
      fd
      # bat
      # fzf
      # zoxide
      # ripgrep
      # just
      # xclip
      # will be changed to this in the feature
      # nerd-fonts.jetbrains-mono
      # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    username = "gokul";
    homeDirectory = "/home/gokul";

    sessionVariables = {
      EDITOR = "hx";
      # USE_CCACHE = "1";
      # CCACHE_EXEC = "/usr/bin/ccache";
    };

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  # Read https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-non-nixos
  # and setup nixgl correctly
  # programs.kitty = {
  #   enable = true;
  #   package = (config.lib.nixGL.wrap pkgs.kitty);
  # };

  # programs.ghostty = {
  #   enable = true;
  #   package = (config.lib.nixGL.wrap pkgs.ghostty);
  # };
}
