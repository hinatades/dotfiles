#!/bin/zsh

print_header() {
      printf "\e[32m"
        echo '--------------------------------------------------------------------------------'
        echo '                                                                                '
        echo '                 888          888     .d888 d8b 888                             '
        echo '                 888          888    d88P"  Y8P 888                             '
        echo '                 888          888    888        888                             '
        echo '             .d88888  .d88b.  888888 888888 888 888  .d88b.  .d8888b            '
        echo '            d88" 888 d88""88b 888    888    888 888 d8P  Y8b 88K                '
        echo '            888  888 888  888 888    888    888 888 88888888 "Y8888b.           '
        echo '            Y88b 888 Y88..88P Y88b.  888    888 888 Y8b.          X88           '
        echo '             "Y88888  "Y88P"   "Y888 888    888 888  "Y8888   88888P"           '
        echo '                                                                                '
        echo '                         github.com/hinatades/dotfiles                          '
        echo '                                                                                '
        echo '--------------------------------------------------------------------------------'
        printf "\e[0m\n"
}

print_header

DOT_FILES=(
    .vim
    .vimrc
    .zshrc
    .tmux.conf
)

# Handle .config/nvim separately
NVIM_CONFIG_DIR="$HOME/.config/nvim"
DOTFILES_NVIM_DIR="$HOME/ghq/github.com/hinatades/dotfiles/.config/nvim"

if [ -e "$NVIM_CONFIG_DIR" ]; then
    if [ -d "$NVIM_CONFIG_DIR" ]; then
        cp -r "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.bak"
        rm -r "$NVIM_CONFIG_DIR"
    fi
    echo "Took a backup of $NVIM_CONFIG_DIR"
fi
ln -f -s "$HOME/ghq/github.com/hinatades/dotfiles/.config/nvim" "$NVIM_CONFIG_DIR"

for file in "${DOT_FILES[@]}"
do
    if [ -e "$HOME/$file" ]; then
        if [ -f "$HOME/$file" ]; then
            cp "$HOME/$file" "$HOME/$file.bak"
            rm "$HOME/$file"
        elif [ -d "$HOME/$file" ]; then
            sudo cp -r "$HOME/$file" "$HOME/$file.bak"
            sudo rm -r $HOME/$file
        fi
        echo "Took a backup of $HOME/$file"
    fi
    ln -f -s $HOME/ghq/github.com/hinatades/dotfiles/$file $HOME/$file
done

SECRET_DOT_FILES=(
    .gitconfig
    .aws
    .ssh
    .zsh_history
)

for file in ${SECRET_DOT_FILES[@]}
do
    if [ -e $HOME/$file ]; then
        if [ -f $HOME/$file ]; then
            cp $HOME/$file "$HOME/$file.bak"
            rm $HOME/$file
        elif [ -d $HOME/$file ]; then
            sudo cp -r $HOME/$file "$HOME/$file.bak"
            sudo rm -r $HOME/$file
        fi
        echo "Took a backup of $HOME/$file"
    fi
    ln -f -s $HOME/Dropbox/$file $HOME/$file
done
# Install zsh themes
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# Set env vars
source .zshrc
# Install zsh autosuggestion with oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
# Install vim-plug
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +":PlugInstall" +:q +:q
