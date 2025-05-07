{ pkgs, ... }:
{
  imports = [
    ./programs/fish.nix
    ./programs/lazygit.nix
    ./programs/helix
  ];

  home = {
    packages = with pkgs; [
      fd
      eza
      delta
      bat
      fzf
      zoxide
      ripgrep
      uv
      # just
      # xclip
      # will be changed to this in the feature
      # nerd-fonts.jetbrains-mono
      # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    username = "gokul";
    homeDirectory = "/home/gokul";

    sessionVariables = rec {
      EDITOR = "hx";
      BROWSER = "/usr/bin/firefox";
      ANDROID_SDK_ROOT = "$HOME/Android";
      ANDROID_HOME = "${ANDROID_SDK_ROOT}";
      NDK_HOME = "${ANDROID_HOME}/ndk/26.1.10909125";
      CARGO_TARGET_DIR = "$HOME/.cache/cargo-target/";
      RUST_BACKTRACE = "1";
      SXHKD_SHELL = "/bin/bash";
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
