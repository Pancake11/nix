{ config, pkgs, lib, ... }:
{
  imports = [
    ./i3.nix
    ./picom.nix
    ./i3-status.nix
    ./dunst.nix
    ./gtk-theme.nix
  ];

  home.packages = with pkgs; [
    imagemagick
  ];
}
