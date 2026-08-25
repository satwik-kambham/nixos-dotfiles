{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    # Text Editors
    helix
    pkgs-unstable.zed-editor-fhs

    pkgs-unstable.codex
    git
    difftastic
    gh
    curl
    wget
    coreutils
    gnumake
    ripgrep
    fd
    fzf
    tmux
    eza
    zoxide
    bat
    nil
  ];

  # direnv
  programs.direnv = {
    enable = true;
  };

  # Nix-ld
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # stdenv.cc.cc
      openssl
      libxcomposite
      libxtst
      libxrandr
      libxext
      libx11
      libxfixes
      libGL
      libva
      # pipewire.lib
      libxcb
      libxdamage
      libxshmfence
      libxxf86vm
      libelf

      # Required
      glib
      gtk2
      bzip2

      # Without these it silently fails
      libxinerama
      libxcursor
      libxrender
      libxscrnsaver
      libxi
      libsm
      libice
      gnome2.GConf
      nspr
      nss
      cups
      libcap
      SDL2
      libusb1
      dbus-glib
      ffmpeg
      # Only libraries are needed from those two
      libudev0-shim

      # Verified games requirements
      libxt
      libxmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew_1_10
      libidn
      tbb

      zlib

      # Other things from runtime
      flac
      freeglut
      libjpeg
      libpng
      libpng12
      libsamplerate
      libmikmod
      libtheora
      libtiff
      pixman
      speex
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_ttf
      SDL2_mixer
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcaca
      libcanberra
      libgcrypt
      libvpx
      librsvg
      libxft
      libvdpau
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      dbus
      expat
      # Needed for electron
      libdrm
      mesa
      libxkbcommon

      gtk3
      pango
      alsa-lib
      libglvnd
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.monaspace
    nerd-fonts.jetbrains-mono
    inter
    vista-fonts
  ];

  # ZSH config
  environment.shells = with pkgs; [ zsh ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      l = "eza -la --icons=auto";
      li = "l --git-ignore";
      lt = "li -T";
      shx = "sudo hx";
      gs = "git status";
      gd = "git -c diff.external=difft diff";
      gdc = "git -c diff.external=difft diff --cached";
      ga = "git add .";
      gp = "git push";
      gpu = "git pull";
      gc = "git commit -m";
    };

    histSize = 10000;
  };

  programs.starship = {
    enable = true;
  };
}
