# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.git-prompt.sh

# Unlimited history
export HISTSIZE=-1
export HISTFILESIZE=-1

# Aliases
alias ls="exa --git"
alias man=batman
alias cat=bat
alias venv='source $HOME/Documents/scripts/various/venv'

# PhD
alias deadlines='python /home/ginko/phd/scripts/deadlines.py'
alias info='/home/ginko/phd/scripts/./info'
alias sent='/home/ginko/phd/scripts/./done'

# Variables
export TERM=xterm-256color
export GOPATH="$HOME/dev/go"
export GOBIN="$GOPATH/bin"
export EDITOR='vim' 
export VISUAL='vim'
export OPENER='xdg-open'
export BROWSER='firefox'
export GTK_THEME='Breeze:dark'
export TERMINAL='alacritty'
export VIRTUAL_ENV_DISABLE_PROMPT=1
export TESSDATA_PREFIX=/usr/local/share/tessdata/
export PATH="$HOME/.local/bin/":$GOBIN:$PATH
export JULIA_NUM_THREADS=4
export PYTHONPATH=$PYTHONPATH:/home/ginko/ens/src/lfads/



# Functions
virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=""
    fi
	echo $venv
}


colorize() {
	effect=''
	space=''
	if [[ $@ == *space* ]]; then
		space=' '
	fi
	if [[ $@ == *bold* ]]; then
		effect=01;
	fi
	esc='\[\033'
	white='[0m\]'
	color="[$effect;38;5;$1m\]"
	word="$2"
	if [[ $word == space ]]; then 
		word=''
		space=''
	fi
	echo "$esc$color$word$esc$white$space"
}

formatColor(){ 
    echo $1 | sed -e 's/\///g' -e 's/^/#/'; 
}

# checkdir(){
# 	case $1 in
# 		/home/ginko/ens)
# 			source $HOME/.virtualenvs/ens/bin/activate
# 		;;
# 	esac
# }


# Colors

# put_template explained:
# \033]4; is the command to set an ansi color number to a string (man console_codes
# %d;rgb:%s takes the ansi colore codes and the color string and replace the first with the second
# \033\\ escapes

put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; } 

base00="28/28/28" # ----
base01="3c/38/36" # ---
base02="50/49/45" # --
base03="66/5c/54" # -
base04="bd/ae/93" # +
base05="d5/c4/a1" # ++
base06="eb/db/b2" # +++
base07="fb/f1/c7" # ++++
base08="fb/49/34" # red
base09="fe/80/19" # orange
base0A="fa/bd/2f" # yellow
base0B="b8/bb/26" # green
base0C="8e/c0/7c" # aqua/cyan
base0D="83/a5/98" # blue
base0E="d3/86/9b" # purple
base0F="d6/5d/0e" # brown

# 16 color space
put_template 0  $base00 # ----
put_template 1  $base08 # red
put_template 2  $base0B # green
put_template 3  $base0A # yellow
put_template 4  $base0D # blue
put_template 5  $base0E # purple
put_template 6  $base0C # aqua
put_template 7  $base05 # ++
put_template 8  $base06 # +++
put_template 9  $base09 # orange
put_template 10 $base0B # green
put_template 11 $base0A # yellow
put_template 12 $base0D # blue
put_template 13 $base04 # +
put_template 14 $base0C # aqua
put_template 15 $base07 # ++++

set_ps1(){
	# checkdir $(pwd)
	venv="$(virtualenv_info)" 
	host="$(hostname)"
	branch="$(__git_ps1)"
	dir='\W'
	prompt=''

	ps_dir=$(colorize 4 $dir bold)
	ps_host=$(colorize 7 "$host" space bold)
	ps_branch=$(colorize 3 "$branch" bold)
	ps_venv=$(colorize 5 $venv space bold)
	ps_prompt=$(colorize 9 $prompt space)

	PS1="\n$ps_host$ps_branch\n$ps_dir\n$ps_venv$ps_prompt"

}
PROMPT_COMMAND=set_ps1
