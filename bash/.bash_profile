# Config
OS=$(uname -a)

if [[ $OS == *"Darwin"* ]]
then
    AUTOCOMPLETE=$(brew --prefix)/etc/bash_completion
    TRASH='~/.Trash'
else
    AUTOCOMPLETE='/etc/bash_completion'
    TRASH='~/.local/share/Trash'
fi

export EDITOR=vim
PS1='$PWD:> '

# Management
alias locip="ifconfig | grep inet"
alias extip="curl ipecho.net/plain ; echo"
alias rebash='source ~/.bash_profile'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias cc='clear'

# Pretty Colors For ls
if [[ $OS == *"Linux"* ]]
then
    alias ls='ls --color=auto'
else
    alias ls='gls --color=auto'
fi

# TSheets Debugging Tunnel
alias debug-lntxweb1='ssh -nNT -R 9031:localhost:9000 kbanbrook@lntxweb1.tsheets-dev.com'
alias debug-shazdev='ssh -nNT -R 9031:localhost:9000 kbanbrook@shazdev.tsheets.com'

# Activate Colors
if [ -f ~/.dir_colors ]
then
    if [[ $OS == *"Linux"* ]]
    then
        eval 'dircolors ~/.dir_colors'
    else
        eval 'gdircolors ~/.dir_colors'
    fi
fi

export PATH="$PATH:/usr/local/Cellar:/Arcanist/arcanist/bin/"

