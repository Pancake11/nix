{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    [
      arduino
      openocd
      gcc-arm-embedded
    ];
}
