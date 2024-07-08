{ pkgs, lib, config, ... }: {

  options = {
    zsh.enable =
      lib.mkEnableOption "Enables default zsh configuration";
  };

  config = lib.mkIf config.zsh.enable {
    users.defaultUserShell = pkgs.zsh;
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = "gentoo";
      };
    };

  };

}
