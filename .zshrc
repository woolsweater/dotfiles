# The following lines were added by compinstall
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand prefix
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename "${HOME}/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

PROMPT="%K{blue}[%1~]{%h}%k %# "

alias sed=gsed

alias rm='rm -i'

macports_prefix="/opt/local"
export EDITOR=emacs
export PATH="${macports_prefix}/bin:${macports_prefix}/sbin:${PATH}"
export HISTSIZE=10000

autoload -U select-word-style
select-word-style bash

setopt GLOBcomplete

export APPSUPPORT="${HOME}/Library/Application Support"

# Prevent Homebrew from using my personal GitHub credentials. (!)
export HOMEBREW_NO_GITHUB_API=1

# Use default venv for Python
# Prevent overriding prompt (venv prepends the environment name)
VIRTUAL_ENV_DISABLE_PROMPT=1
activate_venv="${HOME}/.venvs/default/bin/activate"
[ -f "${activate_venv}" ] && source "${activate_venv}"

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--bind "alt-m:execute(mate {})+abort,alt-c:execute(pbcopy {})"'
fzf_comps="${macports_prefix}/share/zsh/site-functions/fzf"
[ -f "${fzf_comps}" ] && source "${fzf_comps}"

function mkchdir () {
    # Create a directory and immediately move into it
    mkdir $1
    cd $1
}

function dotfile () {
    # Interact with .dotfiles repo via the command name "dotfile"
    git --git-dir="${HOME}/.dotfiles" --work-tree="${HOME}" $@
}

function edit_script () {
    mate "$(which ${1})"
}

##
# Include config specific to this machine if present.
# Looks adjacent to this file, wherever it is located.
# Performed last to allow overrides if needed.
##
localrc="$(dirname ${(%):-%N})/.zshrc.local"
[ -f "${localrc}" ] && source "${localrc}"
