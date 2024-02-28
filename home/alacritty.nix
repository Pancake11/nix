{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "full";
        opacity = 1.0;
        startup_mode = "Windowed";
        title = "Alacritty";
        dynamic_title = true;
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
      };
      font = {
        normal = {
          family = "MesloLGS NF";
          style = "regular";
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };
        size = 11.0;
      };
    };
  };
}
