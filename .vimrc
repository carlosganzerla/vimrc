"
" A (not so) minimal vimrc.
"
 "You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitly to make our position clear!
set nocompatible

set clipboard=unnamedplus

" Change highlighting of cursor line when entering/leaving Insert Mode
filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.
set omnifunc=syntaxcomplete#Complete
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set spell spelllang=en_us   " Spell checker

set number " Show line numbers

set colorcolumn=80 " Vertical ruler

" Tab switching
nnoremap H gT
nnoremap L gt

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

" Word wrap, line break and force text width on markdown files
au BufRead,BufNewFile *.md 
            \ setlocal textwidth=79
            \ | setlocal wrap
            \ | setlocal linebreak
            \ | setlocal nolist
            \ | setlocal filetype=markdown
set fo-=l

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set path+=**                " Fuzzy file search enabled
set wildignore+=**/node_modules/**
set wildignore+=**/__pycache__/**
set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Show buffers on F5
nnoremap <F5> :buffers<CR>:buffer<Space>

" Reload .vimrc with F6
noremap <F6> :source ~/.vimrc<CR>


call plug#begin('~/vim/plugged')


Plug 'tomasiser/vim-code-dark'


Plug 'sheerun/vim-polyglot'

if !has('nvim')
    Plug 'rhysd/vim-healthcheck'


Plug 'preservim/nerdtree'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}
Plug 'jremmen/vim-ripgrep'
endif


call plug#end()

" VS Code like colors
set mouse=
set ttymouse=
set t_Co=256
set t_ut=
colorscheme codedark

" Show Tree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Node JS Syntax highlighting
set runtimepath^=~/.vim/bundle/node
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1
let g:ale_fixers = {
  \ 'javascript': ['eslint'],
  \ 'javascriptreact': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'typescriptreact': ['eslint']
  \}

" Leader key
let mapleader=","

" Nerd tree bindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Switch buffers using tabs
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <S-x> :bd<CR>

 " Load .vimrc onto another buffer
nnoremap <leader>rc :e ~/.vimrc<CR>

 " LSP mappings
nnoremap <leader>le :LspNextError<CR>
nnoremap <leader>lh :LspHover<CR>
nnoremap <F12> :LspDefinition<CR>
nnoremap <leader>ld :LspDocumentDiagnostics<CR>

 " Quick list bindings
" nnoremap <leader>qn :lnext<CR>
" nnoremap <leader>qo :lopen<CR>
" nnoremap <leader>qp :lprev<CR>
" nnoremap <leader>qc :lclose<CR>

" Run ESLINT on save for js files
command! Eslint 
            \ execute 'silent !eslint %:p --quiet --fix'
            \ | redraw!

" Grep with git
command! -nargs=1 Grep execute 'grep -lir <f-args> `git ls-files`'

" Clear trailing whitespace
nnoremap <leader><Space> :%s/\s\+$//e<CR>

" Save file
nnoremap <C-s> :w<CR>

" Redraw on Ctrl F5
nnoremap <C-F5> :redraw!<CR>

nnoremap <leader><Up> :cprev<CR>
nnoremap <leader><Down> :cnext<CR>
nnoremap <leader><Right> :cnf<CR>
nnoremap <leader>c :cclose<CR>
nnoremap <leader>o :copen<CR>
