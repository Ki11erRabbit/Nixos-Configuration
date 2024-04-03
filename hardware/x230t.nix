{ config, lib, pkgs, modulesPath, ... }:

{

    imports = [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

    networking.hostName = "think-nix-x230t"; # Define your hostname.
    /*nixpkgs.config.nvidia.acceptLicense = true;

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
    };*/
    

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/d09ba537-1887-4e77-a02f-ef7c1f769fcc";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/76C7-881D";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a31e7c35-3980-4d0c-928f-0940878eee1a"; }
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
