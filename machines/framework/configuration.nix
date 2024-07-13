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
    initrd = {
      systemd.enable = true;
      verbose = false; # silent boot
    };
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    consoleLogLevel = 0; # silent boot
    kernelParams = [
      # enable s3 "deep" sleep
      "mem_sleep_default=deep"
      # silent boot settings
      "quiet"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "resume_offset=130738176"
    ];
    resumeDevice = "/dev/mapper/luks-344ad56a-0547-4cf4-94c7-c2fda50b6768";
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 48 * 1024;
  }];

  # Hardware
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true; # for seeing bluetooth device charge
    };
  };

  # Networking
  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  # X server
  services.xserver.enable = true;

  # Gnome display manager
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable virtualisation
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Ratbagd for mouse
  services.ratbagd.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.autostart.enable = true;

  # Fwupd
  services.fwupd.enable = true;

  # For accessing iOS devices
  services.usbmuxd.enable = true;

  # Power profiles daemon
  services.power-profiles-daemon.enable = true;

  # User account
  users.users.will = {
    isNormalUser = true;
    description = "Will Spooner";
    extraGroups = [ "networkmanager" "wheel" "dialout" "video" ];
  };

  # Sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [

      swaylock # screen lock
      swayidle # screen idle
      sway-contrib.grimshot # screenshot tool
      wl-clipboard # wayland clipboard
      mako # notification system

      i3blocks # for status bar
      acpi # for battery percentage in status bar
      alsa-utils # for volume in status bar
      pulseaudioFull # for pactl volume control

      kitty # term
      rofi-wayland # menu

    ];
  };

  # For sway volume and brightness keys
  programs.light.enable = true;

  # Enable keyring
  security.polkit.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;

  # Enable wayland support in chromium and electron applications
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Programs
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect.enable = true; # auto opens ports on firewall

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Font packages
  fonts.packages = with pkgs; [
    cantarell-fonts # gnome font
  ];

  # System packages
  environment.systemPackages = with pkgs; [

    # Nextcloud client
    #nextcloud-client

    # For sway TODO move to extraPackages []
    networkmanagerapplet
    pwvucontrol
    loupe
    nautilus
    mpv-unwrapped
    moonlight-qt
    gnome-system-monitor

    # Utils
    wget
    unzip
    gcc
    sbctl

    # For accessing iOS devices
    libimobiledevice
    ifuse

    # Plasma related packages
    #kdePackages.krdc
    #kdePackages.kate
    #kdePackages.discover
    #kdePackages.partitionmanager
    #kdePackages.kde-gtk-config
    #kdePackages.breeze-gtk
    #(catppuccin-kde.override {
    #  flavour = [ "frappe" "latte" ];
    #  accents = [ "blue" ];
    #})
    #aha # for firmware security tab in plasma

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
