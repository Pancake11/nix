{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in
{
  programs.i3status-rust = {
    enable = true;
    bars.default = {
      settings = {
        theme = {
          theme = "modern";
        };
        icons = {
          icons = "awesome6";
        };
      };
      blocks = [
        {
          block = "custom";
          command = "echo user: `whoami`";
          interval = "once";
        }
        {
          block = "custom";
          json = true;
          command = ''
            echo "{\"icon\":\"ping\",\"text\":\"`ping -c4 1.1.1.1 | tail -n1 | cut -d'/' -f5`\"}"
          '';
          interval = 60;
          click = [
            {
              button = "left";
              cmd = "<command>";
            }
          ];
        }
        {
          alert = 10.0;
          block = "disk_space";
          info_type = "available";
          interval = 60;
          path = "/";
          warning = 20.0;
        }
        {
          block = "memory";
          format = " $icon $mem_used_percents ";
          format_alt = " $icon $swap_used_percents ";
        }
        {
          block = "cpu";
          interval = 1;
        }
        {
          block = "load";
          format = " $icon $1m ";
          interval = 1;
        }
        {
          block = "time";
          format = " $timestamp.datetime(f:'%a %d/%m %R') ";
          interval = 60;
        }
        {
          block = "battery";
          format = "$icon $percentage";
        }
      ];
    };
  };

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

      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
        }
      ];
    };
  };
}
