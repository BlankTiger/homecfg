{ ... }:

{
  programs.git = {
    enable      = true;
    userName    = "Maciej Urban";
    userEmail   = "maciej.urban@nokia.com";
    extraConfig = {
      core = {
        autocrif = "input";
      };
    };
  };
}
