{ pkgs, lib, config, ... }: {
  options = {
    kitty.enable =
      lib.mkEnableOption "Enables kitty configuration";
  };

  config = lib.mkIf config.kitty.enable
    {
      programs.kitty = {
        enable = true;
        theme = "Catppuccin-Frappe";
          keybindings = {
            # Unmap tab shortcuts, prefer using Sways tab layout
            "ctrl+shift+right" = "";
            "ctrl+shift+left" = "";
            "ctrl+tab" = "";
            "ctrl+shift+tab" = "";
            "ctrl+shift+q" = "";
            "ctrl+shift+." = "";
            "ctrl+shift+," = "";
            "ctrl+shift+alt+t" = "";
          };
        settings = {
          cursor_shape = "beam";
          tab_bar_align = "left";
          tab_bar_min_tabs = 1;
          wayland_titlebar_color = "background";
          macos_titlebar_color = "background";
          remember_window_size = false;
          initial_window_width = "127c";
          initial_window_height = "50c";
          confirm_os_window_close = 0;
          tab_bar_style = "hidden";
        };
      };
    };
}
