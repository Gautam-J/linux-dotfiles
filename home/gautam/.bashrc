#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.fancy-prompt.sh

# Add color output
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

# Useful aliases
alias cp="cp -i"
alias df='df -h'
alias du="du -h"
alias free='free -h'
alias r='ranger'
alias v='nvim'
alias py='python'
alias vpn="sudo protonvpn"
alias editvim="nvim ~/.config/nvim/init.vim"
alias config='/usr/bin/git --git-dir=/home/gautam/dotfiles/ --work-tree=/'
alias listenvs="conda info --envs"

# Environment variables
export TF_FORCE_GPU_ALLOW_GROWTH=true
export TESSDATA_PREFIX='/home/gautam/Coding/Tesseract'
export RANGER_LOAD_DEFAULT_RC=FALSE
export VISUAL=nvim
export EDITOR=nvim
export TERM=xterm-256color
export FLASK_DEBUG=1

# Add to path
export PATH="$PATH:~/Coding/flutter/bin"
export PATH="$PATH:/home/gautam/.config/coc/extensions/coc-clangd-data/install/11.0.0/clangd_11.0.0/bin"

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
