{ lib, ... }: {

  imports = [
    ./ideavim/ideavim.nix
  ];

  ideavim.enable = lib.mkDefault true;

}
