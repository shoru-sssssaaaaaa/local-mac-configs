GIT_PS1_SHOWDIRTYSTATE=true

PROMPT_COMMAND=__prompt_command
__prompt_command() {
	local status=$?
	local reset='\e[m' red='\e[31m' blue='\e[34m'
	local -A err_code=(
		[1]=error [2]='builtin error' [126]='not executable' [127]='command not found'
		[128]=SIGHUP [129]=SIGINT [130]=SIGQUIT [131]=SIGILL [132]=SIGTRAP
		[133]=SIGABRT [134]=SIGEMT [135]=SIGFPE [136]=SIGKILL [137]=SIGBUS
		[138]=SIGSEGV [139]=SIGSYS [140]=SIGPIPE [141]=SIGALRM [142]=SIGTERM
		[143]=SIGURG [144]=SIGSTOP [145]=SIGTSTP [146]=SIGCONT [147]=SIGCHLD
		[148]=SIGTTIN [149]=SIGTTOU [150]=SIGIO [151]=SIGXCPU [152]=SIGXFSZ
		[153]=SIGVTALRM [154]=SIGPROF [155]=SIGWINCH [156]=SIGINFO [157]=SIGUSR1
		[158]=SIGUSR2
	)
	PS1="\[\033]0;$HOST\007\]"     # set window title
	PS1="$PS1"'\[\033[32m\]'       # change color
	PS1="$PS1"'\u@Air'             # user@host<space>
	PS1="$PS1"'\[\033[33m\]'       # change color
	PS1="$PS1"'\w'                 # current working directory
	PS1="$PS1"'\[$reset\]'

	alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"

	if test -z "$WINELOADERNOEXEC"
	then
  		PS1="$PS1"'\[\033[36m\]'
   	 	PS1="$PS1"'$(__git_ps1)'   # bash function
	fi

	if [[ $status -eq 0 ]]
	then
		PS1+="\[$reset\]?🙂"
	else
		PS1+="? \[$red\]$status(${err_code[$status]})\[$reset\]😵"
	fi
	PS1+='\n\$ '
}

alias ls='ls -FG'
alias ll='ls -alFG'

# PATH
export PATH=$PATH:/opt/homebrew/bin

# Alias
alias k=kubectl
