export NOTES_PATH="/mnt/c/Users/apalermo/github/notes"
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set the default language and encoding to UTF-8
export LANG=en_US.UTF-8

# Share the LANG setting with Windows via WSLENV
export WSLENV=$WSLENV:LANG
