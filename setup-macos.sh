# copy paste this file in bit by bit.
# don't run it.
echo "do not run this script in one go. hit ctrl-c NOW"
read -n 1

# install homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# # install all the things
./brew.sh
./brew-cask.sh

### install of common things

# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
bash < <(curl https://raw.github.com/jamiew/git-friendly/master/install.sh)

# install fisher for fish
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# install cht.sh
# https://github.com/chubin/cheat.sh#installation

# install miniforge
# https://github.com/conda-forge/miniforge

# install docker
# https://docs.docker.com/docker-for-mac/install/

# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# fancy listing of recent branches
npm install -g git-recent

# trash as the safe `rm` alternative
npm install --global trash-cli

# more readable git diffs
npm install --global diff-so-fancy

# my preferred statik webserver
npm install -g statikk

# insteall mac-cli
sh -c "$(wget https://raw.githubusercontent.com/guarinogabriel/mac-cli/master/mac-cli/tools/install -O -)"

cargo install silicon
cargo install ouch
cargo install leetup

### remaining configuration
###

# go read mathias, paulmillr, gf3, alraa's dotfiles to see what's worth stealing.

# prezto and antigen communties also have great stuff
#   github.com/sorin-ionescu/prezto/blob/master/modules/utility/init.zsh

# set up macos defaults
#   maybe something else in here https://github.com/hjuutilainen/dotfiles/tree/master/bin
sh .macos

# setup and run Rescuetime!
