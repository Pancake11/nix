{ config, pkgs, lib, ... }:
{
  imports =
    [
      ./sound.nix
    ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc.options = "--delete-older-than 10d";
    settings.auto-optimise-store = true;
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
    shell = pkgs.fish;
  };

  users.defaultUserShell = pkgs.fish;

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
    man.generateCaches = false;
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
    arandr

    qemu
    lazygit
    wget
    git
    bat
    flameshot

    linux-manual
    man-pages
    man-pages-posix
    rofi

    rpm
    networkmanagerapplet
    glib
    ffmpeg
    krb5
    sshfs
    grc
    fishPlugins.grc
    flatpak
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

  services.gnome.gnome-keyring.enable = true;

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  services.displayManager = {
    defaultSession = "none+i3";
  };

  programs.dconf.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

}
