# Alias
if [ -f ~/.bash/.bash_aliases ]; then
    . ~/.bash/.bash_aliases
else
    echo "Not found: ~/.bash/.bash_aliases"
fi

# TheFuck
eval $(thefuck --alias)

# Bash completions
## Many brew formalae install completions automatically.
## Other completions can be added via e.g.
## $ argo completion bash > $(brew --prefix)/etc/bash_completion.d/argo
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
else
    echo "Not found: $(brew --prefix)/etc/bash_completion"
fi
complete -C '/usr/local/bin/aws_completer' aws

# Fancy prompt
if [ -f ~/.bash/.bash_prompt ]; then
    . ~/.bash/.bash_prompt
else
    echo "Not found: ~/.bash/.bash_prompt"
fi

# Pyenv is installed through Brew and is already in PATH
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
# Completions are added from the pyenv git repo
export PYENV_CHECKOUT="$HOME/.pyenv/checkout"
source $PYENV_CHECKOUT/completions/pyenv.bash
export PYENV_VIRTUALENV_DISABLE_PROMPT=0

# Poetry (installed through brew)
export PATH="$HOME/.poetry/bin:$PATH"

# IDEs
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Go
export PATH="$PATH:/usr/local/go/bin"

# Work environment
if [ -f ~/.bash/work.env ]; then
    source ~/.bash/work.env
fi

# Python compilation problems
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"

# File handle limit 
ulimit -n 65536 200000

# http://sealiesoftware.com/blog/archive/2017/6/5/Objective-C_and_fork_in_macOS_1013.html
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"

# broot
source /Users/igor/.config/broot/launcher/bash/br

# editors and viewers
export EDITOR=nano
export PAGER="less"
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R '

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
export HSTR_CONFIG=hicolor,prompt-bottom,help-on-opposite-side
export HSTR_PROMPT="history > "
