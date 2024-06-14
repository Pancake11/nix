{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./sound.nix
    ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc.options = "--delete-older-than 10d";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Paris";

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  programs.nm-applet.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  users.users.pancook = {
    isNormalUser = true;
    description = "Maxim";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  environment.pathsToLink = [ "/libexec" ];

  # Environment
  environment.variables = {
    EDITOR = "nvim";
    CPATH = lib.mkForce (builtins.concatStringsSep ":" [
      (lib.makeSearchPathOutput "dev" "include" [ pkgs.stdenv.cc.cc.lib ])
    ]);
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  environment.systemPackages = with pkgs; [
    python3
    poetry
    discord
    ripgrep
    xsel
    gdu
    bottom
    htop
    file
    unzip
    chromium

    qemu
    lazygit
    wget
    git
    bat

    linux-manual
    man-pages
    man-pages-posix
    rofi

    rpm
    networkmanagerapplet
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  system.stateVersion = "24.05"; # Did you read the comment?

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };
}
