{ ... }:

{
  programs.git = {
    enable      = true;
    userName    = "Maciej Urban";
    userEmail   = "maciej-urban@outlook.com";
    extraConfig = {
      core = {
        autocrlf = "input";
        autocrif = "input";
      };
    };
  };
}
