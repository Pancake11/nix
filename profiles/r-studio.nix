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
      r-studio
    ];
}
