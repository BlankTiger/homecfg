{ ... }:

{
  programs.git = {
    enable      = true;
    userName    = "Maciej Urban";
    userEmail   = "maciej.urban@tietoevry.com";
    aliases     = {
      mr = ''!sh -c 'git fetch $1 merge-requests/$2/head:mr-$1-$2 && git checkout mr-$1-$2' -'';
      fetch-all = ''!git fetch origin "*:*" --update-head-ok'';
      pull-all = ''!git pull origin "*:*"'';
      pushfwl = ''push --force-with-lease'';
      pull-branch = ''!sh -c 'echo "Fetching and setting a branch $1 from origin"; git fetch origin $1 && git branch $1 FETCH_HEAD' -'';
    };
    extraConfig = {
      core = {
        autocrlf = "input";
        autocrif = "input";
      };
    };
  };
}
