set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

Plugin 'tmhedberg/SimpylFold'

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

"au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.erb set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.conf set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix
au BufNewFile,BufRead *.pp set tabstop=2 softtabstop=2 shiftwidth=2 expandtab autoindent fileformat=unix


Plugin 'vim-scripts/indentpython.vim'

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

Bundle 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
let python_highlight_all=1
syntax on

Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

Plugin 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

Plugin 'jistr/vim-nerdtree-tabs'

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

set nu

Plugin 'tpope/vim-fugitive'

Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

set pastetoggle=<F2>
