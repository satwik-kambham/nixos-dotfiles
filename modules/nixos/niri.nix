{ pkgs, pkgs-unstable, ... }:

{
  services.xserver.enable = true;

  programs.niri.enable = true;

  # Enable polkit
  security.polkit.enable = true;

  # Enable gnome keyring with gdm
  security.pam.services.gdm-password.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [
    # Terminal Emulators
    alacritty
    ghostty

    waybar # Status Bar
    dunst # Notification Daemon
    awww # Wallpaper Manager
    waypaper # Wallpaper Manager
    fuzzel # Launcher
    networkmanagerapplet # NM Applet
    brightnessctl # Brightness controller
    playerctl # Media controller
    cliphist # Clipboard Manager
    wl-clipboard # Clipboard Manager
    nautilus # File Manager
    sushi # File Previewer
    lxqt.lxqt-policykit # Auth agent
    socat
    xwayland-satellite
  ];
}
