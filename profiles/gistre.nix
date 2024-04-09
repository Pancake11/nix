{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    let
      r-studio = rstudioWrapper.override
        {
          packages = with rPackages; [ corrplot FactoMineR ];
        };
    in
    [
      heptagon
      arduino
      quartus-prime-lite

      r-studio
    ];
}
