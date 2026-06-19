export NOTES_PATH="/mnt/c/Users/apalermo/github/notes"

ZSH_THEME="solarized-powerline"
ZSH_POWERLINE_SHOW_IP=false

export ZSH="$HOME/.oh-my-zsh"
plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

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
