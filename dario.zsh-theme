setopt nocorrect

RESET_COLOR="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[blue]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} added"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[white]%} modified"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} deleted"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} renamed"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} unmerged"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} untracked"

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"
 
# Parsing git dirty status slows down my prompt tremendously without adding much value.
# This variant of git_prompt_info just grabs the branch.
function git_current_branch() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# PROMPT='[%{${fg_bold[red]}%}%*%{$reset_color%}][%{${fg_bold[magenta]}%}%~%{$reset_color%}][%{${fg_bold[green]}%}%n@%m%{$reset_color%}]$(git_prompt_info)
# %{${fg_bold[$CARETCOLOR]}%}%%%{${reset_color}%} '


#RPROMPT='${return_status}$(git_prompt_status)%{$reset_color%} $(git_current_branch)$(git_time_since_commit)'
RPROMPT='${return_status}%{$reset_color%} $(git_current_branch)'
PROMPT='[%{${fg_bold[$CARETCOLOR]}%}%!%{${reset_color}%}][%{${fg_bold[red]}%}%*%{$reset_color%}][%{${fg_bold[magenta]}%}%~%{$reset_color%}]%(!.#.) '

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
LSCOLORS='ExGxFxdxCxDxDxcxcxxCxc'
CICOLOR=1

function git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
            now=`date +%s`
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))

            # Sub-hours and sub-minutes
            DAYS=$((seconds_since_last_commit / 86400))
            SUB_HOURS=$((HOURS % 24))
            SUB_MINUTES=$((MINUTES % 60))

            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$MINUTES" -gt 30 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$MINUTES" -gt 10 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi


  			echo -n "$ZSH_THEME_GIT_PROMPT_PREFIX"
            if [ "$HOURS" -gt 24 ]; then
                echo -n "$COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}"
            elif [ "$MINUTES" -gt 60 ]; then
                echo -n "$COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}"
            else
                echo -n "$COLOR${MINUTES}m%{$reset_color%}"
            fi
            echo -n "$ZSH_THEME_GIT_PROMPT_SUFFIX"
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo "($COLOR~|"
        fi
    fi
}
