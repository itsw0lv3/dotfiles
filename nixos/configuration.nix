# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable flakes support (but not using them in this config)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel parameters for AMD RX 6500M stability
  boot.kernelParams = [
    "amdgpu.dc=1"     # Enable display core
    "amdgpu.psr=0"    # Disable PSR - fixes hangs on mobile GPUs
  ];

  networking.hostName = "nixos-laptop"; # Define your hostname
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "America/New_York"; # Change to your timezone

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  # AMD GPU configuration - Mesa RADV stack
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    
    extraPackages = with pkgs; [
      mesa.drivers            # Mesa drivers including RADV for Vulkan
      vulkan-loader          # Vulkan ICD loader
    ];
    
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa.drivers           # 32-bit Mesa drivers
      vulkan-loader         # 32-bit Vulkan loader
    ];
  };

  # Cursor theme environment variables
  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # Enable Hyprland and UWSM
  programs.hyprland.enable = true;
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };

  # Display manager configuration
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };
  
  # Make UWSM session available in display manager
  services.displayManager.sessionPackages = [ pkgs.uwsm ];

  # Disable gvfs to prevent system hangs (as mentioned earlier)
  services.gvfs.enable = false;

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account
  users.users.w0lv3 = { # Change this to your username
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # User-specific packages
      firefox
      tree
    ];
  };

  # Allow unfree packages (for things like Discord, Steam, etc.)
  nixpkgs.config.allowUnfree = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # Essential tools
    neovim
    wget
    curl
    git
    btop
    
    # Hyprland related
    waybar          # Status bar
    rofi-waylanf            # Application launcher
    wl-clipboard    # Clipboard utilities
    wl-clip-persist
    grim            # Screenshot tool
    slurp           # Screen selection tool
    
    # Terminal
    kitty           # Or alacritty, your choice
    
    # GNOME themes for Adwaita cursors
    adwaita-icon-theme
    gnome.gnome-themes-extra
    
    # Graphics tools for testing
    vulkan-tools    # vulkaninfo command
    clinfo          # OpenCL info
  ];

  # Enable the OpenSSH daemon (optional)
  # services.openssh.enable = true;

  # Firewall configuration
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ ... ];
    # allowedUDPPorts = [ ... ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.05"; # Did you read the comment?
}
