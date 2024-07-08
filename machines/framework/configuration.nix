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

  # Locale and time settings
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # X11
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # KDE Plasma and SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    oxygen
  ];


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

  # Fwupd
  services.fwupd.enable = true;

  # For accessing iOS devices
  services.usbmuxd.enable = true;

  # User account
  users.defaultUserShell = pkgs.zsh;
  users.users.will = {
    isNormalUser = true;
    description = "Will Spooner";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
  };

  # Disable fingerprint login (fixes SDDM stall w/ passwd)
  security.pam.services.login.fprintAuth = false;

  # Programs
  programs.firefox.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect.enable = true; # auto opens ports on firewall

  environment.shellAliases = {
    plasma-light = "plasma-apply-colorscheme BreezeLight";
    plasma-dark = "plasma-apply-colorscheme BreezeDark";
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "python" "man" ];
      theme = "gentoo";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System packages
  environment.systemPackages = with pkgs; [

    # Terminal
    kitty

    # Nextcloud client
    nextcloud-client

    # Utils
    wget
    unzip
    gcc
    sbctl
    wl-clipboard

    # For accessing iOS devices
    libimobiledevice
    ifuse

    # Plasma related packages
    kdePackages.krdc
    kdePackages.kate
    kdePackages.discover
    kdePackages.partitionmanager
    kdePackages.kde-gtk-config
    kdePackages.breeze-gtk
    (catppuccin-kde.override {
      flavour = [ "frappe" "latte" ];
      accents = [ "blue" ];
    })
    aha # for firmware security tab in plasma

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
