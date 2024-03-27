{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo
    clippy
    gcc
    rustup
    rustc
    rustfmt
  ];
}
