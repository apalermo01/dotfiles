# refererces:
# https://www.youtube.com/watch?v=ud7YxC33Z3w
# https://scottspence.com/posts/speeding-up-my-zsh-shell 

####################
# Terminal outputs #
####################
echo "******************************** ALIASES *******************************"
echo "* tutoring                  = cd into tutoring dir and init a session  *"
echo "* quick_commit / qc / gcm   = git commit with current date as message  *"
echo "* cat_all                   = cat all files in cwd (recursive)         *"
echo "* on <name>                 = generate new note                        *"
echo "* onp <name>                = generate new personal note               *"
echo "* n                         = cd into notes folder                     *"
echo "* o                         = start obsidian                           *"
echo "* ga                        = git add -p                               *"
echo "* gc                        = git commit                               *"
echo "* gb                        = git branch                               *"
echo "* gd                        = git diff                                 *" 
echo "* gl                        = git log (pretty)                         *"
echo "* gp                        = git push                                 *"
echo "* gpu                       = git pull                                 *"
echo "* j                         = open jupyter lab (if available)          *"
echo "* cat_all                   = cat all files in directory               *"
echo "* switch_kb                 = change kb layout                         *"
echo "************************************************************************"

#######
# Nix #
#######
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

###########
# plugins #
###########

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"


zinit load romkatv/zsh-defer
zsh-defer zinit light zsh-users/zsh-completions
zsh-defer zinit light zsh-users/zsh-autosuggestions
zsh-defer zinit light Aloxaf/fzf-tab
zsh-defer zinit light chisui/zsh-nix-shell 
zsh-defer zinit light zsh-users/zsh-syntax-highlighting

################
# AUTOCOMPLETE #
################
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
    zsh-defer compinit
else
    zsh-defer compinit -C
fi

zinit cdreplay -q

##############
# Functions #
#############

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

