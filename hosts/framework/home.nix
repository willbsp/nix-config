{ pkgs, lib, ... }: {
  imports = [ ../../home.nix ];
  home.packages = with pkgs; [
    protonmail-desktop
    piper # for logitech mouse configuration
    androidStudioPackages.dev
    godot_4
    unityhub
    angryipscanner
    qflipper
    dolphin-emu
    rpi-imager
  ];
}
