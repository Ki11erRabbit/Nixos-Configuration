{ config, lib, pkgs, modulesPath, ... }:

{
    imports =
        [ (modulesPath + "/installer/scan/not-detected.nix")
        ];

    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "mpt3sas" "usbhid" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];
  

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

        };
    };


    boot.swraid = {
        enable = true;
        mdadmConf = ''
# mdadm configuration file
#
# mdadm will function properly without the use of a configuration file,
# but this file is useful for keeping track of arrays and member disks.
# In general, a mdadm.conf file is created, and updated, after arrays
# are created. This is the opposite behavior of /etc/raidtab which is
# created prior to array construction.
#
#
# the config file takes two types of lines:
#
#	DEVICE lines specify a list of devices of where to look for
#	  potential member disks
#
#	ARRAY lines specify information about how to identify arrays so
#	  so that they can be activated
#


# You can have more than one device line and use wild cards. The first 
# example includes SCSI the first partition of SCSI disks /dev/sdb,
# /dev/sdc, /dev/sdd, /dev/sdj, /dev/sdk, and /dev/sdl. The second 
# line looks for array slices on IDE disks.
#
#DEVICE /dev/sd[bcdjkl]1
#DEVICE /dev/hda1 /dev/hdb1
#
# The designation "partitions" will scan all partitions found in
# /proc/partitions
DEVICE partitions


# ARRAY lines specify an array to assemble and a method of identification.
# Arrays can currently be identified by using a UUID, superblock minor number,
# or a listing of devices.
#
#	super-minor is usually the minor number of the metadevice
#	UUID is the Universally Unique Identifier for the array
# Each can be obtained using
#
# 	mdadm -D <md>
#
# To capture the UUIDs for all your RAID arrays to this file, run these:
#    to get a list of running arrays:
#    # mdadm -D --scan >>/etc/mdadm.conf
#    to get a list from superblocks:
#    # mdadm -E --scan >>/etc/mdadm.conf
#
#ARRAY /dev/md0 UUID=3aaa0122:29827cfa:5331ad66:ca767371
#ARRAY /dev/md1 super-minor=1
#ARRAY /dev/md2 devices=/dev/hda1,/dev/hdb1
#
# ARRAY lines can also specify a "spare-group" for each array.  mdadm --monitor
# will then move a spare between arrays in a spare-group if one array has a
# failed drive but no spare
#ARRAY /dev/md4 uuid=b23f3c6d:aec43a9f:fd65db85:369432df spare-group=group1
#ARRAY /dev/md5 uuid=19464854:03f71b1b:e0df2edd:246cc977 spare-group=group1
#


# When used in --follow (aka --monitor) mode, mdadm needs a
# mail address and/or a program.  To start mdadm's monitor mode, enable
# mdadm.service in systemd.
#
# If the lines are not found, mdadm will exit quietly
#MAILADDR root@mydomain.tld
#PROGRAM /usr/sbin/handle-mdadm-events

ARRAY /dev/md127 metadata=1.2 name=server-nas:raid6array UUID=79bed5a4:b64e33bb:b7ff9b15:4fd11b87
      '';
  };

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bac1c220-1756-4d1c-9939-d62fdd124ec0";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/2B90-DB18";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/mnt/raid6array" =
    { device = "/dev/disk/by-uuid/3d4efef6-7e54-4a41-ad68-f33a329ebdea";
      fsType = "ext4";
    };

  fileSystems."/mnt/back-up" =
    { device = "/dev/disk/by-uuid/338dd3be-032e-4367-b899-fc9973a46c5c";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/4cc3d5d3-2e76-40d2-ba04-affd041f73d1"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

