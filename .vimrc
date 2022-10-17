" General config
set nu rnu					" turn on hybrid line numbers
set nocompatible				" dont force vi compatibility
filetype off					" enable file type detection
filetype plugin indent on                       " enable file type detection
set encoding=utf-8				" default to utf-8
syntax on					" enable syntax highlighting
set pastetoggle=<F2>				" use F2 to toggle code block pasting
set ruler					" show column and line of current cursor position
set pyxversion=3				" set default python version to use for pyx* commands
set splitbelow                                  " open horizontal split below
set splitright                                  " open vertical split on the right
set backspace=indent,eol,start			" sets backspace to delete indents, back to the previous line and past the start of insert mode
set autochdir                                   " chdir to current file
"let $BASH_ENV="~/.vimbash"			" Tells vim to use this file as a bash profile
"set shell=/bin/bash                     " set the shell and force new login

" set colourscheme
colorscheme habamax

" check for python3, if succesful then python3 will be the loaded version
if !has('python3')
	echo "Warning! has('python3') failed its check!"
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Setup folding toggle to F9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" ---- Vundle setup (first! cd ~/.vim/bundle && git clone https://github.com/VundleVim/Vundle.vim.git)
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle/')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
" Plugin 'tmhedberg/SimpylFold'		" Fold\collapse your code blocks
Plugin 'scrooloose/nerdtree'		" File manager and browser
Plugin 'fatih/vim-go'			" Go tools and code completion
Plugin 'majutsushi/tagbar'		" list file tags

Plugin 'ycm-core/YouCompleteMe'         "Auto completion

Plugin 'Shougo/neosnippet.vim'		" code snippet tools
Plugin 'Shougo/neosnippet-snippets'	" code snippets

Plugin 'hashivim/vim-terraform'                " terraform subcommands and filetype setups
Plugin 'juliosueiras/vim-terraform-completion' " terraform autocompletion

Plugin 'vim-syntastic/syntastic'  " Syntax checker

Plugin 'xavierchow/vim-swagger-preview'   "  Open swagger api spec in chrome

Plugin 'tpope/vim-fugitive'   " Git integration
Plugin 'tpope/vim-rhubarb'   " Git hub integration

Bundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}

Plugin 'vim-scripts/indentpython.vim'    " ermmm, python indenting?
Plugin 'nvie/vim-flake8'                 " apply pep8 to python
"Plugin 'davidhalter/jedi-vim'            " python autocompletion (disabled to
"test YCM)

Plugin 'scrooloose/nerdcommenter'        " comment\uncomment blocks

Plugin 'ekalinin/dockerfile.vim'    " dockerfile highlighting

Plugin 'tsandall/vim-rego'      " for Open Policy Agent rego files

Plugin 'Chiel92/vim-autoformat'    " autoformatter

" All of your Plugins must be added before the following line
call vundle#end()            " required
" ---- End Vundle setup


" --- Post vundle config
filetype plugin indent on			" enable loading the indent file for specific file types

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
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"			\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" Expand on CR
"imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<CR>"

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

" --- powerline config
set rtp+=powerline/bindings/vim/
set laststatus=2
set t_Co=256

" --- nerdtree config
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  "close vim if nerdtree is the last window
let NERDTreeShowBookmarks=1

" --- toggle tag bar
nmap <F8> :TagbarToggle<CR>
let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'   " fixes brew version of vim

" --- vim-terraform config
let g:terraform_align=1              " indentation syntax for matching files
let g:terraform_fold_sections=0      " automatically fold (hide until unfolded) sections of terraform code
let g:terraform_fmt_on_save=1        " Allow vim-terraform to automatically format *.tf and *.tfvars files with terraform fmt
let g:terraform_commentstring='//%s' " Override vims comment string

" --- vim-terraform-autocompletion
let g:syntastic_terraform_tffilter_plan = 1              " (Optional) Enable terraform plan to be include in filter
"set completeopt-=preview                                 " (Optional)Remove Info(Preview) window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif " (Optional)Hide Info(Preview) window after completions
autocmd InsertLeave * if pumvisible() == 0|pclose|endif  " (Optional)Hide Info(Preview) window after completions
let g:terraform_completion_keys = 1                      " (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_module_registry_search = 0               " attempt to stop the slow update for deoplete
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" --- Syntastic config
set statusline+=%#warningmsg#                  " recomended defaults
set statusline+=%{SyntasticStatuslineFlag()}   " recomended defaults
set statusline+=%*   " recomended defaults

let g:syntastic_always_populate_loc_list = 1   " recomended defaults
let g:syntastic_auto_loc_list = 1              " recomended defaults
let g:syntastic_check_on_open = 1              " recomended defaults
let g:syntastic_check_on_wq = 0                " recomended defaults

let g:syntastic_mode_map = {
			\ "mode": "active",
			\ "active_filetypes": [],
			\ "passive_filetypes": ["python", "terraform"] }  " fix autocompletion inserting first selection

" --- vim-flake8 config
let g:flake8_show_in_gutter=1
autocmd BufWritePost *.py call flake8#Flake8()
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_python_flake8_post_args='--ignore=E501,E128,E225'

" --- split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" --- vim-rego config
let g:formatdef_rego = '"opa fmt"'
let g:formatters_rego = ['rego']
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
au BufWritePre *.rego Autoformat

" --- custom file types
au BufNewFile,BufRead *.tf,*.tfvars
			\ set ft=terraform expandtab
au BufNewFile,BufRead jenkinsfile,Jenkinsfile
			\ set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix ft=groovy
au BufNewFile,BufRead *.py
			\ set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.yml,*.yaml
			\ set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.json,*.tpl
			\ set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix ft=json
au BufNewFile,BufRead *.sh,*.bash
			\ set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
