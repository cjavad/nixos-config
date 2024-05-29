{ inputs, config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.javad = {
    isNormalUser = true;
    description = "Javad Asgari Shafique";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      discord
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    lunarvim
    nerdfonts
    git
    vscode
    gnomeExtensions.appindicator  
  ];

  # Remove some default gnome packages:
  environment.gnome.excludePackages = [ pkgs.epiphany ];

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
}