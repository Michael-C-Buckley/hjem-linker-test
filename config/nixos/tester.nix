# User settings for `tester` local system account
{pkgs, ...}: {
  users.users.tester = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    password = "";
    shell = pkgs.fish;
  };

  hjem.users.tester = {
    enable = true;

    files = {
      ".config/fish/config.fish".text = ''
        set -g fish_greeting
        echo "--- Hjem Testing ---"
        alias sd='sudo shutdown now'
      '';
    };
  };
}
