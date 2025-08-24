# references:
# https://www.youtube.com/watch?v=ud7YxC33Z3w
#########
# zinit #
#########

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# global plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# load autocompletions
autoload -U compinit && compinit

zinit cdreplay -q

####################
# Helper Functions #
####################

function start_tutoring() {
    if [[ ! -d "${HOME}/Documents/git/tutoring" ]]; then
        echo "tutoring folder not found"
        return
    fi

    cd "${HOME}/Documents/git/tutoring/"
    ./scripts/tutoring.sh
}

function problems() {
    if [[ ! -d "${HOME}/Documents/git/notes" ]]; then
        echo "notes folder not found"
        return
    fi

    cd "${HOME}/Documents/git/notes/"
    ./problems.sh

}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

###########
# General #
###########

export MANPAGER="nvim +Man!"
export EDITOR="nvim"

function quick_commit() {
    today=$(date "+%Y-%m-%d")
    git add . && git commit -m "$today"
}

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

######################
# Obsidian Functions #
######################

export NOTES_PATH="/home/alex/Documents/git/notes"

new_note() {
    if [[ "$#" -ne 1 ]]; then
        echo "on: generate a new note"
        echo "usage: on name-of-note"
        exit 1 
    fi 

    file_name=$(echo $1 | tr ' ' '-')
    cd $NOTES_PATH
    touch "0-Inbox/$file_name.md"
    nvim "0-Inbox/$file_name.md"
}

new_personal_note() {
    if [[ "$#" -ne 1 ]]; then
        echo "onp: generate a new private note"
        echo "usage: onp name-of-note"
        exit 1 
    fi 

    file_name=$(echo $1 | tr ' ' '-')
    formatted_file_name=priv_$file_name.md
    cd $NOTES_PATH
    touch "0-Inbox/$formatted_file_name"
    nvim "0-Inbox/$formatted_file_name"
}
bt() { ~/Scripts/bluetooth.sh }

###########
# Aliases #
###########

# Obsidian
alias on='new_note'
alias onp='new_personal_note'

# other
alias personal='bash ~/Scripts/personal_docs.sh'
alias reading='bash ~/Scripts/reading_session.sh'
alias notes='cd ~/Documents/git/notes'
alias n='cd ~/Documents/git/notes'
alias o='obsidian'
alias ls='ls --color'

alias vim='nvim'
alias vi='nvim'
alias nivm='nvim'
alias v='nvim'
alias tutoring="start_tutoring"

chi3() {
    cwd=$(pwd)
    cd ${HOME}/Documents/git/dotfiles 
    bash scripts/random_i3_theme.sh
    cd $(cwd)
}
chwsl() {
    cwd=$(pwd)
    cd ${HOME}/Documents/git/dotfiles 
    bash scripts/random_wsl_theme.sh
    cd $(cwd)
}

# git aliases 
# https://www.youtube.com/watch?v=G3NJzFX6XhY
alias g='git'
alias ga='git add -p'
alias gc='git commit'
alias gb='git branch'
alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push'
alias gpu='git pull'
alias gcm="git add . && git commit -m $(date +%D)"
alias nu="bash ~/Documents/git/dotfiles/nix-update.sh"

alias lf="y"
alias l="y"
alias y="yazi"
alias ya="y"
alias yazi="y"

alias cat="batcat --no-pager"
alias ls="eza"
if [[ -f "${HOME}/work_cmds.sh" ]]; then
    source ~/work_cmds.sh
fi

ba () {
    echo "bootstrapping aliases"
    if [ -f aliases.sh ]; then
        echo "aliases.sh found, sourcing..."
        source aliases.sh
    else
        read -q "?aliases.sh not found. Make one? [y/n]: " mk_alias
        if [[ ! $mk_alias =~ ^[Yy]$ ]]; then
            echo "exiting..."
            exit
        fi

        cat <<EOF > aliases.sh
            #!/usr/bin/env bash

            a() {
                echo "Aliases quick reference: "
            }

            # enter any other project-specific alias commands here:
EOF
    fi
}

function _maybe_source_aliases() {
    if [[ -f aliases.sh ]]; then
        read -q "?aliases.sh found - would you like to source it? [Y/n]: " src
        if [[ $src =~ ^[Yy]$ ]]; then
            source aliases.sh
        fi
    fi
}

function cat_all() {

    local -a viewer_cmd

    if command -v bat &>/dev/null; then
        viewer_cmd=("bat" "--paging=never" "--style=plain")
    elif command -v batcat &>/dev/null; then
        viewer_cmd=("batcat" "--paging=never" "--style=plain")
    else
        viewer_cmd=("cat")
    fi
    find . -type f \
        -not -path "./.git/*" \
        -not -path "*/__pycache__/*" \
        -not -path "./.venv/*" \
        -not -path "./venv/*" \
        -not -path "./env/*" \
        -not -path "./build/*" \
        -not -path "./dist/*" \
        -not -path "*.egg-info/*" \
        -not -path "./.pytest_cache/*" \
        -not -path "./.mypy_cache/*" \
        -not -path "./.ruff_cache/*" \
        -not -path "./.idea/*" \
        -not -path "./.vscode/*" \
        -not -name ".env" \
        -not -name "*.pyc" \
        -not -name ".coverage" \
        -not -name ".DS_Store" \
        -not -name "*.db" \
        -not -name "*.sqlite3" \
        -print0 | while IFS= read -r -d '' f; do
        printf '==> %s <==\n' "$f"
        "${viewer_cmd[@]}" -- "$f"
        printf '\n'
    done
        
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _maybe_source_aliases

#######################
# Additional settings #
#######################

eval "$(fnm env --use-on-cd --shell zsh)"


zinit ice depth=1; zinit light romkatv/powerlevel10k




# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fortune | cowsay -r 
wal -n -e -i /home/alex/Pictures/wallpapers/synth.jpg > /dev/null 
alias cd="z"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
