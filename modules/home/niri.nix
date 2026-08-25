{ pkgs, ... }:

{
  programs.niri = {
    enable = true;
    extraConfig = builtins.readFile ./files/config.kdl;
  };
}
