ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="mocha" # Required! Options: mocha, flappe, macchiato, latte
CATPPUCCIN_SHOW_TIME=true  # Optional! If set to true, this will add the current time to the prompt.
CATPPUCCIN_SHOW_HOSTNAME="never"  # Optional! Options: never, always, ssh

export ZSH="$HOME/.oh-my-zsh"
plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias nu="bash ~/Documents/git/dotfiles/nix-update.sh"
