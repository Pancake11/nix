{config, pkgs, ... }:
{
	imports = [];

	home.packages = with pkgs; [
		mako
		wl-clipboard
	]

	wayland.windowManager.sway {
		enable = true;
	};

	services.greetd = {
		enable = true;
		settings = {
			default_session.command = ''
				${pkgs.greetd.tuigreet}/bin/tuigreet \
				--time \
				--asterisks \
				--user-menu \
				--cmd sway
				'';
		};
	};

	environment.etc."greetd/environments".text = ''
		sway
		'';	
}
