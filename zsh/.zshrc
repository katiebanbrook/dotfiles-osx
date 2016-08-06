# Pretty Colors Location
eval $( gdircolors -b $HOME/.dir_colors)
export EDITOR='vim'
autoload -Uz compinit promptinit
autoload -Uz vcs_info
compinit
promptinit
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt correct

# Because I'm Lazy
export PS1="%d:> "
alias locip="ifconfig | grep inet"
alias look='less -FX'
alias cc='clear'

# TSheets Debugging Tunnel
alias debug-lntxweb1='ssh -nNT -R 9031:localhost:9000 kbanbrook@lntxweb1.tsheets-dev.com'
alias debug-shazdev='ssh -nNT -R 9031:localhost:9000 kbanbrook@shazdev.tsheets.com'

# Management
alias rezsh='source ~/.zshrc'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'

# Pretty Colors For ls
alias ls='gls --color=auto'
