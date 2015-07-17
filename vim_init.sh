#!/usr/bin/env bash
#this script is originated from 
#http://sontek.net/blog/detail/turning-vim-into-a-modern-python-ide
#© John Anderson <sontek@gmail.com> 2011
#usage:
#for pydoc.  use <leader>pw  when cursor on a word
#for flake8, press F7
#for 
 
#TODO: install ctags for tagbar
#http://majutsushi.github.io/tagbar/
sudo apt-get install ctags
 
#install flake8
sudo pip install flake8
  
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
#sensible
git clone https://github.com/tpope/vim-sensible.git
#numbers.vim
git clone https://github.com/myusuf3/numbers.vim
#airline sattus bar. Remember to run :Helptags to generate help tags
git clone https://github.com/bling/vim-airline
vim -u NONE -c "helptags vim-airline/doc" -c q
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/easymotion/vim-easymotion
git clone https://github.com/tpope/vim-fugitive
vim -u NONE -c "helptags vim-fugitive/doc" -c q
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/majutsushi/tagbar.git
#color
git clone https://github.com/altercation/vim-colors-solarized.git
#inde guides. default toggle mapping: <leader>ig
git clone https://github.com/nathanaelkane/vim-indent-guides.git
#syntax check. run :SyntasticInfo to see running checkers.
# with "unimpared", use "[l" and "]l" to go through errors
#lclose to close it 
git clone https://github.com/scrooloose/syntastic.git
vim -u NONE -c "helptags syntastic/doc" -c q
#toggle curser for insert mode
git clone https://github.com/jszakmeister/vim-togglecursor

git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.sh --clang-completer --gocode-completer
#for fish shell, do this
#cat "set -x DYLD_FORCE_FLAT_NAMESPACE 1" >> ~/.config/fish/config.fish

cd ~/.vim/bundle
git clone https://github.com/SirVer/ultisnips
git clone https://github.com/honza/vim-snippets
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/Raimondi/delimitMate

git clone https://github.com/scrooloose/nerdcommenter
vim -u NONE -c "helptags nerdcommenter/doc" -c q

git clone https://github.com/tpope/vim-unimpaired.git

git clone https://github.com/sjl/gundo.vim

git clone https://github.com/xolox/vim-easytags
git clone https://github.com/xolox/vim-misc

git clone https://github.com/scrooloose/nerdtree.git
git clone https://github.com/klen/python-mode.git

git clone https://github.com/fatih/vim-go

cd ~/.vim
git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

touch ~/.vimrc
mv ~/.vimrc ~/.vimrc.orig
ln -s `pwd`/.vimrc ~/.vimrc
#cp .vimrc ~/.vimrc
#mkdir -p ~/.vim/UltiSnips/
#cp ./.vim/UltiSnips/* ~/.vim/UltiSnips/
ln -s `pwd`/.vim/UltiSnips ~/.vim/UltiSnips

# Install powerline fonts fir airline
mkdir -p ~/tmp/
git clone https://github.com/powerline/fonts.git ~/tmp/powerline_fonts
~/tmp/powerline_fonts/install.sh
