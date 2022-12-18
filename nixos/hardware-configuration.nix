# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];

  boot.initrd.availableKernelModules = [ "ata_piix" "mptspi" "uhci_hcd" "ehci_pci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # use latest xanmod kernel, use boot-kernel.nix
  #boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/acd1ddc1-8c95-48fe-8462-cc4d2b8aa544";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B0C0-E27B";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens33.useDHCP = lib.mkDefault true;
  # networking.interfaces.ens34.useDHCP = lib.mkDefault true;

  # enable zramswap
  zramSwap.enable = true;
  zramSwap.memoryPercent = 100;

  powerManagement.cpuFreqGovernor = "conservative";

  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
