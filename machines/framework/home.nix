{ pkgs, lib, ... }: {
  imports = [ ../../home.nix ];

  home.file.".zshrc".source = ./zsh/.zshrc;
  home.file.".config/fastfetch/logo.jpg".source = ./fastfetch/spot.jpg;
  xdg.configFile."sway/config".source = ./sway/config;
  xdg.configFile."i3blocks/config".source = ./i3blocks/config;
  xdg.configFile."i3blocks/scripts/battery".source = ./i3blocks/scripts/battery.sh;
  xdg.configFile."i3blocks/scripts/volume".source = ./i3blocks/scripts/volume.sh;
  xdg.configFile."i3blocks/scripts/memory".source = ./i3blocks/scripts/memory.sh;
  xdg.configFile."i3blocks/scripts/powerprofiles".source = ./i3blocks/scripts/powerprofiles.sh;

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

  # for sway
  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

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
