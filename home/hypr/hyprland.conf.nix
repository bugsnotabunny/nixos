batteries: ''
    exec-once = wl-clipboard-history -t
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec = swaybg -m fill -i ~/.current-wallpaper.png
    exec-once = waybar
    exec-once = dunst
    exec-once = nm-applet
    exec-once = blueman-applet
    exec-once = hyprctl setcursor $XCURSOR_THEME $XCURSOR_SIZE
  ${if batteries then "exec-once = battery-notify" else ""}

    monitor=,prefered,auto, 1

    input {
      follow_mouse = 1
      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      kb_layout = us,ru
      kb_options = grp:alt_shift_toggle
    }

    general {
      gaps_in = 3
      gaps_out = 5
      border_size = 0
      layout = dwindle
    }

    misc {
      disable_hyprland_logo = true
      disable_splash_rendering = true
      mouse_move_enables_dpms = true
      enable_swallow = true
      swallow_regex = ^(kitty)$
    }

    decoration {
      rounding = 10

      active_opacity = 1.0
      inactive_opacity = 1.0

    }

    animations {
      enabled = true

      bezier = overshot, 0.05, 0.9, 0.1, 1.05
      bezier = smoothOut, 0.36, 0, 0.66, -0.56
      bezier = smoothIn, 0.25, 1, 0.5, 1

      animation = windows, 1, 5, overshot, slide
      animation = windowsOut, 1, 4, smoothOut, slide
      animation = windowsMove, 1, 4, default
      animation = border, 1, 10, default
      animation = fade, 1, 10, smoothIn
      animation = fadeDim, 1, 10, smoothIn
      animation = workspaces, 1, 6, default

    }

    dwindle {
      pseudotile = true
      preserve_split = true
    }

    windowrule = float true, match:title file_progress
    windowrule = float true, match:title confirm
    windowrule = float true, match:title dialog
    windowrule = float true, match:title download
    windowrule = float true, match:title notification
    windowrule = float true, match:title error
    windowrule = float true, match:title splash
    windowrule = float true, match:title confirmreset
    windowrule = float true, match:title Open File
    windowrule = float true, match:title branchdialog
    windowrule = float true, match:title wofi
    windowrule = float true, match:title smile
    windowrule = float true, match:title feh
    windowrule = float true, match:title file-roller
    windowrule = fullscreen true, match:title wlogout
    windowrule = float true, match:title wlogout
    windowrule = float true, match:title ^(Media viewer)$
    windowrule = float true, match:title ^(Volume Control)$
    windowrule = float true, match:title ^(Picture-in-Picture)$
    windowrule = size 800 600, match:title ^(Volume Control)$
    windowrule = move 75 44%, match:title ^(Volume Control)$

    binde=, XF86AudioRaiseVolume, exec, pamixer -i 5
    binde=, XF86AudioLowerVolume, exec, pamixer -d 5
    binde=, XF86AudioMute, exec, pamixer -t
    binde=, XF86MonBrightnessUp, exec, brightnessctl set 5%+
    binde=, XF86MonBrightnessDown, exec, brightnessctl set 5%-
    binde=, XF86AudioPlay, exec, playerctl play-pause
    binde=, XF86AudioPause, exec, playerctl play-pause
    binde=, XF86AudioNext, exec, playerctl next
    binde=, XF86AudioPrev, exec, playerctl previous

    $screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; grimblast --notify copy area; hyprctl keyword animation "fadeOut,1,4,default"
    bind = SUPER SHIFT, S, exec, $screenshotarea
    bind = , Print, exec, grimblast --notify --cursor copy output
    bind = ALT, Print, exec, grimblast --notify --cursor copy screen

    bind = SUPER, T, exec, kitty
    bind = SUPER, B, exec, zen
    bind = SUPER, L, exec, swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color bbffcc --key-hl-color 880033 --line-color 00300000 --inside-color 00000088 --separator-color 00000000 
    bind = SUPER, E, exec, thunar
    bind = SUPER, R, exec, wofi
    bind = SUPER, M, exec, killall smile || smile
    bind = SUPER, escape, exec, wlogout --protocol layer-shell -T 400 -B 400

    bind = SUPER, Q, killactive,
    bind = SUPER, F, fullscreen,
    bind = SUPER, Space, togglefloating,
    bind = SUPER, S, togglesplit, # dwindle

    bind = SUPER, left, movefocus, l
    bind = SUPER, right, movefocus, r
    bind = SUPER, up, movefocus, u
    bind = SUPER, down, movefocus, d

    bind = SUPER SHIFT, left, movewindow, l
    bind = SUPER SHIFT, right, movewindow, r
    bind = SUPER SHIFT, up, movewindow, u
    bind = SUPER SHIFT, down, movewindow, d

    bind = SUPER CTRL, left, resizeactive, -20 0
    bind = SUPER CTRL, right, resizeactive, 20 0
    bind = SUPER CTRL, up, resizeactive, 0 -20
    bind = SUPER CTRL, down, resizeactive, 0 20

    bind = SUPER, 1, workspace, 1
    bind = SUPER, 2, workspace, 2
    bind = SUPER, 3, workspace, 3
    bind = SUPER, 4, workspace, 4
    bind = SUPER, 5, workspace, 5
    bind = SUPER, 6, workspace, 6
    bind = SUPER, 7, workspace, 7
    bind = SUPER, 8, workspace, 8
    bind = SUPER, 9, workspace, 9
    bind = SUPER, 0, workspace, 10
    bind = SUPER ALT, up, workspace, e+1
    bind = SUPER ALT, down, workspace, e-1

    bind = SUPER SHIFT, 1, movetoworkspace, 1
    bind = SUPER SHIFT, 2, movetoworkspace, 2
    bind = SUPER SHIFT, 3, movetoworkspace, 3
    bind = SUPER SHIFT, 4, movetoworkspace, 4
    bind = SUPER SHIFT, 5, movetoworkspace, 5
    bind = SUPER SHIFT, 6, movetoworkspace, 6
    bind = SUPER SHIFT, 7, movetoworkspace, 7
    bind = SUPER SHIFT, 8, movetoworkspace, 8
    bind = SUPER SHIFT, 9, movetoworkspace, 9
    bind = SUPER SHIFT, 0, movetoworkspace, 10

    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow
    bind = SUPER, mouse_down, workspace, e+1
    bind = SUPER, mouse_up, workspace, e-1
''
