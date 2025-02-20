# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
  };

  # Store optimization???
  nix.optimise = {
    automatic = true;
    dates = [ "13:45" ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };

  # Set your time zone.
  time.timeZone = "Europe/Belgrade";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable OpenGL ig
  hardware.graphics.enable = true;
  
  # Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    open = false;
    prime = {
      offload = {
			  enable = true;
			  enableOffloadCmd = true;
		  };
      intelBusId = "PCI:0:2:0";
		  nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Enable the Awesome Window Manager.
  # services.xserver.windowManager.awesome = {
  #   enable = true;
  #   package = pkgs.awesome.overrideAttrs (old: {
  #       version = "1f7ac8f9c7ab9fff7dd93ab4b29514ff3580efcf";
  #       src = pkgs.fetchFromGitHub {
  #           owner = "awesomeWM";
  #           repo = "awesome";
  #           rev = version;
  #           hash = "sha256-D5CTo4FvGk2U3fkDHf/JL5f/O1779i92UcRpPn+lbpw=";
  #       };
  #       patches = [];
  #       postPatch = ''
  #           patchShebangs tests/examples/_postprocess.lua
  #       '';
  #   });
  # };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nxc = {
    isNormalUser = true;
    description = "nxc";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Work stuff
      remmina
      networkmanager-l2tp
      strongswan

      # Dev stuff
      firefox-devedition
      ungoogled-chromium
      google-chrome
      vscodium
      nodejs
      nodePackages.pnpm
      bun
      git

      # Rice stuff
      fastfetch
      alacritty
      papirus-icon-theme
      vimix-cursor-theme
      cava
      rofi
      rofi-power-menu
      catppuccin-gtk
      # rofimoji

      # Goodies
      flameshot
      discord
      sl
      protonup
      prismlauncher
      nix-prefetch-git
    ];
  };

  # Controller
  hardware.uinput.enable = true;
  services.udev = {
    enable = true;
    packages = with pkgs; [
      game-devices-udev-rules
    ];
  };

  # Install Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

  };
  hardware.steam-hardware.enable = true;

  # Install Firefox.
  # programs.firefox.enable = true;

  # Install Gamemode
  programs.gamemode.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"

    "nvidia-x11"
    "nvidia-settings"
    "nvidia-persistenced"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/nxc/.steam/root/compatibilitytools.d";
  };

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