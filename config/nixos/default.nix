{pkgs, ...}: {
  imports = [
    ./tester.nix
  ];

  system.stateVersion = "25.11";
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    microfetch
    vim
  ];

  users.users.root.password = "";

  security = {
    sudo = {
      extraConfig = "Defaults lecture=never";
      wheelNeedsPassword = false;
    };
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
