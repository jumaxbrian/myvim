"syntax highlighting on
syntax on

"set terminal colors to 256
set termguicolors

"autoreload config without restarting vim
autocmd! bufwritepost .vimrc source %

"Better copy and paste
"set pastetoggle=<F2>
set clipboard=unnamedplus

"mouse and backspace
set mouse=a
set bs=2 "make backspace behave like normal again

let mapleader=","

set hlsearch

"add line numbers
set number


"add relative line numbers
set relativenumber

"Vundle prerequisites
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'posva/vim-vue'
Plugin 'dense-analysis/ale'
Plugin 'gabrielelana/vim-markdown'
Plugin 'jiangmiao/auto-pairs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"split navigations and remap them to custom config
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

"add the proper PEP 8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix 

au BufNewFile,BufRead *.js,*.html,*.css,*.yml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent 

"Flagging Unnecessary Whitespace
highlight BadWhitespace ctermfg=16 ctermbg=253 guifg=#000000 guibg=#F8F8F0
au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"auto-complete window goes away when you’re done with it
let g:ycm_autoclose_preview_window_after_completion=1

"a shortcut for goto definition
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"configuration for ALE
"set linters from https://langserver.org/
let g:ale_linters = {
    \   'python': ['flake8', 'pylint'],
    \   'javascript': ['eslint'],
    \   'sh': ['language_server'],
    \}

"fix problems in code
let g:ale_fixers = {
    \    'python': ['black', 'isort'],
    \    'javascript': ['prettier', 'eslint'],
    \}

nmap <F5> :ALEFix<CR>

"set format for linter messages
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1

"scrolling
"nnoremap <leader>e <C-E>
"nnoremap <leader>y <C-Y>
"nnoremap <leader>f <C-F>
"nnoremap <leader>b <C-B>

"soften the yellow line numbers
hi LineNr guifg=grey50 guibg=grey20

"Decide which colorscheme to use
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
  "colorscheme gruvbox
  set background=dark
endif

"ignore .pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"set vim to autoload a file when changed outside vim
set autoread
au CursorHold,CursorHoldI * checktime 
au FocusGained,BufEnter * :checktime

"reduce vue preprocessors so that posva/vim-vue can load faster
"https://github.com/posva/vim-vue#vim-gets-slows-down-when-using-this-plugin-how-can-i-fix-that
let g:vue_pre_processors = []
