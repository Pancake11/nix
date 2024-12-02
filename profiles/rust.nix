{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo
    clippy
    rustc
    rustfmt
    gcc
    rustup
  ];
}
