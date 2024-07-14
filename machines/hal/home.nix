{ pkgs, lib, ... }: {
  imports = [ ../../home.nix ];
  home.file.".zprofile".source = ./zsh/.zprofile;
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "small";
      };
      modules = [
        "title"
        "os"
        "host"
        "kernel"
        "uptime"
        "cpu"
        "memory"
        "break"
      ];
    };
  };
}
