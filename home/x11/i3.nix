{ config, lib, pkgs, ... }:

let
  i3lock_script = pkgs.pkgs.writeShellScriptBin "i3lock-script"
    ''
      ${pkgs.scrot}/bin/scrot -z /tmp/i3lock.png;

      eval convert /tmp/i3lock.png -quality 4 -level 0%,100%,0.8 -blur 4x4 /tmp/i3lock.png;

      ${pkgs.i3lock}/bin/i3lock -i /tmp/i3lock.png;

      rm -f /tmp/i3lock.png
    '';

  mod = "Mod4";
in
{

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      window =
        {
          border = 0;
          titlebar = false;
        };

      gaps =
        {
          inner = 7;
          outer = 5;
        };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        }
      ];

      modifier = mod;

      keybindings = lib.mkOptionDefault {
        # General
        "${mod}+Return" = "exec alacritty";
        "${mod}+s" = "exec --no-startup-id rofi -show drun -show-icons";
        "${mod}+l" = "exec ${i3lock_script}/bin/i3lock-script";
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
}
