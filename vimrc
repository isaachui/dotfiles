" Enable default settings.
filetype plugin indent on
set ruler
set number
" set textwidth=80
set wrap| " wrap lines
set wildmenu
set wildignorecase
set wildmode=longest:full,full
set wildchar=<Tab>
syntax enable

" disable folding
set nofoldenable

" lazy rewdraw
set nolazyredraw

" Search commands
set smartcase
set ignorecase
set incsearch
set hlsearch

" Change backup files to /tmp
call system('mkdir /tmp/vim')
set directory=/tmp/vim//
set undodir=/tmp/vim//
set undofile

" Automatically change current dir
" set autochdir

" Reload the current buff if changed externally
set autoread

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Auto indent with 2 spaces
set smartindent
set shiftwidth=2
set expandtab
set tabstop=2

" show whitespace characters
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set list

" make backspace work
set backspace=indent,eol,start

" Map ^hjkl to move between window panes
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" remap leader key
let mapleader = ","

""""""  vim-plug
call plug#begin('~/.vim/plugged')

" for fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" for autocomplete
Plug 'Valloric/YouCompleteMe'

" for indentation guide
Plug 'Yggdroot/indentLine'

" for hashicorp
Plug 'hashivim/vim-hashicorp-tools'

" for saltstack
Plug 'saltstack/salt-vim'
Plug 'stephpy/vim-yaml'
Plug 'Glench/Vim-Jinja2-Syntax'

" Vim git gutter
Plug 'airblade/vim-gitgutter'

" Vim vinegar
Plug 'tpope/vim-vinegar'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Vim status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" color schemes
Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }

" auto close brackets
Plug 'Raimondi/delimitMate'

" js coloring
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" highlight extra white space
Plug 'ntpeters/vim-better-whitespace'

" for golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" linediff
Plug 'AndrewRadev/linediff.vim'

call plug#end()

""""" end vim-plug

" Remove ctrl+b
nnoremap <C-b> <nop>

" Custom commands
nnoremap <leader>t :Files<CR>
" trailing space intentional
nnoremap <leader>r :Rg<space>

" Cursor in active window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Theme
let g:dracula_italic = 0
colorscheme dracula
highlight Normal ctermbg=None
if (has("termguicolors"))
  set termguicolors
endif

" Vim indent lines
let g:indentLine_char = '|'

" Vim airline configuration
let g:airline#extensions#hunks#enabled=0
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#vcs_checks = []

autocmd Filetype json let g:indentLine_setConceal = 0

" gopls configuration
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
