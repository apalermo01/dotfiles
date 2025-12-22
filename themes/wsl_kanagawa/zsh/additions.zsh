export NOTES_PATH="/mnt/c/Users/apalermo/github/notes"

wal -q -n -e -i ~/Documents/git/dotfiles/wallpapers/kanagawa.jpg

foreground="#dcd7ba"
background="#1f1f28"
cursorColor="#dcd7ba"
    
black="#090618"
grey="#727169"
    
red1="#c34043"
red2="#e82424"
    
green1="#76946a"
green2="#98bb6c"
    
yellow1="#c0a36e"
yellow2="#e6c384"
    
blue1="#7e9cd8"
blue2="#7fb4ca"
    
purple1="#957fb8"
purple2="#938aa9"
    
cyan1="#6a9589"
cyan2="#7aa89f"
    
white1="#c8c093"
white2="#dcd7ba"

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
zstyle ':vcs_info:git:*' actionformats '%b (%a) %m%u%c'
setopt PROMPT_SUBST
homedir="%~"
time_24hr="%*"

st_dt="%F{$yellow1}%K{$background} ${time_24hr} %k%f"
st_dir="%F{$blue2}%K{$background} ${homedir} %k%f"
st_br='%F{$red1}%K{$background} ${vcs_info_msg_0_}%k%f'
str_end="%F{$blue2} %f"

PROMPT="${st_dt}${st_dir}${st_br}${str_end}"
