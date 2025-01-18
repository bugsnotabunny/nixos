if [[$# != 1]]; then
  echo "should provide root partition"
  exit 1
fi

ROOT_PARTITION = $1

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ../disko.nix --arg device \"$1\" &&
sudo cp -r ../ /mnt/etc/nixos &&
sudo nixos-generate-config --no-filesystems --root /mnt &&
sudo nixos-install
