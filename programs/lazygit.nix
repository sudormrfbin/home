{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
        theme = {
          activeBorderColor = [
            "#f5e0dc"
            "bold"
          ];
          inactiveBorderColor = [ "#a6adc8" ];
          optionsTextColor = [ "#89b4fa" ];
          selectedLineBgColor = [ "#313244" ];
          cherryPickedCommitBgColor = [ "#45475a" ];
          cherryPickedCommitFgColor = [ "#f5e0dc" ];
          unstagedChangesColor = [ "#f38ba8" ];
          defaultFgColor = [ "#cdd6f4" ];
          searchingActiveBorderColor = [ "#f9e2af" ];
        };

        authorColors = {
          "Gokul Soumya" = "#f5e0dc";
          "*" = "#b4befe";
        };
      };

      git = {
        paging = {
          colorArg = "never";
          pager = "delta --dark --paging=never --syntax-theme='OneHalfDark'";
          # pager = "delta --dark --paging=never --plus-style='syntax #012800' --minus-style='normal #340001' --syntax-theme='OneHalfDark'";
          # pager = dunk;
        };
      };
    };
  };
}
