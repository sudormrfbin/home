{ ... }:
{
  programs.helix.settings = {
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
}
