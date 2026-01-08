{ pkgs, ... }: {
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.printing.drivers = with pkgs; [
    gutenprint
    gutenprintBin
    hplip
    hplipWithPlugin
    postscript-lexmark
    samsung-unified-linux-driver
    splix
    brlaser
    brgenml1lpr
    brgenml1cupswrapper
    cnijfilter2
    epson-escpr2
    epson-escpr
  ];
}
