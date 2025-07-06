{pkgs, ...}: let
  defaults = {
    password = "";
    shell = pkgs.fish;
  };
  userSettings = {
    enable = true;
    files.".config/fish/config.fish".source = ./config.fish;
  };
in {
  users.users = {
    root = defaults;
    user = {isNormalUser = true;} // defaults;
  };
  hjem = {
    clobberByDefault = true;
    linker = pkgs.smfh;

    users = {
      root = userSettings;
      user = userSettings;
    };
  };
}
