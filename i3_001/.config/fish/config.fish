if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Path stuff
export PATH="$HOME/.local/share/gem/ruby/3.0.0/gems/jekyll-4.3.3/exe:$PATH"
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
export PATH="/opt/Discord:$PATH"

############
# Obsidian #
###########
# https://www.youtube.com/watch?v=1Lmyh0YRH-w
set -gx NOTES_PATH "/home/alex/Documents/git/notes/"

function ont -d "Create a new note for PKM system in technncial folder"
    if test (count $argv) -gt 1
        echo "Too many arguments. Wrap file name in quotes"
        return
    else if test $argv[1]
        set file_name (echo $argv[1] | tr ' ' '-')
        set formatted_file_name (date "+%Y-%m-%d")_$file_name.md
        cd $NOTES_PATH
        touch "0-notes/0-notes/0-inbox/$formatted_file_name"
        nvim "0-notes/0-notes/0-inbox/$formatted_file_name"
        echo "file name: " $file_name
    else
        echo "Expected an argument!"
        return
    end
end

function onp -d "Create a new note for PKM system in non-technical folder"
    if test (count $argv) -gt 1
        echo "Too many arguments. Wrap file name in quotes"
        return
    else if test $argv[1]
        set file_name (echo $argv[1] | tr ' ' '-')
        set formatted_file_name (date "+%Y-%m-%d")_$file_name.md
        cd $NOTES_PATH
        touch "0-notes/1-private/0-inbox/$formatted_file_name"
        nvim "0-notes/1-private/0-inbox/$formatted_file_name"
        echo "file name: " $file_name
    else
        echo "Expected an argument!"
        return
    end
end

function og -d "Move notes based on tags" 
    set VAULTS 0-notes 1-private

    for VAULT_NAME in $VAULTS
        find "$NOTES_PATH/0-notes/$VAULT_NAME/5-zettelkasten/" -type f -name '*.md' -not -path "*tags*"| while read -l file;
            set tag (awk -F': ' '/^type:/{print $2; exit}' "$file" | sed -e 's/^ *//;s/ *$//')
            if [ ! -z "$tag" ]
                #set TARGET_DIR "$NOTES_PATH/2-notes/$VAULT_NAME/$tag" 
                set TARGET_DIR "$NOTES_PATH/0-notes/$VAULT_NAME/5-zettelkasten/$tag"
                
                if [ $file != "$TARGET_DIR/(path basename $file)" ]
                    echo "Processing (path basename $file)"
                    echo "Found tag $tag"
                    mkdir -p $TARGET_DIR
                    mv $file "$TARGET_DIR/" 
                    echo "Moved $file to $TARGET_DIR"
                end
            else 
                echo "No type tag found for (path basename $file)"
            end
        end
    end

    echo "vault restructure complete"
end

function gcm
    set today (date "+%Y-%m-%d")
    git add . && git commit -m "$today"
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/alex/.ghcup/bin # ghcup-env
set -gx MANPAGER "nvim +Man!"

abbr --add personal bash ~/personal_docs.sh
abbr --add reading bash ~/reading_session.sh
abbr --add notes cd ~/Documents/git/notes/
abbr --add zen /usr/local/bin/zen/zen
abbr --add a . env/bin/activate.fish
abbr --add o ~/appimages/Obsidian-1.7.7.AppImage
fastfetch
wal -n -e -i /home/alex/Pictures/wallpapers/001.png > /dev/null 