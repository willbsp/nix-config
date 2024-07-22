{ pkgs, lib, config, ... }: {
  options = {
    sway.enable =
      lib.mkEnableOption "Enables sway configuration";
  };

  config = lib.mkIf config.sway.enable
    {
      xdg.configFile."sway/config".source = ./sway/config;
      xdg.configFile."sway/catppuccin-frappe".source = ./sway/catppuccin-frappe;
      xdg.configFile."mako/config".source = ./mako/config;
      xdg.configFile."i3blocks/config".source = ./i3blocks/config;
      xdg.configFile."i3blocks/scripts/battery".source = ./i3blocks/scripts/battery.sh;
      xdg.configFile."i3blocks/scripts/volume".source = ./i3blocks/scripts/volume.sh;
      xdg.configFile."i3blocks/scripts/memory".source = ./i3blocks/scripts/memory.sh;
      xdg.configFile."i3blocks/scripts/load_average".source = ./i3blocks/scripts/load_average.sh;
      xdg.configFile."i3blocks/scripts/bluetooth".source = ./i3blocks/scripts/bluetooth.sh;
    };
}