function quick_commit() {
    today=$(date "+%Y-%m-%d")
    git add . && git commit -m "$today"
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

journal_entry() {
    bash ~/Scripts/journal_entry.sh
}

bt() { ~/Scripts/bluetooth.sh }

function _maybe_source_aliases() {
    if [[ -f aliases.sh ]]; then
        read -q "?aliases.sh found - would you like to source it? [Y/n]: " src
        if [[ $src =~ ^[Yy]$ ]]; then
            source aliases.sh
        fi
    fi
}


function _devcontainers() {
    if [[ -d .devcontainer ]]; then
        local base=$(basename "$(pwd)")
        local CONTAINER_LABEL_KEY="test-container"
        local CONTAINER_LABEL_VAL="${base}"
        local CONTAINERID="${CONTAINER_LABEL_KEY}=${CONTAINER_LABEL_VAL}"

        echo "Devcontainer found."   
        echo "d   = devcontainer exec --id-label ${CONTAINERID} --workspace-folder . zsh"
        echo "du  = devcontainer up --id-label ${CONTAINERID} --workspace-folder ."
        echo "dur = devcontainer up --id-label ${CONTAINERID} --workspace-folder . --remove-existing-container"
        echo 'dd  = docker rm -f $(docker container ls -f "label='"${CONTAINERID}"'" -q)'

        d() {
          local label="test-container=$(basename "$PWD")"
          devcontainer exec --id-label "$label" \
              --workspace-folder . zsh
        }

        du() {
              local label="test-container=$(basename "$PWD")"
              devcontainer up --id-label "$label" \
                  --workspace-folder .
              # After container is up, clone/apply dotfiles inside it
              devcontainer exec --id-label "$label" --workspace-folder . \
                bash -lc 'set -euo pipefail; \
                  if [ ! -d $HOME/Scripts ]; then mkdir $HOME/Scripts; fi; \
                  DOTPATH="$HOME/Documents/git/dotfiles"; \
                  mkdir -p "$(dirname "$DOTPATH")" "$HOME/.config/ricer" "$HOME/Scripts"; \
                  if [ ! -d "$DOTPATH/.git" ]; then git clone --depth 1 https://github.com/apalermo01/dotfiles "$DOTPATH"; else git -C
"$DOTPATH" pull --ff-only; fi; \
                  sudo apt-get update -y && sudo apt-get install -y stow; \
                  cd "$DOTPATH"; \
                  bash ./scripts/switch_theme.sh wsl_dracula'
            }
        dur() {
              local label="test-container=$(basename "$PWD")"
              echo "replacing devcontainer with label $label"
              devcontainer up --id-label "$label" \
                  --workspace-folder . \
                  --remove-existing-container
              # After container is up, clone/apply dotfiles inside it
              devcontainer exec --id-label "$label" --workspace-folder . \
                bash -lc 'set -euo pipefail; \
                  if [ ! -d $HOME/Scripts ]; then mkdir $HOME/Scripts; fi; \
                  DOTPATH="$HOME/Documents/git/dotfiles"; \
                  mkdir -p "$(dirname "$DOTPATH")" "$HOME/.config/ricer" "$HOME/Scripts"; \
                  if [ ! -d "$DOTPATH/.git" ]; then git clone --depth 1 https://github.com/apalermo01/dotfiles "$DOTPATH"; else git -C
"$DOTPATH" pull --ff-only; fi; \
                  sudo apt-get update -y && sudo apt-get install -y stow; \
                  cd "$DOTPATH"; \
                  bash ./scripts/switch_theme.sh wsl_dracula'
            }
        dd()  { docker rm -f $(docker container ls -f "label=test-container=$(basename "$PWD")" -q); }
    fi
}
function _alias_jupyter() {
    if command -v jupyter; then
        alias j="jupyter lab --allow-root"
        echo "aliased j to jupyter lab"
    fi
}

switch_kb() {
    bash ~/Scripts/switch_kb_layout_via_term.sh
}

mkpretty() { 
    local target_dir="/mnt/c/Users/apalermo/Downloads"

    local files=(${(f)"$(find "$target_dir" -maxdepth 1 -type f -name "*.json" ! -name "pretty_*.json")"})
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No .json files to prettify in $target_dir"
        return 1
    fi
    local i=1
    for file in "${files[@]}"; do
        printf "[%d] %s\n" "$i" "$(basename "$file")"
        ((i++))
    done
    echo -n "Enter the number of the file to prettify: "
    read -r num
    if ! [[ "$num" =~ ^[0-9]+$ ]] || (( num < 1 || num > ${#files[@]} )); then
        echo "Invalid selection. Please enter a number between 1 and ${#files[@]}."
        return 1
    fi
    local selected_file=${files[$num]}

    local base_name

    base_name=$(basename "$selected_file")

    local output_file="${target_dir}/pretty_${base_name}"
    python3 -m json.tool "$selected_file" > "$output_file"
    echo "Done."
}

###########
# General #
###########

export MANPAGER="nvim +Man!"
export EDITOR="nvim"


alias qc="quick_commit"

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


######################
# Obsidian Functions #
######################

export NOTES_PATH="/home/alex/Documents/git/notes/"


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


# git aliases 
# https://www.youtube.com/watch?v=G3NJzFX6XhY

_cond_aliases() {
    if command -v git >/dev/null 2>&1
    then
        alias g='git'
        alias ga='git add -p'
        alias gc='git commit'
        alias gb='git branch'
        alias gd="git diff --output-indicator-new=' ' --output-indicator-old=' '"
        alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
        alias gp='git push'
        alias gpu='git pull'
        alias gcm="git add . && git commit -m $(date +%D)"
    fi

    if command -v yazi >/dev/null 2>&1
    then
        alias lf="y"
        alias l="y"
        alias y="yazi"
        alias ya="y"
        alias yazi="y"
    fi

    if command -v bat >/dev/null 2>&1
    then
        alias cat="bat --no-pager"
    elif command -v batcat >/dev/null 2>&1
    then
        alias cat="batcat --no-pager"
    fi

    if command -v eza >/dev/null 2>&1
    then
        alias ls="eza"
    fi
}

zsh-defer _cond_aliases

if [[ -f "${HOME}/work_cmds.sh" ]]; then
    source ~/work_cmds.sh
fi




############
# cd hooks #
############

zsh-defer autoload -U add-zsh-hook
zsh-defer add-zsh-hook chpwd _maybe_source_aliases
zsh-defer add-zsh-hook chpwd _devcontainers
zsh-defer add-zsh-hook chpwd _alias_jupyter


#######################
# Additional Commands #
#######################

_cmds() {
    if command -v fnm >/dev/null 2>&1; then
        eval "$(fnm env --use-on-cd --shell zsh)"
    fi

    if command -v zoxide >/dev/null 2>&1; then
        eval "$(zoxide init zsh)"
        alias cd="z" 
    fi

    if command -v direnv >/dev/null 2>&1; then
        eval "$(direnv hook zsh)"
    fi

    if command -v z >/dev/null 2>&1; then
        zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
    fi
}

_cmds

alias nu="bash ~/Documents/git/dotfiles/nix-update.sh"
export NOTES_PATH="/mnt/c/Users/apalermo/github/notes"
zinit ice depth=1; zinit light romkatv/powerlevel10k

mkpretty() { 
    local target_dir="/mnt/c/Users/apalermo/Downloads"

    local files=(${(f)"$(find "$target_dir" -maxdepth 1 -type f -name "*.json" ! -name "pretty_*.json")"})
    if [[ ${#files[@]} -eq 0 ]]; then
        echo "No .json files to prettify in $target_dir"
        return 1
    fi
    local i=1
    for file in "${files[@]}"; do
        printf "[%d] %s\n" "$i" "$(basename "$file")"
        ((i++))
    done
    echo -n "Enter the number of the file to prettify: "
    read -r num
    if ! [[ "$num" =~ ^[0-9]+$ ]] || (( num < 1 || num > ${#files[@]} )); then
        echo "Invalid selection. Please enter a number between 1 and ${#files[@]}."
        return 1
    fi
    local selected_file=${files[$num]}

    local base_name

    base_name=$(basename "$selected_file")

    local output_file="${target_dir}/pretty_${base_name}"
    python3 -m json.tool "$selected_file" > "$output_file"
    echo "Done."
}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
if command -v fastfetch >/dev/null 2>&1
then
	fastfetch
fi
