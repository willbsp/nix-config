{pkgs, lib, ...}: {
  imports = [ ../../home.nix];
  home.homeDirectory = lib.mkForce "/Users/will";
}
