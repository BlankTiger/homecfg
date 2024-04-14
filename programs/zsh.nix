{ ... }: 

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "z" "vi-mode" ];
    };

    initExtra = ''
      source $HOME/.cargo/env
      source $HOME/.config/keys
      export PATH="/home/blanktiger/.pyenv/shims:$PATH:/home/blanktiger/.local/bin:/home/blanktiger/.nvm/versions/node/v19.9.0/bin:/home/blanktiger/.android/sdk/platform-tools"
      export NDK_HOME="/home/blanktiger/.android/sdk/ndk/26.2.11394342"
      export JAVA_HOME="/home/blanktiger/.local/bin/android-studio/jbr"
      export ANDROID_HOME="/home/blanktiger/.android/sdk"

      git() {
        if [[ $@ == 'push --force'*  ]]; then
          echo "Hey stupid, use --force-with-lease instead (git pushfwl)"
        else
          command git "$@"
        fi
      }
    '';

    shellAliases = {
      venv = ". ./venv/bin/activate";
      ve = ". ./v/bin/activate";
      de = "deactivate";
      hms = "home-manager switch";
      tmux = "tmux -u";
      ls = "eza";
      f = "sk";
      s = "source ~/.config/zsh/.zshrc";
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      c = "clear";
      vz = "vim ~/.zshrc";
      va = "vim ~/.config/alacritty/alacritty.yml";
      vv = "vim ~/.config/nvim/init.lua";
      vl = "vim ~/.config/lf/lfrc";
      vt = "vim ~/.tmux.conf";
      t = "tmux";
      ta = "tmux attach";
      tn = "tmux new-session";
      lf = "sh ~/.local/bin/lfimg";
      em = "emacsclient -c";
      rgf = "rg --files | rg";
      rgw = "rg -g '!*.bin' -T json -i ";

      # git
      g = "git";
      gp = "git pull";
      gs = "git status";
      gst = "git stash";
      gstc = "git stash clear";
      gstp = "git stash pop";
      gl = "git log";
      glo = "git log --oneline";
      gh = "git log --oneline | fzf-tmux -p | xargs echo | cut -d' ' -f1 | tr -d '\n' | xsel -b";
      gd = "git diff ";
      gc = "git checkout ";
      gcm = "git checkout master";
      gco = "git commit";
      gap = "git add -p";

      # other
      dps = "docker ps";
      ldsh = "docker exec -it \"$(dps --quiet)\" sh";
      venv38 = ". ~/venv/bin/activate";
      venv311 = ". ~/venv311/bin/activate";
      vimrg = "rg --vimgrep";
      o = "fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs -r nvim";
      d = "cd \"$(director)\"";
      m = "mkdir";

      # idea.sh
      idea = "sh ~/Downloads/idea-IC-222.4345.14/bin/idea.sh";

      # vpn
      vpn-finland = "sudo openconnect nra-emea-fi-esp-vip.net.nokia.com -c ~/Documents/NOSI/maurban.ipa.nsn-net.net.crt -k ~/Documents/NOSI/maurban.ipa.nsn-net.net.key -u maciej.urban@nokia.com";
      vpn-germany = "sudo openconnect nra-emea-de-muc-vip.net.nokia.com -c ~/Documents/NOSI/maurban.ipa.nsn-net.net.crt -k ~/Documents/NOSI/maurban.ipa.nsn-net.net.key -u maciej.urban@nokia.com";
    };

    sessionVariables = {
      EDITOR = "nvim";
      RUSTC_WRAPPER = "sccache";
      ENABLE_CORRECTION = "true";
      TERMINAL = "kitty";
      BROWSER = "firefox";
    };
  };
}
