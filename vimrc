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
set t_Co=256
syntax enable

" disable folding
set nofoldenable

" Theme
colorscheme onedark

" Search commands
set smartcase
set incsearch
set hlsearch

" Change backup files to /tmp
call system('mkdir /tmp/vim')
set directory=/tmp/vim//
set undodir=/tmp/vim//
set undofile

" Reload the current buff if changed externally
set autoread

" Auto indent with 2 spaces
set smartindent
set shiftwidth=2
set expandtab
set tabstop=2

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

" for nerd tree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'

" for autocomplete
Plug 'Valloric/YouCompleteMe'

" for saltstack
Plug 'saltstack/salt-vim'
Plug 'stephpy/vim-yaml'

call plug#end()

""""" end vim-plug

" Open NERDTree on open
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
let NERDTreeMapOpenInTab='<ENTER>'

" Remove ctrl+b 
nnoremap <C-b> <nop>

" Custom commands
nnoremap <leader>t :Files<CR>
nnoremap <leader><bar> :NERDTreeFind<CR>
nnoremap <leader>nt> :NERDTreeToggle<CR>

" Cursor in active window
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END
