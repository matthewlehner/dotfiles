# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/user/local/sbin:$PATH"

alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

alias g='git'
alias gap='git add -p'
alias gcl='git clone --recursive'
alias gr='git remote'
alias gf='git fetch'
alias gm='git merge --ff-only'
alias gps='git push'
alias gc='git commit'
alias gdc='git diff --cached'
alias gmv='git mv'
alias grb='git rebase'
alias gb='git branch'
alias grm='git rm'
alias gcp='git cherry-pick'
alias gcoma='git checkout origin/master'

alias vim='nvim'
alias start='vim ~/Dropbox/Documents/Notes/day-start-checklist.md'
