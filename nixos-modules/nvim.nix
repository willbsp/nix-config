{ pkgs, lib, config, ... }: {

  options = {
    nvim.enable =
      lib.mkEnableOption "Enables nvim as default editor";
  };

  config = lib.mkIf config.nvim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
