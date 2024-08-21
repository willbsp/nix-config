{ pkgs, lib, ... }: {
  home.homeDirectory = lib.mkForce "/Users/will";
  nvim.autoDark = true;
  kitty.enable = false;
}
