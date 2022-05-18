 Usage 
## clone repo
```
cd ~/.config
git clone git@github.com:horitks/nvim.git
```

## neovim
install
https://neovim.io/

## vim-plug
install
https://github.com/junegunn/vim-plug

mac
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## PlugInstall
```
nvim
:PlugInstall
```

# Appendix
## alias
alias vim "nvim"

.zshrc
```
alias vi='nvim'
alias vim='nvim'
```

## fonts
for iterm2
```
cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

## fzf
```
brew install fzf
```

## gem

```
gem install rubocop
gem install solargraph
gem install neovim
```
