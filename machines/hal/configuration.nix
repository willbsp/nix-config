# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    extraModulePackages = [ pkgs.linuxKernel.packages.linux_6_6.rtl8812au ];
  };

  # Networking
  networking.hostName = "hal"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking = {
    interfaces.eno1 = {
      ipv4.addresses = [{
        address = "192.168.10.4";
        prefixLength = 24;
      }];
    };
  };
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false; # prevent nixos-rebuild failing
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  # Filesystems
  fileSystems."/mnt/wd-ext" = {
    device = "/dev/disk/by-uuid/cc13983b-12c0-422f-a1ff-2cc503a726fa";
    fsType = "ext4";
  };
  fileSystems."/mnt/sg-ext" = {
    device = "/dev/disk/by-uuid/61992827-20ca-4322-ae3d-ad7226317541";
    fsType = "ext4";
  };
  fileSystems."/mnt/ks-int" = {
    device = "/dev/disk/by-uuid/13bd81ee-f89d-4fa3-9e04-51412d920e94";
    fsType = "ext4";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.will = {
    isNormalUser = true;
    description = "Will Spooner";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Docker
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_25;
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    docker-compose
    borgbackup
    wakeonlan
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
