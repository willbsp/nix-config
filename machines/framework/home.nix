{ pkgs, inputs, ... }: {
  #home.file.".zshrc".source = ./zsh/.zshrc;
  home.file.".config/fastfetch/logo.jpg".source = ./fastfetch/spot.jpg;

  sway.enable = true; # enable sway configuration module
  kitty.disableTabs = true;
  nvim.latexSupport = true;

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
    zathura
    moonlight-qt
    mpv-unwrapped
    qmk
    adw-gtk3
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  services.darkman = {
    enable = true;
    darkModeScripts = {
      gtk-theme = ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3-dark'"
      '';
      sway-theme = ''
        while read p; do
          ${pkgs.sway}/bin/swaymsg $p
        done <~/.config/sway/catppuccin-frappe
        while read p; do
          ${pkgs.sway}/bin/swaymsg $p
        done <~/.config/sway/set-sway-colours
      '';
      kitty-theme = ''
        ${pkgs.kitty}/bin/kitten theme --config-file-name=/tmp/kitty.conf --reload-in=all Catppuccin-Frappe
      '';
    };
    lightModeScripts = {
      gtk-theme = ''
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        ${pkgs.dconf}/bin/dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3'"
      '';
      sway-theme = ''
        while read p; do
          ${pkgs.sway}/bin/swaymsg $p
        done <~/.config/sway/catppuccin-latte
        while read p; do
          ${pkgs.sway}/bin/swaymsg $p
        done <~/.config/sway/set-sway-colours
      '';
      kitty-theme = ''
        ${pkgs.kitty}/bin/kitten theme --config-file-name=/tmp/kitty.conf --reload-in=all Catppuccin-Latte
      '';
    };
    settings = {
      usegeoclue = false;
    };
  };

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
