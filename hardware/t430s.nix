{ config, lib, pkgs, modulesPath, ... }:

{

    imports = [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

    networking.hostName = "think-nix-t430s"; # Define your hostname.
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
    

}
