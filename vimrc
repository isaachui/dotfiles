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
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" for autocomplete
" Plug 'Valloric/YouCompleteMe'

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

" COC
" Needed for nodejs
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

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

" coc.nvim settings
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
