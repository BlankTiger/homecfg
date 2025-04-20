# Setup fzf
# ---------
if [[ ! "$PATH" == */home/blanktiger/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/blanktiger/.fzf/bin"
fi

source <(fzf --zsh)
