{ pkgs, lib, ... }: {

  imports = [
    ./ideavim/ideavim.nix
    ./nvim/nvim.nix
    ./git/git.nix
    ./kitty/kitty.nix
  ];

  ideavim.enable = lib.mkDefault true;
  nvim.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;

  home.username = "will";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    btop
  ];
  programs.home-manager.enable = true;

}
