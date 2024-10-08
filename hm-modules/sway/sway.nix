{ pkgs, lib, config, ... }: {
  options = {
    sway.enable =
      lib.mkEnableOption "Enables sway configuration";
  };

  config = lib.mkIf config.sway.enable
    {
      xdg.configFile."sway/config".source = ./sway/config;
      xdg.configFile."sway/set-sway-colours".source = ./sway/set-sway-colours;
      xdg.configFile."sway/catppuccin-frappe".source = ./sway/catppuccin-frappe;
      xdg.configFile."sway/catppuccin-latte".source = ./sway/catppuccin-latte;
      xdg.configFile."sway/rose-pine".source = ./sway/rose-pine;
      xdg.configFile."sway/rose-pine-dawn".source = ./sway/rose-pine-dawn;
      xdg.configFile."mako/config".source = ./mako/config;
      xdg.configFile."rofi/config.rasi".source = ./rofi/config.rasi;
      xdg.configFile."rofi/rose-pine.rasi".source = ./rofi/rose-pine.rasi;
      xdg.configFile."rofi/rose-pine-dawn.rasi".source = ./rofi/rose-pine-dawn.rasi;
      xdg.configFile."i3blocks/config".source = ./i3blocks/config;
      xdg.configFile."i3blocks/scripts/battery".source = ./i3blocks/scripts/battery.sh;
      xdg.configFile."i3blocks/scripts/volume".source = ./i3blocks/scripts/volume.sh;
      xdg.configFile."i3blocks/scripts/memory".source = ./i3blocks/scripts/memory.sh;
      xdg.configFile."i3blocks/scripts/load_average".source = ./i3blocks/scripts/load_average.sh;
      xdg.configFile."i3blocks/scripts/bluetooth".source = ./i3blocks/scripts/bluetooth.sh;
    };
}
