if [[ -n "$__HM_SESS_VARS_SOURCED" ]]; then
    export __HM_SESS_VARS_SOURCED=1
    export BROWSER="zen"
    export EDITOR="nvim"
    export ENABLE_CORRECTION="true"
    export RUSTC_WRAPPER="sccache"
    export SHELL="zsh"
    export TERMINAL="ghostty"
    export TMUX_TMPDIR="${XDG_RUNTIME_DIR:-"/run/user/$(id -u)"}"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_STATE_HOME="$HOME/.local/state"
    export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"
fi

export ZDOTDIR=$HOME/.config/zsh

ZSH="$HOME/.config/oh-my-zsh";
ZSH_CACHE_DIR="$HOME/.cache/oh-my-zsh";

source $HOME/.cargo/env
source $HOME/.config/keys
export JAVA_HOME="$HOME/.local/bin/android-studio/jbr"
export ANDROID_HOME="$HOME/Android/Sdk"
# export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$HOME/projects/Odin:$ANDROID_HOME/platform-tools:$HOME/.local/bin/android-studio/bin:$HOME/.pyenv/shims:$PATH:$HOME/.config/nvm/versions/node/v22.14.0/bin:$HOME/go/bin"
setopt nocorrectall

WORDCHARS=' *?_-.[]~=&;!#$%^(){}<>/'
autoload -Uz select-word-style
select-word-style normal
zstyle ':zle:*' word-style unspecified
typeset -U path cdpath fpath manpath


source /nix/store/jx9sjhs4lkn6daq1m34aai4igwbnfq34-zsh-autosuggestions-0.7.0/share/zsh-autosuggestions/zsh-autosuggestions.zsh
plugins=(z)
source $ZSH/oh-my-zsh.sh

HISTSIZE="10000"
SAVEHIST="10000"
HISTFILE="$HOME/.zsh_history"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY
setopt autocd

if [[ $TERM != "dumb" ]]; then
  eval "$(starship init zsh)"
fi

# Aliases
alias c='clear'
alias d='cd "$(director)"'
alias de='deactivate'
alias dps='docker ps'
alias em='emacsclient -c'
alias g='git'
alias gap='git add -p'
alias gauto='git autosquash'
alias gc='git checkout '
alias gcm='git checkout master'
alias gco='git commit'
alias gd='git diff '
alias gh='git log --oneline | fzf-tmux -p | xargs echo | cut -d'\'' '\'' -f1 | tr -d '\''
'\'' | xsel -b'
alias gl='git log'
alias glo='git log --oneline'
alias gp='git pull'
alias gs='git status'
alias gst='git stash'
alias gstc='git stash clear'
alias gstp='git stash pop'
alias gwip='git wip'
alias hms='home-manager switch'
alias hmsb='home-manager switch -b backup'
alias hmsbf='rm /home/blanktiger/.mozilla/firefox/blanktiger/search.json.mozlz4.backup; home-manager switch -b backup'
alias idea='sh ~/Downloads/idea-IC-222.4345.14/bin/idea.sh'
alias ldsh='docker exec -it "$(dps --quiet)" sh'
alias lf='sh ~/.local/bin/lfimg'
alias ls='eza'
alias m='mkdir'
alias o='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs -r nvim'
alias rgf='rg --files | rg'
alias rgw='rg -g '\''!*.bin'\'' -T json -i '
alias s='echo '\'',A'\'' | nvim -s -'
alias so='source ~/.config/zsh/.zshrc'
alias sp='sudo pacman'
alias t='tmux'
alias ta='tmux attach'
alias tmux='tmux -u'
alias tn='tmux new-session'
alias v='nvim'
alias va='vim ~/.config/alacritty/alacritty.yml'
alias ve='. ./v/bin/activate'
alias venv='. ./venv/bin/activate'
alias venv311='. ~/venv311/bin/activate'
alias venv38='. ~/venv/bin/activate'
alias vi='nvim'
alias vim='nvim'
alias vimrg='rg --vimgrep'
alias vl='vim ~/.config/lf/lfrc'
alias vpn-finland='sudo openconnect nra-emea-fi-esp-vip.net.nokia.com -c ~/Documents/NOSI/maurban.ipa.nsn-net.net.crt -k ~/Documents/NOSI/maurban.ipa.nsn-net.net.key -u maciej.urban@nokia.com'
alias vpn-germany='sudo openconnect nra-emea-de-muc-vip.net.nokia.com -c ~/Documents/NOSI/maurban.ipa.nsn-net.net.crt -k ~/Documents/NOSI/maurban.ipa.nsn-net.net.key -u maciej.urban@nokia.com'
alias vt='vim ~/.tmux.conf'
alias vv='vim ~/.config/nvim/init.lua'
alias vz='vim ~/.zshrc'

# Named Directory Hashes


source /nix/store/njg3gj876wxw1y28amnyz1bdwjgm2xsc-zsh-syntax-highlighting-0.7.1/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS+=()



git() {
    if [[ $@ == 'push --force'*  ]]; then
        echo "Hey stupid, use --force-with-lease instead (git pushfwl)"
    else
        command git "$@"
    fi
}

# TODO: REMOVE THIS, AFTER COMPLETING hm THERE SHOULD BE NO NEED, CAUSE THIS SHOULD BE ALWAYS AVAILABLE
[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh && source ~/.config/fzf/fzf-git.sh
