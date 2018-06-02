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

export EDITOR=/usr/bin/emacs

autoload -U select-word-style
select-word-style bash

setopt GLOBcomplete

export APPSUPPORT="${HOME}/Library/Application Support"
export DERIVEDDATA="${HOME}/Library/Developer/Xcode/DerivedData"

# Prevent Homebrew from using my personal GitHub credentials. (!)
export HOMEBREW_NO_GITHUB_API=1

function mkchdir () {
    # Create a directory and immediately move into it
    mkdir $1
    cd $1
}

function findn () {
    # Find files shortcut
    find . -name "$1"
}

function findmate () {
    # Find files and open them in TextMate
    find . -name "$1" -exec mate "{}" \;
}
# Allow strings that contain glob chars to be passed directly to find before
# expanding https://stackoverflow.com/a/22945024/603977
alias find='noglob find'
alias findmate='noglob findmate'

function dotfile () {
    # Interact with .dotfiles repo via the command name "dotfile"
    /usr/local/bin/git --git-dir="${HOME}/.dotfiles" --work-tree="${HOME}" $@
}

##
# Include config specific to this machine if present.
# Performed last to allow overrides if needed.
##
[ -f .zshrc.local ] && source .zshrc.local 
