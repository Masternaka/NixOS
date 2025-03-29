# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "serveur-nix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_CA.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;
  #services.displayManager.lightdm.enable = true;
  #services.desktopManager.xfce.enable = true;
  #services.desktopManager.cinnamon.enable = true;
  #services.desktopManager.budgie.enable = true;
  #services.desktopManager.mate.enable = true;
  #services.windowManager.i3.enable = true;
  #services.windowManager.qtile.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ca";
    variant = "multix";
  };

  # Configure console keymap
  console.keyMap = "cf";

  # Enable CUPS to print documents.
  services.printing.enable = true;

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
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gabriel = {
    isNormalUser = true;
    description = "Gabriel Chapdelaine";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      #sublime4
      brave
      vivaldi
      meld

    ];
  };

  # Permettre des paquets insecure
  #nixpkgs.config.permittedInsecurePackages = [
               # "openssl-1.1.1w"
            #  ];


  # Install firefox.
  #programs.firefox.enable = true;

  # Allow unfree packages in the system.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget
      vscodium
      zed-editor
      neovim
      btop
      firefox
      #nerdfonts
      fira-code-nerdfont

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
  services.openssh.enable = true;
  services.openssh.openFirewall = true;

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
  system.stateVersion = "24.11"; # Did you read the comment?

  # Configuration de services système

  # Mémoire
  zramSwap.enable = true; # Activer le swap ZRAM
  zramSwap.algorithm = "zstd"; # zstd, lz4, lzo
  zramSwap.priority = 100; # Priorité du swap ZRAM

  # Nettoyage automatique ssd fstrim
  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";

  # Samba
  services.samba = {
      enable = true;
      openFirewall = true;
      nmbd.enable = true;
    };

  #boot.kernel.sysctl = { "vm.swappiness" = 5; } ; # Réduire la fréquence d'utilisation du swap

  nix.settings.auto-optimise-store = true; # Optimiser le magasin Nix
  nix.gc.automatic = true; # Activer la collecte des ordures automatique
  nix.gc.dates = "weekly"; # Planifier la collecte des ordures
  nix.gc.options = "--delete-older-than 15d"; # Supprimer les fichiers plus vieux que 15 jours


  # Configuration de logiciels avancés
  #programs.vim.package = pkgs.vim-full;
  #programs.vim.defaultEditor = true;

  # Exclure les logiciels de GNOME par défaut installés
  #environment.gnome.excludePackages = with pkgs; [
   # gnome-tour
   # gnome.geary
 # ];


  # Disques dur supplémentaires
 fileSystems."/mnt/Disque500" =
     { device = "/dev/disk/by-uuid/6a9ad27c-8250-437a-a680-e8041635c22e";
       fsType = "ext4";
	options = [ "noatime" "defaults" ];
     };

   fileSystems."/mnt/Backup500" =
     { device = "/dev/disk/by-uuid/5fc2f44a-a116-4d8d-a0ab-7873ea3b8c02";
       fsType = "ext4";
	options = [ "noatime" "defaults" ];
     };

   fileSystems."/mnt/Disque250" =
     { device = "/dev/disk/by-uuid/dffc4e34-df94-49e3-89dd-0a38729d3f35";
       fsType = "ext4";
	options = [ "noatime" "defaults" ];
     };

   fileSystems."/mnt/Backup250" =
     { device = "/dev/disk/by-uuid/09b54f39-a100-4bcd-b018-7144535a9fb2";
       fsType = "ext4";
	options = [ "noatime" "defaults" ];
     };

 }
