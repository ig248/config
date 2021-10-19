shopt -s expand_aliases

# Color settings
export CLICOLOR=1
# export LSCOLORS='gxfxcxdxbxexexabagacad'

alias ..='cd ..'
alias ...='cd ../..'
alias .....='cd ../../..'
function -- { cd '-'; }
alias cls='clear'
alias cl='clear'
function edit { $EDITOR "$@"; }
function view { $PAGER "$@"; }

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -Ah'
alias lcd='ls -CFh'

alias pyclean="find . | grep -E '(__pycache__|\.pyc|\.pyo$)' | xargs rm -rf"
alias pyenv-reset-clang="rm /Users/igor/.pyenv/shims/clang"

alias watch='watch --color'

# Aliases that respect bash_completion
## git -> g
alias g='git'
___git_complete g __git_main

alias tm='tmux'
complete -F _tmux tm

function ppgrep() { pgrep "$@" | xargs ps -fp 2> /dev/null; }
