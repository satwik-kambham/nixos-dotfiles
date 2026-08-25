{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    ../../modules/home/git.nix
    ../../modules/home/helix.nix
    ../../modules/home/starship.nix
    ../../modules/home/tmux.nix
    ../../modules/home/zoxide.nix
    ../../modules/home/alacritty.nix
    ../../modules/home/dunst.nix
    ../../modules/home/gtk.nix
    ../../modules/home/niri.nix
    ../../modules/home/qt.nix
    ../../modules/home/waybar.nix
  ];

  home.username = "satwik";
  home.homeDirectory = "/home/satwik";

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
