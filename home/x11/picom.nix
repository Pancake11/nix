{ lib, ... }:
{
  services.picom = {
    enable = true;
    fade = true;
    fadeExclude = [
      "window_type *= 'menu'"
    ];
    shadow = true;
  };
}
