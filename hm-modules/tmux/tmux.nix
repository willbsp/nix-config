{ pkgs, lib, config, ... }: {
  options = {
    tmux.enable =
      lib.mkEnableOption "Enables tmux configuration";
  };

  config = lib.mkIf config.git.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      keyMode = "vi";
      shortcut = "a";
      baseIndex = 1;
      mouse = true;
      extraConfig = ''
        source-file ~/.config/tmux/theme.conf
        run-shell ${pkgs.tmuxPlugins.rose-pine}/share/tmux-plugins/rose-pine/rose-pine.tmux
      '';
      plugins = with pkgs.tmuxPlugins; [
        rose-pine
      ];
    };
  };
}

