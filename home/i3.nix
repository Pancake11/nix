{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in
{
  programs.i3status-rust = {
    enable = true;

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      keybindings = lib.mkOptionDefault {
        # General
        "${mod}+Return" = "exec alacritty";
        "${mod}+d" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run";
        "${mod}+l" = "exec sh -c '${pkgs.i3lock}/bin/i3lock'";
        "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'";
        "${mod}+r" = "restart";

        # Focus
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+f" = "fullscreen toggle";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";
      };
    };
  };
};
}
