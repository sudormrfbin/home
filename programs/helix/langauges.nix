{ ... }:
{
  programs.helix.languages.language-server = {
    nil = {
      command = "nil";
      config.nil = {
        formatting.command = [ "nixfmt" ];
      };
    };

    typst-lsp = {
      command = "typst-lsp";
    };

    emmet-lsp = {
      command = "emmet-language-server";
      args = [ "--stdio" ];
    };

    unocss-lsp = {
      command = "unocss-language-server";
      args = [ "--stdio" ];
      roots = [ "uno.config.ts" ];
    };

    ruff = {
      command = "ruff-lsp";
      config = {
        settings = {
          run = "onSave";
        };
      };
    };

    scls = {
      command = "simple-completion-language-server";
      config = {
        max_completion_items = 20;
        snippets_first = true;
        feature_words = false;
        feature_snippets = true;
        feature_unicode_input = false;
        feature_paths = true;
      };
    };

    dart = {
      command = "dart";
      args = [
        "language-server"
        "--client-id=helix"
      ];
      config = {
        dart.completeFunctionCalls = true;
        dart.includeDependenciesInWorkspaceSymbols = false;
      };
    };
  };

  programs.helix.languages.language = [
    {
      name = "python";
      auto-format = true;
      language-servers = [
        "ruff"
        "pyright"
      ];
    }
    {
      name = "php";
      auto-format = true;
    }
    {
      name = "typescript";
      auto-format = true;
      indent = {
        tab-width = 4;
        unit = "    ";
      };
    }
    {
      name = "typst";
      auto-format = true;
      language-servers = [ "tinymist" ];
    }
    {
      name = "nix";
      auto-format = true;
    }
    {
      name = "javascript";
      auto-format = true;
    }
    {
      name = "html";
      language-servers = [
        "vscode-html-language-server"
        "emmet-lsp"
      ];
    }
    {
      name = "css";
      language-servers = [
        "vscode-css-language-server"
        "emmet-lsp"
      ];
    }
    {
      name = "dart";
      language-servers = [ "dart" ];
    }
    {
      name = "svelte";
      auto-format = true;
      language-servers = [ "svelteserver" ];
    }
  ];

  # language.auto-pairs = {
  #   "(" = ")";
  #   "{" = "}";
  #   "[" = "]";
  #   "\"" = "\"";
  #   "`" = "`";
  #   "$" = "$";
  # };

}
