# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Kernel
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelPackages = pkgs.linuxPackages;

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
  networking = {
    networkmanager = {
      enable = true;
      enableStrongSwan = true;
      plugins = with pkgs; [ 
        networkmanager-l2tp
        networkmanager_strongswan
      ];
    };
  };
  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };
  systemd.tmpfiles.rules = [
    "L /etc/ipsec.secrets - - - - /etc/ipsec.d/ipsec.nm-l2tp.secrets"
  ];
  environment.etc."strongswan.conf".text = "";

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
    # package = config.boot.kernelPackages.nvidiaPackages.beta;
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
  # nix-prefetch-git --url https://github.com/awesomeWM/awesome.git --rev HEAD
  services.xserver.windowManager.awesome = {
    enable = true;
    package = pkgs.awesome.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
            owner = "awesomeWM";
            repo = "awesome";
            rev = "691e36425a645e54402cb04efc4c2b00d73051bd";
            hash = "sha256-IN5sNBDoC6CtBzr3Qp8S9r0rfqR2CD/maGB1aiZdRE4=";
        };
        patches = [];
        postPatch = ''
            patchShebangs tests/examples/_postprocess.lua
        '';
    });
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Power management
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      energy_performance_preference = "performance";
      turbo = "auto";
      scaling_min_freq = "3600000";
      # scaling_max_freq = "3600000";
    };
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
      networkmanager_strongswan
      # strongswan

      # Dev stuff
      firefox-devedition
      # inputs.zen-browser.packages.x86_64-linux.beta
      ungoogled-chromium
      vscodium
      nodejs_24
      pnpm
      bun
      
      yt-dlp
      gallery-dl
      ffmpeg

      # Rice stuff
      fastfetch
      alacritty
      papirus-icon-theme
      vimix-cursors
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
      mangohud
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
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  hardware.steam-hardware.enable = true;

  # Install Firefox.
  # programs.firefox.enable = false;

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
    git
    wget

    # Brightness
    brightnessctl

    # Sound
    alsa-utils
    playerctl
    pasystray

    # Fonts
    source-code-pro
    roboto

    # X Compositor
    picom

    # LXQT goodies
    lxde.lxsession
    lxappearance

    # XFCE goodies
    xfce.xfce4-power-manager

    # Gnome goodies
    gnome-font-viewer
    gnome-disk-utility
    gnome-multi-writer
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