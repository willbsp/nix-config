{ lib, ... }: {
  imports = [
    ./zsh.nix
    ./nvim.nix
    ./localisation.nix
  ];

  zsh.enable = lib.mkDefault true;
  nvim.enable = lib.mkDefault true;
  localisation.enable = lib.mkDefault true;

}
