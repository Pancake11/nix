{ lib, ... }:
{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./i3.nix
    ./neovim.nix
    ./packages.nix
    ./sway.nix
  ];

  home.username = "pancook";
  home.homeDirectory = lib.mkForce "/home/pancook";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
