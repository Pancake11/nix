{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "maxim.payeur";
    userEmail = "maxim.payeur@epita.fr";
    delta.enable = true;
  };
}
