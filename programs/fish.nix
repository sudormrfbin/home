{ pkgs, ... }:
{
  programs.fish = {
    enable = false;
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
}
