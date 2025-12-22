# export NOTES_PATH="/mnt/c/Users/apalermo/github/notes"
# zinit ice depth=1; zinit light romkatv/powerlevel10k
#
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

thm_bg="#282c34"
thm_fd="#abb2bf"
thm_red="#e06c75"
thm_orange="#d19a66"
thm_yellow="#e5c07b"
thm_green="#98c379"
thm_cyan="#56b6c2"


autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
homedir="%~"
time_24hr="%*"

st_dt="%F{$thm_yellow}%K{$thm_bg} ${time_24hr} %k%f"
st_dir="%F{$thm_cyan}%K{$thm_bg} ${homedir} %k%f"
st_br="%F{$thm_red}%K{$thm_bg} ${vcs_info_msg_0_}%k%f"
str_end="%F{$thm_cyan} %f"

PROMPT="${st_dt}${st_dir}${st_br}${str_end}"
