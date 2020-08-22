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

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

fpath=( "$HOME/.zsh/site-functions" $fpath )

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors; colors

# enable coloured output from ls, etc
export CLICOLOR=1

# Allow shell history in IEx/Erlang
export ERL_AFLAGS="-kernel shell_history enabled"

autoload -U promptinit; promptinit
prompt pure

export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/.composer/vendor/bin:$PATH"

if [ -s "/usr/local/opt/asdf/asdf.sh" ] ; then
  export KERL_CONFIG_OPTIONS="--without-javac"
  . /usr/local/opt/asdf/asdf.sh
fi

# chruby and ruby auto-switcher
# if [ -s "/usr/local/opt/chruby/share/chruby/chruby.sh" ] ; then
#   source /usr/local/opt/chruby/share/chruby/chruby.sh
#   source /usr/local/opt/chruby/share/chruby/auto.sh
# fi

[ -s "~/Users/matthew/.secrets" ] && source "/Users/matthew/.secrets"

# SCM Shortcuts
eval "$(scmpuff init -s)"
eval "$(direnv hook zsh)"
[ -s "/Users/matthew/.iterm2_shell_integration" ] && source /Users/matthew/.iterm2_shell_integration.zsh
[ -s "/usr/local/share/zsh/site-functions" ] && source /usr/local/share/zsh/site-functions
