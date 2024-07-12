{ pkgs, lib, config, ... }: {
  options = {
    ideavim.enable =
      lib.mkEnableOption "Enables ideavim configuration";
  };

  config = lib.mkIf config.ideavim.enable {
    home.file.".ideavimrc".source = ./.ideavimrc;
  };
}
