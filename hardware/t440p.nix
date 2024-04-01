{ config, lib, pkgs, modulesPath, ... }:

{

    imports = [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

    networking.hostName = "think-nix-t440p"; # Define your hostname.
    nixpkgs.config.nvidia.acceptLicense = true;

    specialisation = { 
        nvidia.configuration = { 
            # Nvidia Configuration 
            services.xserver.videoDrivers = [ "nvidia" ]; 
            hardware.opengl.enable = true; 

            # Optionally, you may need to select the appropriate driver version for your specific GPU. 
            hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470; 

            # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway 
            hardware.nvidia.modesetting.enable = true; 

            hardware.nvidia.prime = { 
                sync.enable = true; 

                # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA 
                nvidiaBusId = "PCI:2:0:0"; 

                # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA 
                intelBusId = "PCI:0:2:0"; 
            };
        };
    };
    

    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = { 
        device = "/dev/disk/by-uuid/7ec9785d-7550-4f80-a2bc-ddd592d2dcac";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/730D-AC99";
        fsType = "vfat";
    };

    swapDevices = [ 
        { device = "/dev/disk/by-uuid/cf1a03ed-0b4e-440f-b2f6-5bf7b13594e7"; }
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true;
    # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
