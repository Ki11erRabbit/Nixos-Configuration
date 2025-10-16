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
    { device = "/dev/disk/by-uuid/e8cd3501-9eee-4359-9505-05eecc699faa";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3F81-239E";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };


  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a1127347-f062-4ad2-83a2-72068f8633f6";
      fsType = "btrfs";
    };

  #fileSystems."/mnt/LinuxGames" =
    #{ device = "/dev/disk/by-uuid/ad40ff33-9d18-4f1c-b067-9f729fa2d49a";
      #fsType = "ext4";
    #};

  fileSystems."/mnt/nvme-games" =
    { device = "/dev/disk/by-uuid/11fab3e4-94a2-47a3-8127-724b2ed38067";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/8be5c2aa-cca3-4489-83ed-c64081fc3aa1"; }
    ];

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
