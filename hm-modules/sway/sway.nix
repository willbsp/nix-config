{ pkgs, lib, config, ... }: {
  options = {
    sway.enable =
      lib.mkEnableOption "Enables sway configuration";
  };

  config = lib.mkIf config.kitty.enable
    {
      xdg.configFile."sway/config".source = ./sway/config;
      xdg.configFile."i3blocks/config".source = ./i3blocks/config;
      xdg.configFile."i3blocks/scripts/battery".source = ./i3blocks/scripts/battery.sh;
      xdg.configFile."i3blocks/scripts/volume".source = ./i3blocks/scripts/volume.sh;
      xdg.configFile."i3blocks/scripts/memory".source = ./i3blocks/scripts/memory.sh;
      xdg.configFile."i3blocks/scripts/powerprofiles".source = ./i3blocks/scripts/powerprofiles.sh;
    };
}
