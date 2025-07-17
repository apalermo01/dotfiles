export NOTES_PATH="/mnt/c/Users/apalermo/github/notes"
zinit ice depth=1; zinit light romkatv/powerlevel10k


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
# Set the default language and encoding to UTF-8
export LANG=en_US.UTF-8

# Share the LANG setting with Windows via WSLENV
export WSLENV=$WSLENV:LANG

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
