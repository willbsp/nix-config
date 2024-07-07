{ pkgs, lib, ... }: {
  imports = [ ../../home.nix ];

  home.file.".zshrc".source = ./zsh/.zshrc;
  home.file.".config/fastfetch/logo.jpg".source = ./fastfetch/spot.jpg;

  home.packages = with pkgs; [
    protonmail-desktop
    piper # for logitech mouse configuration
    android-studio
    godot_4
    unityhub
    angryipscanner
    qflipper
    dolphin-emu
    rpi-imager
  ];

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty";
        source = "~/.config/fastfetch/logo.jpg";
        width = 32;
        padding = {
          top = 1;
        };
      };
      modules = [
        "break"
        "title"
        "separator"
        "os"
        "kernel"
        "board"
        "bootmgr"
        "shell"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "wifi"
        "processes"
        "packages"
      ];
    };
  };

}
