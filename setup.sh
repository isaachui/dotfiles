#!/bin/sh
# Get the containing directory.
DOTS=$(cd "$(dirname "$0")" && pwd -P)

echo installing oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# move default .zshrc file away
mv $HOME/.zshrc $HOME/.zshrc.orig

echo symlinking files...
# Symlink the rc files.
for f in "$DOTS"/*rc; do
  ln -s "$f" $HOME/.$(basename "$f")
done

# Symlink ideavimrc
ln -s "$DOTS/.vimrc" $HOME/.ideavimrc

# Symlink the vim dir
if [ -d "$DOTS/vim" ]; then
  ln -s "$DOTS/vim" $HOME/.vim
else
  echo Skipping symlinking vim dir
fi

echo finished symlinking files

echo installing vim plugins
# Install vim plugins
vim '+PlugInstall --sync' +qall

echo finished setup
