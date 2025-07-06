{pkgs, ...}: {
  system.stateVersion = "25.11";
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    microfetch
    vim
  ];

  users.users = {
    tester = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      password = "";
    };
    root.password = "";
  };

  # Use sane nix settings
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      warn-dirty = false;
      experimental-features = ["nix-command" "flakes" "pipe-operators"];
    };
  };
}
