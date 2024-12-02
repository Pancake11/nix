{ pkgs, pkgs-unstable, ... }:
let
  mkAlias = pkgsName: aliasName: pkgs.writeShellScriptBin "${aliasName}" ''
    ${pkgsName}
  '';
  chrome = mkAlias "${pkgs.google-chrome}/bin/google-chrome-stable" "chrome";
in
{
  home.packages = with pkgs; [
    bat
    chrome
    feh
    font-awesome
    git
    google-chrome
    htop
    meslo-lgs-nf
    nixpkgs-fmt
    python3
    scrot
    tree
    xsel
    zoxide
    fish
    grc
    bear
  ];
}
