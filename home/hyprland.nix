{ pkgs, ... }:
let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.swww}/bin/swww init &
  
    sleep 1
  
    ${pkgs.swww}/bin/swww img ${./wallpaper/wallpaper.jpg} &
  '';
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = {
      monitor = ",highrr,auto,1";
      "$mod" = "Mod4";
      exec-once = ''${startupScript}/bin/start'';
      bind =
        [
          "$mod, F, exec, firefox"
          "$mod, Q, exec, alacritty"
          "$mod, S, exec, rofi -show drun -show-icons"
          ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };

}
