{ pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;
  #xdg.portal.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable the bspwm
  services.xserver = {
    windowManager = {
      bspwm.enable = true;
    };
    desktopManager.xterm.enable = false;
    displayManager = {
      #setup monitor display
      setupCommands = ''
        my_pc=$(${pkgs.xorg.xrandr}/bin/xrandr --query | grep 'Virtual-1 connected')
        if [[ $my_pc = *connected* ]]; then     
          ${pkgs.xorg.xrandr}/bin/xrandr --output Virtual-1 --mode 1278x904 --rate 60
        fi
        ''; 
     
      lightdm.enable = true;
      lightdm.greeter.enable = true;      
      #lightdm.extraConfig = "logind-check-graphical=true";
      defaultSession = "none+bspwm";

    };
  };


}
