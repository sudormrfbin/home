{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    # vendor.completions.enable = true;
    # vendor.config.enable = true;
    # vendor.functions.enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      zoxide init --cmd j fish | source
      fzf_configure_bindings --directory=\co

      fish_vi_key_bindings
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore

      bind -M insert \e/ __fish_toggle_comment_commandline
      bind -M insert '`' merge-history-or-accept-suggestion
      bind -M insert \cp up-or-search
      bind -M insert \eu undo
      bind -M insert \eU redo
      bind -M insert \cx copy-current-or-last-cmdline
      bind -M insert \cn down-or-search
      bind -M insert \e0 __fish_preview_current_file
      bind -M insert \e\> history-token-search-forward
      bind -M insert \ck kill-line

      # putting this in home-manager's sessionVars is messing with the
      # derivation build step somehow. Put it here for now.
      set -x FZF_DEFAULT_OPTS '--bind "ctrl-x:execute-silent(printf \'%s \' {+} | xclip -selection clipboard)+abort" --height=20% --cycle'
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
      gc = {
        setCursor = true;
        expansion = ''git commit -m "%"'';
      };
      gcam = {
        setCursor = true;
        expansion = ''git commit -am "%"'';
      };

      "-" = "cd -";

      ins = "sudo apt install";
      upd = "sudo apt update";
      upg = "sudo apt upgrade";
      rem = "sudo apt remove";

      imd = "systemctl poweroff";

      xo = "xdg-open";
      xc = "xclip -sel clip";

      c = "cargo";

      h = "$EDITOR ~/.config/home-manager";
      hs = "home-manager switch --flake ~/.config/home-manager";
    };

    functions = {
      merge-history-or-accept-suggestion = {
        body = ''
          set -l cmdline (commandline -b | string collect)
          if test -z "$cmdline"
              history merge
          else
              commandline -f accept-autosuggestion
          end
        '';
      };
      ls = {
        wraps = "eza";
        body = "eza --icons --classify --color-scale --group-directories-first --hyperlink $argv";
      };
      copy-current-or-last-cmdline = {
        body = ''
          set cmdline (commandline -b | string collect)
          if test -z "$cmdline"
            echo -n "$history[1]" | fish_clipboard_copy
          else
            fish_clipboard_copy
          end
        '';
      };
    };

    plugins =
      let
        plug = name: {
          name = "${name}";
          src = pkgs.fishPlugins."${name}".src;
        };
      in
      [
        # doesn't work on wayland properly (does work with kitty)
        # https://github.com/franciscolourenco/done/issues/134
        (plug "done")
        (plug "pure")
        (plug "pisces")
        (plug "puffer")
        (plug "fzf-fish")
        (plug "fish-bd")
        (plug "colored-man-pages")
      ];
  };
}
