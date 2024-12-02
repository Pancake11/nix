{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
    plugins = [
      #      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      #      { name = "gruvbox"; src = pkgs.fishPlugins.gruvbox.src; }
    ];
  };
}
