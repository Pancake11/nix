{ lib, ... }:
{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./neovim/neovim.nix
    ./packages.nix
    ./hyprland.nix
    ./waybar.nix
  ];

  home.username = "pancook";
  home.homeDirectory = lib.mkForce "/home/pancook";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}
