{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hjem.nixosModules.default
    # Test User Settings
    ./tester.nix
  ];

  system.stateVersion = "25.11";
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    microfetch
    vim
  ];

  users.users.root.password = "";

  security.sudo = {
    extraConfig = "Defaults lecture=never";
    wheelNeedsPassword = false;
  };

  services.getty.autologinUser = "tester";

  # Use sane nix settings
  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = ["nix-command" "flakes" "pipe-operators"];
  };

  hjem = {
    clobberByDefault = true;
    #linker = "";
  };
}
