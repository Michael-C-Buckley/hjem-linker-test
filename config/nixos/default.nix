{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hjem.nixosModules.default
    # Test User Settings
    ./users
  ];

  system.stateVersion = "25.11";

  programs.fish = {
    enable = true;
    shellAliases.sd = "sudo shutdown now";
  };

  environment.systemPackages = with pkgs; [
    microfetch
    vim
    starship
  ];

  security.sudo = {
    extraConfig = "Defaults lecture=never";
    wheelNeedsPassword = false;
  };

  services.getty.autologinUser = "root";

  # Use sane nix settings
  nix = {
    package = pkgs.nixVersions.latest;
    settings.experimental-features = ["nix-command" "flakes" "pipe-operators"];
  };
}
