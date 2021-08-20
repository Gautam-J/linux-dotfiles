# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/gautam/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    colored-man-pages
    web-search
    zsh-syntax-highlighting  # must be the last plugin
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ---------------------------CUSTOM CONFIGURATION------------------------------

# custom function for cp
function ncp () {
    if [ -f "src/${1}.cpp" ]; then
        echo "${1}.cpp file exists!" 1>&2
        return 1
    else
        cp src/template.cpp src/${1}.cpp
        nvim src/${1}.cpp
    fi
}

# enable edit to vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Useful aliases
alias grep='grep --colour=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias ls='ls -lFh --color=auto'
alias ls.='ls -d .*'
alias cp="cp -aiv"
alias cd..='cd ..'
alias mv="mv -iv"
alias rm="rm -riv"
alias mkdir="mkdir -pv"
alias df='df -h'
alias du="du -h"
alias dud="du -d 1"
alias ducd="du -s"
alias free='free -h'
alias fd="find . -type d -name"
alias ff="find . -type f -name"
alias r='ranger'
alias v='nvim'
alias py='python'
alias vpn="sudo protonvpn"
alias editvim="v ~/.config/nvim/init.vim"
alias config='/usr/bin/git --git-dir=/home/gautam/dotfiles/ --work-tree=/'
alias listenvs="conda info --envs"
alias ports='netstat -tulanp'
alias wget='wget -c'
alias -g G='| grep'
alias t='tmux'
alias ta='t a'
alias tk='t kill-server'
alias tns='t new -s'
alias tas='t attach -t'
alias tks='t kill-session -t'
alias tls='t ls'
alias tnw='t neww -n'
alias myip="curl http://ipecho.net/plain; echo"

# Environment variables
export TF_FORCE_GPU_ALLOW_GROWTH=true
export TESSDATA_PREFIX='/home/gautam/Coding/Tesseract'
export RANGER_LOAD_DEFAULT_RC=FALSE
export VISUAL=nvim
export EDITOR=nvim
export SHELL='/bin/zsh'
export TERM=xterm-256color
export FLASK_DEBUG=1

# Add to path
export PATH="$PATH:~/Coding/flutter/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gautam/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gautam/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gautam/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gautam/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
