{ pkgs, ... }:

{
  # Helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "kanagawa";
      editor.soft-wrap.enable = true;
      editor.true-color = true;
      editor.color-modes = true;
    };
    ignores = [
      "!.gitignore"
    ];
    languages.language-server.rust-analyzer.config = {
      check.command = "clippy";
    };
    themes.catppuccin_mocha_transparent = {
      inherits = "catppuccin_mocha";
      "ui.background" = { };
      "ui.statusline" = {
        fg = "#d1d1d1";
      };
    };
  };

}
