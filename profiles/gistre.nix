{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    heptagon
    arduino
    quartus-prime-lite
  ];
}
