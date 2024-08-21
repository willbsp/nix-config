{ pkgs, ... }:
{
  environment.systemPackages =
    [ pkgs.cowsay ];

  users.users.will = {
    description = "Will Spooner";
  };

  programs.zsh.enable = true;

  # Enable nix daemon
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}

