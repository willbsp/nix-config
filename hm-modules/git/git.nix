{ pkgs, lib, config, ... }: {
  options = {
    git.enable =
      lib.mkEnableOption "Enables git configuration";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "willbsp";
      userEmail = "github-wills.12zz7@aleeas.com";
    };
  };
}
