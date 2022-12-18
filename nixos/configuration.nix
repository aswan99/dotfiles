
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
in
{
  imports =
    [ # Include the results of the hardware scan.
      <nixos-hardware/common/cpu/amd>
      <nixos-hardware/common/pc/ssd>
      ./hardware-configuration.nix
      <home-manager/nixos>
      ./boot-kernel.nix
      ./bspwm.nix
    ];


  # No access time and continuous TRIM for SSD
  fileSystems."/" = { options = [ "noatime" "nodiratime" "discard" ]; }; 

  # Boot Loader, using boot-kernel.nix
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Asia/Kuala_Lumpur";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  console = {
    font = "Lat2-Terminus16";
      keyMap = "us";
  };

  # We're importing bspwm.nix instead
  # services.xserver.enable = true;


   users.users.maku = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
   };

   environment.systemPackages = with pkgs; [
     vim nano mesa
     wget git util-linux pciutils lshw glxinfo 
     sxhkd
   ];


  # home-manager
  home-manager.users.maku = { pkgs, ...}: {
    # List packages to install in user profile
    home.stateVersion = "22.11";
    home.packages = with pkgs; [ 
      
      # apps
      neovim alacritty btop htop neofetch
      firefox brave
      feh
      stow
    ];

  };


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };

  # system.copySystemConfiguration = true;

  virtualisation.vmware.guest.enable = true;

  system.stateVersion = "22.11"; # Did you read the comment?

}
