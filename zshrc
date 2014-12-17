# modify the prompt to contain git branch name if applicable

setopt promptsubst

setopt hist_ignore_all_dups inc_append_history appendhistory
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

setopt extendedglob
setopt nomatch notify
unsetopt beep
bindkey -v

autoload -Uz compinit
compinit

PURE_GIT_PULL=0
PURE_GIT_UNTRACKED_DIRTY=0

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

# enable coloured output from ls, etc
export CLICOLOR=1

export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# chruby and ruby auto-switcher
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

[ -s "~/Users/matthew/.secrets" ] && source "/Users/matthew/.secrets"

[ -s "/Users/matthew/.scm_breeze/scm_breeze.sh" ] && source "/Users/matthew/.scm_breeze/scm_breeze.sh"
