{ lib, ... }:
{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./neovim/neovim.nix
    ./packages.nix
    ./x11/default.nix
  ];

  home.username = "pancook";
  home.homeDirectory = lib.mkForce "/home/pancook";
  home.stateVersion = "24.11";

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  programs.home-manager.enable = true;
}
