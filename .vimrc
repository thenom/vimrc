" General config
set nu						" turn on line number
set nocompatible				" dont force vi compatibility
filetype off					" enable file type detection
set encoding=utf-8				" default to utf-8
syntax on					" enable syntax highlighting
set pastetoggle=<F2>				" use F2 to toggle code block pasting
set ruler					" show column and line of current cursor position
set pyxversion=3				" set default python version to use for pyx* commands
let g:python_host_prog = "/usr/bin/python2"	" python 2 bin location
let g:python3_host_prog = "/usr/bin/python3"	" python 3 bin location

" check for python3, if succesful then python3 will be the loaded version
if !has('python3')
	echo "Warning! has('python3') failed its check!"
endif

" ---- Vundle setup (first! cd ~/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim.git)
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle/')

" let Vundle manage Vundle, required
Plugin 'Vundle/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'		" Fold\collapse your code blocks
Plugin 'scrooloose/nerdtree'		" File manager and browser
Plugin 'fatih/vim-go'			" Go tools and code completion
Plugin 'majutsushi/tagbar'		" list file tags
Plugin 'Shougo/deoplete.nvim'		" Autocompletion
if !has('nvim')
  Plugin 'roxma/nvim-yarp'		" deoplete dependancies
  Plugin 'roxma/vim-hug-neovim-rpc'	" deoplete dependancies
endif

Plugin 'Shougo/neosnippet.vim'		" code snippet tools
Plugin 'Shougo/neosnippet-snippets'	" code snippets

Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" ---- End Vundle setup

" deoplete config
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })   " go configuration

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" powerline config
set  rtp+=powerline/bindings/vim/
set laststatus=2
set t_Co=256

" nerdtree config
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" toggle tag bar
nmap <F8> :TagbarToggle<CR>
