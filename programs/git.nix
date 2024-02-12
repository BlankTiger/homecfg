{ ... }:

{
  programs.git = {
    enable      = true;
    userName    = "Maciej Urban";
    userEmail   = "maciej.urban@nokia.com";
    aliases     = {
      mr = ''!sh -c 'git fetch $1 merge-requests/$2/head:mr-$1-$2 && git checkout mr-$1-$2' -'';
      fetch-all = ''!sh -c 'git fetch origin "*:*"' -'';
    };
    extraConfig = {
      core = {
        autocrif = "input";
      };
    };
  };
}
