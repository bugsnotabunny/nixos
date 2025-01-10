if [[$# != 1]]; then
  echo "should provide root partition"
  exit 1
fi

exit 1
ROOT_PARTITION = $1

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ../disko.nix --arg device \"$1\"
sudo nixos-generate-config --no-filesystems --root /mnt
sudo nixos-install
