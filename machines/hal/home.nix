{ pkgs, lib, ... }: {
  imports = [ ../../home.nix ];
  home.file.".zprofile".source = ./zsh/.zprofile;
}
