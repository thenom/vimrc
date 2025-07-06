" General config
set nu rnu					" turn on hybrid line numbers
set nocompatible				" dont force vi compatibility
filetype off					" enable file type detection
filetype plugin indent on                       " enable file type detection
set encoding=utf-8				" default to utf-8
set pastetoggle=<F2>				" use F2 to toggle code block pasting
set ruler					" show column and line of current cursor position
set pyxversion=3				" set default python version to use for pyx* commands
set splitright                                  " open vertical split on the right
set backspace=indent,eol,start			" sets backspace to delete indents, back to the previous line and past the start of insert mode
set autochdir                                   " chdir to current file
let $BASH_ENV="~/.vimbash"			" Tells vim to use this file as a bash profile
"set shell=/bin/bash                     " set the shell and force new login

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

call plug#begin()

Plug 'scrooloose/nerdtree'		" File manager and browser
Plug 'fatih/vim-go'			" Go tools and code completion
Plug 'majutsushi/tagbar'		" list file tags

" Plug 'ycm-core/YouCompleteMe'         "Auto completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}               "trial other autocompletion

Plug 'hashivim/vim-terraform'                " terraform subcommands and filetype setups
Plug 'juliosueiras/vim-terraform-completion' " terraform autocompletion

Plug 'vim-syntastic/syntastic'  " Syntax checker

Plug 'xavierchow/vim-swagger-preview'   "  Open swagger api spec in chrome

Plug 'tpope/vim-fugitive'   " Git integration
Plug 'tpope/vim-rhubarb'   " Git hub integration

Plug 'itchyny/lightline.vim'  " lightline status line

Plug 'vim-scripts/indentpython.vim'    " ermmm, python indenting?
Plug 'nvie/vim-flake8'                 " apply pep8 to python
Plug 'davidhalter/jedi-vim'            " python autocompletion (disabled to test YCM)

Plug 'scrooloose/nerdcommenter'        " comment\uncomment blocks

Plug 'sirver/ultisnips'             " snippets
Plug 'honza/vim-snippets'          " snippets library

Plug 'ekalinin/dockerfile.vim'    " dockerfile highlighting

Plug 'tsandall/vim-rego'      " for Open Policy Agent rego files

Plug 'Chiel92/vim-autoformat'    " autoformatter

Plug 'robbles/logstash.vim'

Plug 'vim-test/vim-test'     " https://github.com/vim-test/vim-test

Plug 'wellle/context.vim'    " to keep things like function names at the top on the window when scrolling

" Colour schemes
"Plug 'NLKNguyen/papercolor-theme'
Plug 'morhetz/gruvbox'

" Ollama AI
" Plug 'gergap/vim-ollama'

" All of your Plugins must be added before the following line
call plug#end()


" --- coc config
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" --- lightline config
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename', 'modified' ] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" --- vim-ollama
let g:ollama_host = 'http://localhost:11434'
let g:ollama_chat_model = 'deepseek-r1:8b'
let g:ollama_model = 'deepseek-coder-v2:latest'

" --- set colourscheme
set background=dark
colorscheme gruvbox

" --- Post vundle config
filetype plugin indent on			" enable loading the indent file for specific file types

" --- UltiSnips
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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
let g:syntastic_python_flake8_args='--ignore = F821,E302,E501'

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

" --- vim-test config
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

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

" --- custom functions
" format XML
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap = :FormatXML<Cr>

" format JSON - needs jq installed
com! FormatJSON :%!jq .
nnoremap = :FormatJSON<Cr>
