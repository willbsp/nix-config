{ pkgs, ... }:
{
  environment.systemPackages =
    [ pkgs.cowsay ];
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}

