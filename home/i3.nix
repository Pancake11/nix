{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in
{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = [
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
            format = "$icon $mem_used_percents ";
            format_alt = "$icon $swap_used_percents ";
          }
          {
            block = "cpu";
            interval = 1;
          }
          {
            block = "sound";
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            interval = 60;
          }
        ];
        settings = {
          theme = {
            theme = "solarized-dark";
            overrides = {
              idle_bg = "#123456";
              idle_fg = "#abcdef";
            };
          };
        };
        icons = "awesome5";
        theme = "gruvbox-dark";
      };
    };
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
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
}
