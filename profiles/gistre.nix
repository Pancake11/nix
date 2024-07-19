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
      stlink
      stm32cubemx
      openocd
      gcc-arm-embedded

      r-studio
    ];
}
