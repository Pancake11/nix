{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  users.users.pancook.extraGroups = [ "docker" ];
}
