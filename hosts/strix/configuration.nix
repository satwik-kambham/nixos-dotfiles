{ config, pkgs, pkgs-unstable, inputs, lib, llamacpp_pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/development.nix
    ../../modules/nixos/cachix.nix
    ../../modules/nixos/gnome.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/tailscale.nix
    ../../modules/nixos/nvidia.nix
    inputs.home-manager.nixosModules.default
  ];

  # Defining user accounts. Don't forget to set a password with 'passwd'.
  users.users.satwik = {
    description = "satwik";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      libreoffice
    ];
    shell = pkgs.zsh;
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "satwik" = import ./home.nix;
    };
  };

  # Enable touchpad support
  services.libinput.enable = true;

  # Zsh aliases
  programs.zsh.shellAliases = {
    update = "sudo nixos-rebuild switch --flake .#strix";
    update-safe = "sudo nixos-rebuild boot --flake .#strix";
  };

  # Environment Variables
  environment.variables = {
    EDITOR = "hx";
  };

  environment.systemPackages = with pkgs; [
    llamacpp_pkgs.cuda

    (btop.override {
      cudaSupport = true;
    })
    ncdu
    evince
  ];
  services.flatpak.enable = true;

  # Networking hostname
  networking.hostName = "satwik-strix";
  networking.firewall.allowedTCPPorts = [ ];

  # Time Zone
  time.timeZone = "Asia/Kolkata";

  # Boot
  boot.loader.timeout = 0;

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.networkmanager.enable = true;

  # Enable sound
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";

  # X11 Keymap
  services.xserver.xkb.layout = "us";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Garbage collector
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # System state version
  system.stateVersion = "26.05";
}
