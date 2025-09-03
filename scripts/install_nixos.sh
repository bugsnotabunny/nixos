if [[$# != 1]]; then
  echo "should provide root partition"
  exit 1
fi

# no worky

ROOT_PARTITION = $1

dd if=/dev/random of=/tmp/secret.key bs=32 count=1 &&
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- \
    --mode destroy,format,mount disko/disko.nix \
    --arg rootDevice \"/dev/sdb\" \
    --arg storageDevices \[\"/dev/sda\"\ \"/dev/nvme0n1\"\] &&
sudo nixos-generate-config --no-filesystems &&
cp /etc/nixos/hardware-configuration.nix  ./system/ &&
sudo nixos-install --flake path:.#nixos
