source $HOME/.config/keys

# set -gx TMUX_TMPDIR       $(XDG_RUNTIME_DIR:-"/run/user/$(id -u)")
set -gx BROWSER           "zen"
set -gx EDITOR            "nvim"
set -gx ENABLE_CORRECTION "true"
set -gx RUSTC_WRAPPER     "sccache"
set -gx SHELL             "fish"
set -gx TERMINAL          "ghostty"
set -gx XDG_CACHE_HOME    "$HOME/.cache"
set -gx XDG_CONFIG_HOME   "$HOME/.config"
set -gx XDG_DATA_HOME     "$HOME/.local/share"
set -gx XDG_STATE_HOME    "$HOME/.local/state"
set -gx STARSHIP_CONFIG   "$HOME/.config/starship/config.toml"
set -gx JAVA_HOME         "$HOME/.local/bin/android-studio/jbr"
set -gx ANDROID_HOME      "$HOME/Android/Sdk"
set -gx PATH              "$HOME/.local/bin:$HOME/.bun/bin:$HOME/projects/Odin:$ANDROID_HOME/platform-tools:$HOME/.local/bin/android-studio/bin:$HOME/.pyenv/shims:$PATH:$HOME/.config/nvm/versions/node/v22.14.0/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.local/jai/bin"

alias c       'clear'
alias d       'cd "$(director)"'
alias de      'deactivate'
alias dps     'docker ps'
alias em      'emacsclient -c'
alias g       'git'
alias gap     'git add -p'
alias gauto   'git autosquash'
alias gc      'git checkout '
alias gcm     'git checkout master'
alias gco     'git commit'
alias gd      'git diff '
alias gh      'git log --oneline | fzf-tmux -p | xargs echo | cut -d'\'' '\'' -f1 | tr -d '\''
'\'' | xsel -b'
alias gl      'git log'
alias glo     'git log --oneline'
alias gp      'git pull'
alias gs      'git status'
alias gst     'git stash'
alias gstc    'git stash clear'
alias gstp    'git stash pop'
alias gwip    'git wip'
alias hms     'home-manager switch'
alias hmsb    'home-manager switch -b backup'
alias hmsbf   'rm /home/blanktiger/.mozilla/firefox/blanktiger/search.json.mozlz4.backup; home-manager switch -b backup'
alias idea    'sh ~/Downloads/idea-IC-222.4345.14/bin/idea.sh'
alias ldsh    'docker exec -it "$(dps --quiet)" sh'
alias lf      'sh ~/.local/bin/lfimg'
alias ls      'eza'
alias m       'mkdir'
alias o       'fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs -r nvim'
alias rgf     'rg --files | rg'
alias rgw     'rg -g '\''!*.bin'\'' -T json -i '
alias s       'echo '\'',A'\'' | nvim -s -'
alias so      'source ~/.config/zsh/.zshrc'
alias sp      'sudo pacman'
alias t       'tmux'
alias ta      'tmux attach'
alias tmux    'tmux -u'
alias tn      'tmux new-session'
alias v       'nvim'
alias va      'vim ~/.config/alacritty/alacritty.yml'
alias ve      '. ./v/bin/activate.fish'
alias vi      'nvim'
alias vim     'nvim'
alias vimrg   'rg --vimgrep'
alias vl      'vim ~/.config/lf/lfrc'
alias vt      'vim ~/.tmux.conf'
alias vv      'vim ~/.config/nvim/init.lua'
alias vz      'vim ~/.zshrc'

function fish_greeting
end

fish_default_key_bindings
starship init fish | source

# opencode
fish_add_path /home/blanktiger/.opencode/bin
