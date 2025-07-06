" General config
set nu rnu					" turn on hybrid line numbers
set nocompatible				" dont force vi compatibility
set encoding=utf-8				" default to utf-8
set pastetoggle=<F2>				" use F2 to toggle code block pasting
set ruler					" show column and line of current cursor position
set splitright				" open vertical split on the right
set backspace=indent,eol,start			" sets backspace to delete indents, back to the previous line and past the start of insert mode
set autochdir				" chdir to current file
let $BASH_ENV="~/.vimbash"			" Tells vim to use this file as a bash profile
set updatetime=300				" Crucial for CoC responsiveness
set signcolumn=yes				" Always show the signcolumn for diagnostics
set cmdheight=2					" Give more room for messages and command line
set shortmess+=c				" Reduce some common messages
set scrolloff=8					" Keep 8 lines of context around cursor when scrolling
set completeopt=menuone,noinsert,noselect	" Completion menu options for CoC

" check for python3, if successful then python3 will be the loaded version
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

Plug 'neoclide/coc.nvim', {'branch': 'release'}	" Auto completion via LSP

Plug 'hashivim/vim-terraform'		" terraform subcommands and filetype setups

Plug 'xavierchow/vim-swagger-preview'	" Open swagger api spec in chrome

Plug 'tpope/vim-fugitive'		" Git integration
Plug 'tpope/vim-rhubarb'		" Git hub integration

Plug 'itchyny/lightline.vim'		" lightline status line

Plug 'scrooloose/nerdcommenter'		" comment\uncomment blocks

Plug 'ekalinin/dockerfile.vim'		" dockerfile highlighting

Plug 'tsandall/vim-rego'		" for Open Policy Agent rego files

Plug 'robbles/logstash.vim'

Plug 'vim-test/vim-test'		" https://github.com/vim-test/vim-test

Plug 'wellle/context.vim'		" to keep things like function names at the top on the window when scrolling

" Colour schemes
Plug 'whatyouhide/vim-gotham'

" Ollama AI
" Plug 'gergap/vim-ollama'

" All of your Plugins must be added before the following line
call plug#end()

" --- Post plugin config
filetype plugin indent on		" enable loading the indent file for specific file types

" --- set colourscheme
set termguicolors			" Enable true color support
set background=dark
colorscheme gotham

" --- coc config
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
      \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" Have CoC format on save
autocmd BufWritePre *.go,*.py,*.tf,*.json,*.yaml,*.rego :call CocAction('format')

" --- lightline config
let g:lightline = {
      \ 'colorscheme': 'gotham',
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

" --- nerdtree config
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif  "close vim if nerdtree is the last window
let NERDTreeShowBookmarks=1

" --- vim-terraform config
let g:terraform_align=1         " indentation syntax for matching files
let g:terraform_fold_sections=0       " automatically fold (hide until unfolded) sections of terraform code
let g:terraform_commentstring='//%s' " Override vims comment string

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
