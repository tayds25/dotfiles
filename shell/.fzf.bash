# Setup fzf
# ---------
if [[ ! "$PATH" == */home/tayshaunds/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/tayshaunds/.fzf/bin"
fi

eval "$(fzf --bash)"
