{ rootDevice ? throw "Set this to your disk device, e.g. /dev/sda", devices ? [], ... }: {
  disko.devices = {
    disk = 
      let extraDisksList = builtins.map 
        (dev: { 
          name = builtins.baseNameOf dev;
          value = {
            type = "disk";
            device = dev;
            content = {
              type = "gpt";
              partitions = {
                zfs = {
                  size = "100%";
                  content = {
                    type = "zfs";
                    pool = "zroot";
                  };
                };
              };
            };
          };
        })
        devices;
    in
    {
      root = {
        type = "disk";
        device = rootDevice;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "nofail" ];
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    }       // builtins.listToAttrs extraDisksList;
    
    zpool = {
      zroot = {
        type = "zpool";
        # mode = {
        #   topology = {
        #     type = "topology";
        #     # vdev = [              {                members = builtins.map builtins.baseNameOf devices;              }
        #     ];
        #   };
        # };
        
        rootFsOptions = {
          mountpoint = "none";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          "com.sun:auto-snapshot" = "true";
        };
        options.ashift = "12";
        datasets = {
          "root/nix" = {
            type = "zfs_fs";
            options.mountpoint = "/nix";
            mountpoint = "/nix";
          };

          "root" = {
            type = "zfs_fs";
            options = {
              encryption = "aes-256-gcm";
              keyformat = "passphrase";
              keylocation = "file:///tmp/secret.key";
            };
            mountpoint = "/";

          };
        };
      };
    };
  };
}
