{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    dunst
    libnotify
    swww
    wdisplays
  ];

  programs.hyprland.enable = true;
}
