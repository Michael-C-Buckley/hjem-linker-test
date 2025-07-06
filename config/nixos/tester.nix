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
      # Disable the default greeting and enable Starship
      # Starship's launch will be obvious if the linking worked or not
      ".config/fish/config.fish".text = ''
        set -g fish_greeting

        # Starship
        function starship_transient_prompt_func
            starship module character
        end
        starship init fish | source
        enable_transience
      '';
    };
  };
}
