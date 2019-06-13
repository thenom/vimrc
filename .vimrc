" General config
set nu						" turn on line number
set nocompatible				" dont force vi compatibility
filetype off					" enable file type detection
set encoding=utf-8				" default to utf-8
syntax on					" enable syntax highlighting
set pastetoggle=<F2>				" use F2 to toggle code block pasting
set ruler					" show column and line of current cursor position
set pyxversion=3				" set default python version to use for pyx* commands
set splitbelow                                  " open horizontal split below
set splitright                                  " open vertical split on the right

" --- split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

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

Plugin 'hashivim/vim-terraform'         " terraform subcommands and filetype setups
Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" ---- End Vundle setup

" --- Post vundle config
filetype plugin indent on			" enable loading the indent file for specific file types

" --- deoplete config
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })   " go configuration

" --- neosnippet config
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

" --- powerline config
set  rtp+=powerline/bindings/vim/
set laststatus=2
set t_Co=256

" --- nerdtree config
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  "close vim if nerdtree is the last window

" --- toggle tag bar
nmap <F8> :TagbarToggle<CR>
let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'   " fixes brew version of vim

" --- terraform config
let g:terraform_align=1            " indentation syntax for matching files
let g:terraform_fold_sections=1    " automatically fold (hide until unfolded) sections of terraform code
let g:terraform_fmt_on_save=1      " Allow vim-terraform to automatically format *.tf and *.tfvars files with terraform fmt

" --- custom file types
au BufNewFile,BufRead jenkinsfile,Jenkinsfile
	\ set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix ft=groovy
