# Alias
if [ -f ~/.bash/.bash_aliases ]; then
    . ~/.bash/.bash_aliases
else
    echo "Not found: ~/.bash/.bash_aliases"
fi
# Functions
if [ -f ~/.bash/.bash_functions ]; then
    . ~/.bash/.bash_functions
else
    echo "Not found: ~/.bash/.bash_functions"
fi
# Fancy prompt
if [ -f ~/.bash/.bash_prompt ]; then
    . ~/.bash/.bash_prompt
else
    echo "Not found: ~/.bash/.bash_prompt"
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

# Pyenv is installed through Brew and is already in PATH
# if command -v pyenv 1>/dev/null 2>&1; then
    # eval "$(pyenv init -)"
# fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Completions are added from the pyenv git repo
export PYENV_CHECKOUT="$HOME/.pyenv/checkout"
source $PYENV_CHECKOUT/completions/pyenv.bash
export PYENV_VIRTUALENV_DISABLE_PROMPT=0

# GNU
export PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix)/opt/grep/libexec/gnuman:$(brew --prefix)/opt/coreutils/libexec/gnuman:$MANPATH"

# Poetry (installed through brew)
export PATH="$HOME/.poetry/bin:$PATH"

# IDEs
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Go
export PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# Rust
source $HOME/.cargo/env

# Ruby
export PATH="/Users/igor/.gem/ruby/3.0.0/bin:/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
eval "$(rbenv init - bash)"

# Other personal scripts
export PATH="$PATH:$HOME/bin"

# editors and viewers
export EDITOR=micro
export PAGER="bat -n"
export MANPAGER="less"
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS='-R'
function man {  # run man with colors
    LESS_TERMCAP_md=$'\e[1;32m' \
    LESS_TERMCAP_mb=$'\e[1;32m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;4;31m' \
    /usr/bin/man "$@"
}

# History settings
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
# Run original PROMPT_COMMAND first as that uses exit code from the previous command
# export PROMPT_COMMAND="$PROMPT_COMMAND; history -a; history -c; history -r;"

# Fuzzy finding with fzf
# trigger sequence by default set to **
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --info inline --bind "alt-down:preview-page-down,alt-up:preview-page-up"'
export FZF_COMPLETION_TRIGGER='§'
# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd|tree)      fzf "$@" --preview 'tree -C {}' ;;
    ls|la|ll)     fzf "$@" --preview 'gls -lah --color=always {}' ;;  # from coreutils
    source|python|cat|bat|nano|code|nvim) fzf "$@" -m --preview 'bat --color=always -pp {}' ;;
    g|git)        fzf "$@" -m --preview 'git diff --color {}' ;;
    set|printenv|export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh)          fzf "$@" --preview 'ssh {} "uname -n; uname -sr; uname -v; uname -mp; echo \$(nproc) CPUs; nvidia-smi"' ;;
    alias)        fzf "$@" --preview 'type {}' ;;
    *)            fzf "$@" ;;
  esac
}

# Forgit
export FORGIT_FZF_DEFAULT_OPTS="--height 100%"
[ -f ~/.forgit/forgit.plugin.zsh ] && source ~/.forgit/forgit.plugin.zsh

# Python compilation problems
export LDFLAGS="-L/usr/local/opt/openssl/lib"
# "-L/usr/local/opt/openblas/lib -L/usr/local/opt/lapack/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
# -I/usr/local/opt/openblas/include -I/usr/local/opt/lapack/include"

# File handle limit 
# launchctl limit maxfiles 65536 200000
ulimit -n 65536 200000

# http://sealiesoftware.com/blog/archive/2017/6/5/Objective-C_and_fork_in_macOS_1013.html
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"

# iterm2 Status Bar - support custom extpressions/variables
function iterm2_print_user_vars() {
  iterm2_set_user_var pyenv_version_name "$(pyenv version-name)";
  iterm2_set_user_var python_version "$(python --version)";
}
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash" || true

# Work environment
if [ -f ~/.bash/work.env ]; then
    source ~/.bash/work.env
fi

# Android Debug Bridge
export PATH="${HOME}/adb-platform-tools:$PATH"
