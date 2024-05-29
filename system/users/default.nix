{ inputs, config, pkgs, lib, ... }:

{
  # All users need zsh
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
   defaultUserShell = pkgs.zsh;
   
   users = {
      javad = {
        isNormalUser = true;
        description = "Javad Asgari Shafique";
        extraGroups = [ "networkmanager" "wheel" ];
        useDefaultShell = true;
      };
    };
  };
}