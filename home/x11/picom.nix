{ lib, ... }:
{
  services.picom = {
    enable = true;
    fade = true;
    fadeExclude = [
      "window_type *= 'menu'"
    ];

    opacityRules = [
      "90:class_g = 'Alacritty' && focused"
      "65:class_g = 'Alacritty' && !focused"
    ];

    shadow = true;
    settings = {
      corner-radius = 10;
    };
  };
}
