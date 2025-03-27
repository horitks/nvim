set number
set guifont=DroidSansMono\ Nerd\ Font\ 13
set guifontwide=DroidSansMono\ Nerd\ Font\ 13
set wildmenu
set ruler
set history=1000
set encoding=utf8
set spell spelllang=en_us,cjk
set spellfile=~/.vim/spell/en.utf-8.add

set wrapscan
set incsearch
set hlsearch

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set virtualedit=block
set clipboard+=unnamed

set list
set listchars=tab:»-,trail:-
set cursorline

set re=1

" コメント行からoする時はコメント自動挿入しない
autocmd FileType * setlocal formatoptions-=o

" ESC SETTINGS
inoremap jk <Esc>
inoremap jj <Esc>

"/// SPLIT BORDER SETTINGS
hi VertSplit cterm=none

set visualbell
set t_vb=

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

noremap ; :

let mapleader = "\<Space>"
nnoremap <Leader>v :<C-u>vs %<CR>
nnoremap <Leader>s :<C-u>sp %<CR>
nnoremap <Leader>t :<C-u>tabnew %<CR>
map <Leader>q :q<CR>
nmap <Leader>w [window]
nnoremap [window]h <C-w>h
nnoremap [window]j <C-w>j
nnoremap [window]k <C-w>k
nnoremap [window]l <C-w>l
nnoremap [window]w <C-w>w
nnoremap <C-b> <C-u>#<CR>
nmap cp :let @* = expand("%:p")<CR>
nnoremap <Leader>q :<C-u>q<CR>

map <C-l> gt
map <C-h> gT
nnoremap <ESC> :nohl<CR>

" vim write diff
command Wdiff :w !diff % -

" 編集箇所のカーソルを記憶
if has("autocmd")
  augroup redhat
    " In text files, always limit the width of text to 78 characters
    autocmd BufRead *.txt set tw=78
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif

