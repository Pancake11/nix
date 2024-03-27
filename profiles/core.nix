{ config, pkgs, lib, ... }:
{
	imports = 
		[
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

	programs.hyprland.enable = true;

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
		extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd"];
		packages = with pkgs; [
			firefox
		];
	};

	environment.pathsToLink = [ "/libexec" ];

# Environment
	environment.variables = {
		EDITOR = "nvim";
	};

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
	];

	documentation = {
		enable = true;
		man.enable = true;
		dev.enable = true;  
	};

# Enable CUPS to print documents.
	services.printing.enable = true;

# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
	};

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
			python3
			poetry
			discord
			ripgrep
			xsel
			gdu
			bottom
			htop
			gdb
			file
			unzip
			neovim
			arandr
			chromium

			qemu
			radare2
			ast-grep

			wget
			clang
			libclang
			git
			gcc
			cmake
			slack
			yaml-cpp

			bat
			kitty

			cargo
			clippy
			rustup
			rustc
			rust-analyzer

			nodejs_20

			autoconf
			automake
			libtool
			gnumake
			gnum4

			re-flex
			bison

			lazygit

			linux-manual
			man-pages
			man-pages-posix

			jdk17

			rpm
			networkmanagerapplet

			# wayland and hyprland
			waybar
			rofi-wayland
			dunst
			libnotify
			swww
			wdisplays
			];

# Docker
	virtualisation.docker.enable = true;

# Virt-manager
	virtualisation.libvirtd.enable = true;
	programs.virt-manager.enable = true;

	system.stateVersion = "23.11"; # Did you read the comment?
}
