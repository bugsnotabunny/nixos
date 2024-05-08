{
	programs.waybar = {
		enable = true;
		style = ./style.css;
		settings = {
		    layer = "top";
		    position = "top";
		    mod = "dock";
		    exclusive = true;
		    passthrough = false;
		    gtk-layer-shell = true;
		    height = 0;
		    modulesleft = [ "hyprland/workspaces" "hyprland/window" ];
				modules-center = [];
		    modules-right = [
		        "tray"
		        "cpu"
		        "memory"
		        "temperature"
		        "battery"
		        "network"
		        "hyprland/language"
		        "backlight"
		        "pulseaudio"
		        "pulseaudio#microphone"
		        "clock"
		    ];
		    "hyprland/window" = {
		        format = "{}";
		    };
		    "hyprland/language" = {
		        format = "{}";
		        format-en = "🇬🇧";
		        format-ru = "🇷🇺";
		    };
		    "wlr/workspaces" = {
		        disable-scroll = true;
		        all-outputs = true;
		        sort-by-number = true;
		        on-click = "activate";
		        format = "{icon}";
		    };
		    "tray" = {
		        icon-size = 13;
		        spacing = 10;
		    };
		    "clock" = {
		        format = "{:%R   %d/%m }";
		        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
		    };
		    "backlight" = {
		        device = "intel_backlight";
		        format = "{percent}% {icon}";
		        format-icons = ["󱩎" "󱩑" "󰛨"];
		        on-scroll-up = "brightnessctl set 5%+";
		        on-scroll-down = "brightnessctl set 5%-";
		        min-length = 6;
		    };
		    "battery" = {
		        format = "{capacity}%  ";
		    };
		    "pulseaudio" = {
		        format = "{volume}% {icon}";
		        tooltip = false;
		        format-muted = "Muted ";
		        on-click = "pamixer -t";
		        on-scroll-up = "pamixer -i 5";
		        on-scroll-down = "pamixer -d 5";
		        scroll-step = 5;
		        format-icons = {
		            headphone = "";
		            hands-free = "";
		            headset = "";
		            phone = "";
		            portable = "";
		            car = "";
		            default = ["" "" ""];
		        };
		    };
		    "pulseaudio#microphone" = {
		        format = "{format_source}";
		        format-source = "{volume}% ";
		        format-source-muted = "Muted ";
		        on-click = "pamixer --default-source -t";
		        on-scroll-up = "pamixer --default-source -i 5";
		        on-scroll-down = "pamixer --default-source -d 5";
		        scroll-step = 5;
		    };
		    "cpu" = {
		        format = "{usage}% 󰻠";
		        interval = 1;
		    };
		    "memory" = {
		        format = "{percentage}%    {swapPercentage}% 󰾴";
		        interval = 1;
		    };
		    "temperature" = {
		        format = "{temperatureC}°C ";
		        interval = 1;
		    };
		    "network" = {
		        interface = "wlp0s20f3";
		        format = "{ifname}";
		        format-wifi = "{bandwidthUpBits} {bandwidthDownBits} {signalStrength}% ";
		        format-ethernet = "{bandwidthUpBits} {bandwidthDownBits} ";
		        format-disconnected = "";
		        interval = 1;
		        min-length = 30;
		        max-length = 30;
		    };
		};
	};
}
