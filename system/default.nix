{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./users
    ./locale
    ./nvidia
  ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "JavadDenFemte"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  security.polkit.enable = true;
  programs.light.enable = true; 

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;

  programs.hyprland = { # we use this instead of putting it in systemPackages/users  
    enable = true;  
    xwayland.enable = true;
    # nvidiaPatches = true; # ONLY use this line if you have an nvidia card  
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # This variable fixes electron apps in wayland

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  hardware.opengl = {  
    enable = true;  
    driSupport = true;  
    driSupport32Bit = true;  
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
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

  powerManagement.cpuFreqGovernor = "performance";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Add fonts
  fonts.packages = with pkgs; [
    noto-fonts
    nerdfonts
    material-symbols
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}