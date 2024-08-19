{ pkgs, inputs, ... }: {

  sway.enable = true; # enable sway configuration module
  kitty.disableTabs = true;
  nvim.latexSupport = true;
  nvim.autoDark = true;

  home.packages = with pkgs; [
    protonmail-desktop
    piper # for logitech mouse configuration
    androidStudioPackages.canary
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
        done <~/.config/sway/rose-pine
        while read p; do
          ${pkgs.sway}/bin/swaymsg $p
        done <~/.config/sway/set-sway-colours
      '';
      kitty-theme = ''
        ${pkgs.kitty}/bin/kitten theme --config-file-name=/tmp/kitty.conf --reload-in=all 'Rosé Pine'
      '';
      tmux = ''
        echo "set -g @rose_pine_variant 'main'" > ~/.config/tmux/theme.conf
        ${pkgs.tmux}/bin/tmux source ~/.config/tmux/tmux.conf
      '';
      rofi-theme = ''
        echo '@theme "~/.config/rofi/rose-pine.rasi"' > ~/.config/rofi/theme.rasi
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
        done <~/.config/sway/rose-pine-dawn
        while read p; do
          ${pkgs.sway}/bin/swaymsg $p
        done <~/.config/sway/set-sway-colours
      '';
      kitty-theme = ''
        ${pkgs.kitty}/bin/kitten theme --config-file-name=/tmp/kitty.conf --reload-in=all 'Rosé Pine Dawn'
      '';
      tmux = ''
        echo "set -g @rose_pine_variant 'dawn'" > ~/.config/tmux/theme.conf
        ${pkgs.tmux}/bin/tmux source ~/.config/tmux/tmux.conf
      '';
      rofi-theme = ''
        echo '@theme "~/.config/rofi/rose-pine-dawn.rasi"' > ~/.config/rofi/theme.rasi
      '';
    };
    settings = {
      usegeoclue = false;
    };
  };

  programs.zsh.enable = true;

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
