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
  };
}
