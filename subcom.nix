{ pkgs, config, ... }:
{
  home = {
    packages = with pkgs; [
      fd
      bat
      fzf
      zoxide
      ripgrep
      just
      xclip
      # will be changed to this in the feature
      # nerd-fonts.jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    username = "subcom";
    homeDirectory = "/home/subcom";

    sessionVariables = {
      EDITOR = "hx";
      USE_CCACHE = "1";
      CCACHE_EXEC = "/usr/bin/ccache";
    };

    stateVersion = "23.11";
  };

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;

  # Read https://nix-community.github.io/home-manager/index.xhtml#sec-usage-gpu-non-nixos
  # and setup nixgl correctly
  programs.kitty = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.kitty);
  };

  programs.ghostty = {
    enable = true;
    package = (config.lib.nixGL.wrap pkgs.ghostty);
  };

  programs.fish = {
    enable = true;
    # vendor.completions.enable = true;
    # vendor.config.enable = true;
    # vendor.functions.enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      zoxide init --cmd j fish | source
      fzf_configure_bindings --directory=\co
      tide configure --auto --style=Lean --prompt_colors='True color' --show_time=No --lean_prompt_height='Two lines' --prompt_connection=Dotted --prompt_connection_andor_frame_color=Dark --prompt_spacing=Sparse --icons='Few icons' --transient=No

      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore

      bind -M insert '`' accept-autosuggestion

      abbr --set-cursor --add gc git commit -m \"%\"
      abbr --set-cursor --add gcam git commit -am \"%\"
    '';
    shellAbbrs = {
      rl = "exec fish";
      x = "chmod +x";
      l = "ls";

      g = "git";
      gs = "git status";
      g- = "git switch -";
      ga = "git add";
      gl = "git log";
      gb = "git branch --sort=-committerdate";
      gd = "git diff";
      gph = "git push";
      gpl = "git pull";
      gco = "git checkout";
      gsp = "git stash pop";
      # gc = "git commit -m";
      gca = "git commit --amend";
      # gcam = "git commit -am";
      gcaan = "git commit --amend --all --no-edit";
      gcl = "git clone --depth=1";

      "-" = "cd -";

      ins = "sudo apt install";
      upd = "sudo apt update";
      upg = "sudo apt upgrade";
      rem = "sudo apt remove";

      c = "cargo";

      h = "$EDITOR ~/my-home-manager/home.nix";
      hs = "pushd ~/my-home-manager; home-manager switch --flake .#subcom; popd";
    };

    plugins = with pkgs.fishPlugins; [
      # doesn't work on wayland properly (does work with kitty)
      # https://github.com/franciscolourenco/done/issues/134
      # { name = "done"; src = done.src; }
      {
        name = "tide";
        src = tide.src;
      }
      {
        name = "tide";
        src = tide.src;
      }
      {
        name = "pisces";
        src = pisces.src;
      }
      {
        name = "puffer";
        src = puffer.src;
      }
      {
        name = "fzf-fish";
        src = fzf-fish.src;
      }
      {
        name = "fish-bd";
        src = fish-bd.src;
      }
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
    ];
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      nil
    ];
    settings = {
      theme = "catppuccin_macchiato";
      keys.normal = {
        S-backspace = "file_picker";
        backspace = "file_picker_in_current_directory";
        A-x = [
          "extend_to_line_bounds"
          "trim_selections"
        ];
        ret = ":write";
        g = {
          l = "extend_to_line_end";
          h = "extend_to_line_start";
          e = "goto_file_end";
        };
        C-r = ":reload";
        C-n = ":buffer-previous";
        C-m = ":buffer-next";
        F5 = ":sh kill -USR2 $(cat /tmp/flutter.pid)";
        F4 = ":sh pytest -q";
        tab = "goto_word";
        space = {
          x = ":buffer-close";
          v = ":reload-all";
          i = ":toggle-option lsp.display-inlay-hints";
          e = {
            e = ":config-open";
            r = ":config-reload";
          };
        };
      };

      keys.select = {
        g = {
          e = "goto_file_end";
        };
      };

      keys.insert = {
        "C-t" = "indent";
        "C-d" = "unindent";
      };

      editor = {
        line-number = "relative";
        scrolloff = 3;
        idle-timeout = 50;
        rulers = [ 80 ];
        completion-trigger-len = 1;
        auto-completion = true;
        cursorline = true;
        indent-guides.render = true;
        bufferline = "multiple";
        color-modes = true;
        gutters = [
          "diagnostics"
          "spacer"
          "diff"
          "line-numbers"
          "spacer"
        ];
        insert-final-newline = false;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        whitespace = {
          render.newline = "all";
          characters.newline = "¬";
        };
        lsp.display-messages = true;
      };
    };
  };
}
