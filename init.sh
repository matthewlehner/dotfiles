#!/bin/sh

# Install Homebrew
# insert homebrew install command here
# brew update

# Install git
# brew install git
# brew install bash-completion

# Install rbenv
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
mkdir -p ~/.rbenv/plugins
cd ~/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git
git clone git://github.com/jamis/rbenv-gemset.git
echo 'global' >> ~/.rbenv-gemsets
