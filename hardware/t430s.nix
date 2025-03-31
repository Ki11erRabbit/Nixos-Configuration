{ config, lib, pkgs, modulesPath, ... }:

{

    imports = [ 
        (modulesPath + "/installer/scan/not-detected.nix")
    ];

    networking.hostName = "think-nix-t430s"; # Define your hostname.
    
    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "sdhci_pci" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "uinput" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" =
    { device = "/dev/disk/by-uuid/deb1c166-46d9-46ac-b47b-0e03453bd4f7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/C525-334F";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/cc1b7ccc-c7ef-4959-850a-5b8695bc8f2b"; }
    ];


    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

}
