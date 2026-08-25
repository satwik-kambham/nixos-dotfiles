{ pkgs, ... }:

{
  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 20;
        normal.family = "MonaspiceNe Nerd Font";
      };
      window = {
        padding = {
          x = 5;
          y = 5;
        };
        dynamic_padding = true;
      };
    };
  };
}
