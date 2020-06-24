{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.vim ];
  programs.zsh.enable = true;  # default shell on catalina

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  services = {
    skhd.enable = true;

    yabai = {
      enable = true;
      package = pkgs.yabai;
      enableScriptingAddition = true;

      config = {
        mouse_follows_focus          = "off";
        focus_follows_mouse          = "off";
        window_placement             = "second_child";
        window_topmost               = "off";
        window_border                = "on";
        window_border_width          = 1;
        active_window_border_color   = "0xff00afaf";
        normal_window_border_color   = "0xff505050";
        insert_window_border_color   = "0xffd75f5f";
        split_ratio                  = "0.50";
        mouse_modifier               = "fn";
        mouse_action1                = "move";
        mouse_action2                = "resize";
        layout                       = "bsp";
      };
    };
  };
}
