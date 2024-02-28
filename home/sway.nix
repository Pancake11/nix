{config, pkgs, ... }:
{
	imports = [];

	home.packages = with pkgs; [
		mako
		wl-clipboard
	];

	wayland.windowManager.sway = {
		enable = true;
		config = rec {
      modifier = "Mod4"; # Super key
    };
	};
}
