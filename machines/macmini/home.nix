{ pkgs, lib, ... }: {
  home.homeDirectory = lib.mkForce "/Users/will";
}
