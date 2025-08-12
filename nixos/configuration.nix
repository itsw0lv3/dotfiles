# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, lib, pkgs, ... }:

let
  zen-browser = import (builtins.fetchTarball {
    url = "https://github.com/MarceColl/zen-browser-flake/archive/main.tar.gz";
  }) { system = pkgs.system; };
in

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # ============================================================================
  # BOOT CONFIGURATION
  # ============================================================================

  # Bootloader GRUB
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  # Bootloader systemD (commented out)
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Kernel parameters for AMD RX 6500M stability (commented out)
  # boot.kernelParams = [
  #   "amdgpu.dc=1"     # Enable display core
  #   "amdgpu.psr=0"    # Disable PSR - fixes hangs on mobile GPUs
  # ];

  # ============================================================================
  # HARDWARE CONFIGURATION
  # ============================================================================

  # AMD GPU configuration - Mesa RADV stack (commented out)
  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32Bit = true;
  #   
  #   extraPackages = with pkgs; [
  #     mesa.drivers            # Mesa drivers including RADV for Vulkan
  #     vulkan-loader          # Vulkan ICD loader
  #   ];
  #   
  #   extraPackages32 = with pkgs.pkgsi686Linux; [
  #     mesa.drivers           # 32-bit Mesa drivers
  #     vulkan-loader         # 32-bit Vulkan loader
  #   ];
  # };

  # ============================================================================
  # NETWORK & LOCALIZATION
  # ============================================================================

  networking.hostName = "nixos"; # Define your hostname
  networking.networkmanager.enable = true; # Enable networking

  # Set your time zone
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties
  i18n.defaultLocale = "en_ZA.UTF-8";

  # ============================================================================
  # DISPLAY & DESKTOP ENVIRONMENT
  # ============================================================================

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Manager (GDM only)
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Hyprland window manager
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Hyprland fix for cursors and theming
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "gruvbox-dark-gtk";
        icon-theme = "gruvbox-dark-icons-gtk";
        font-name = "Noto Sans Medium 11";
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Medium 11";
      };
    }
  ];

  # XDG portal configuration
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  # ============================================================================
  # AUDIO CONFIGURATION
  # ============================================================================

  # Enable sound with pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # ============================================================================
  # PRINTING & INPUT
  # ============================================================================

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager)
  # services.xserver.libinput.enable = true;

  # ============================================================================
  # USER CONFIGURATION
  # ============================================================================

  # Define a user account. Don't forget to set a password with 'passwd'
  users.users.w0lv3 = {
    isNormalUser = true;
    description = "w0lv3";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  # Configure default shell
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  system.userActivationScripts.zshrc = "touch .zshrc";

  # ============================================================================
  # PROGRAM CONFIGURATION
  # ============================================================================

  # Firefox browser
  programs.firefox.enable = true;

  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
  };

  # ============================================================================
  # SYSTEM PACKAGES
  # ============================================================================

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    # System utilities
    fzf
    fd
    wget
    curl
    git
    wl-clipboard
    wl-clip-persist

    # Terminal & editors
    kitty
    neovim

    # Wayland/Hyprland specific
    rofi-wayland
    waybar
    dunst
    hypridle
    hyprlock
    hyprpaper
    waytrogen
    wlogout

    # Development tools
    gcc
    nodejs
    typescript
    rustup
    go

    # Applications
    vscodium
    brave
    zen-browser.packages.${pkgs.system}.default

    # Themes & icons
    adwaita-icon-theme
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
  ];

  # Font packages
  fonts.packages = with pkgs; [
    nerd-fonts.noto
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    font-awesome
  ];

  # ============================================================================
  # ENVIRONMENT VARIABLES
  # ============================================================================

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # environment.variables = {
  #   XCURSOR_THEME = "Adwaita";
  #   XCURSOR_SIZE = "24";
  # };

  # ============================================================================
  # SERVICES
  # ============================================================================

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # ============================================================================
  # FIREWALL CONFIGURATION
  # ============================================================================

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # ============================================================================
  # SYSTEM VERSION
  # ============================================================================

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
