{ pkgs, ... }: {
  home.username = "devric";
  home.homeDirectory = "/Users/devric";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.sl
  ];

  programs.git = {
    enable = true;
    includes = [{ path = "./gitconfig"; }];
  };
}

