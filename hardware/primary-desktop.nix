{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/850642b9-8ce6-4efc-9f0c-2d8dff09155d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C9EC-1DD5";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/db576252-950d-4402-a663-a01ef2f1f5ef"; }
    ];


  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/26ef9c7b-4741-4c34-a480-5b4646fa2e95";
      fsType = "ext4";
    };

  #fileSystems."/mnt/LinuxGames" =
    #{ device = "/dev/disk/by-uuid/ad40ff33-9d18-4f1c-b067-9f729fa2d49a";
      #fsType = "ext4";
    #};

  #fileSystems."/mnt/nvme-games" =
  #  { device = "/dev/disk/by-uuid/11fab3e4-94a2-47a3-8127-724b2ed38067";
  #    fsType = "ext4";
  #  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp17s0f2u1u4i5.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp8s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp11s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
}
