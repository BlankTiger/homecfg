{ ... }:
{
  programs.starship = {
    enable = true;
  };

  home.file.".config/starship.toml".text = ''
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$git_metrics\
$shell\
$python\
$character"""

add_newline = false

[git_metrics]
disabled = false

[rust]
format = "[$version](red bold) "

[package]
format = "[$version](208 bold) "

[python]
format = "[$version](blue bold)( \\([$virtualenv](red bold)\\)) "
  '';
}
