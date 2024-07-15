{ pkgs, ... }: {

  #home.file.".zshrc".source = ./zsh/.zshrc;
  home.file.".config/fastfetch/logo.jpg".source = ./fastfetch/spot.jpg;

  sway.enable = true; # enable sway configuration module

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

  programs.zsh.enable = true;
  programs.zsh.initExtra = "fastfetch";

  home.shellAliases = {
    nixdir = "cd /etc/nixos";
    nixconf = "nixdir; nvim machines/framework/configuration.nix";
    swayconf = "nixdir; nvim hm-modules/sway/sway/config";
    nvimconf = "nixdir; nvim hm-modules/nvim/nvim.nix";
  };

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

  # match libadaita apps
  gtk.enable = true;
  gtk.theme = {
    name = "adw-gtk3";
    package = pkgs.adw-gtk3;
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
