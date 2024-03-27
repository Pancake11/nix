{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    autoconf
    autoconf-archive
    automake
    autoreconfHook
    clang-tools
    cmake
    gcc
    gdb
    gnumake
    libtool
    libyamlcpp
    slack
    universal-ctags
    valgrind
    clang
    libclang
  ];
}
