{ rootDevice ? throw "Set this to your disk device, e.g. /dev/sda", ... }: {
  disko.devices = {
    disk = {
      main = {
        device = rootDevice;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              name = "root";
              end = "-0";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/";
                mountOptions = [ "noatime" "compress=zstd" ];
              };
            };
          };
        };
      };
    };
    nodev = {
      "/tmp" = {
        fsType = "tmpfs";
        # mountOptions = [ "size=4G" ];
      };
    };
  };
}
