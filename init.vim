set number
set guifont=DroidSansMono\ Nerd\ Font\ 13
set guifontwide=DroidSansMono\ Nerd\ Font\ 13
set wildmenu
set ruler
set history=1000
set encoding=utf8

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
:match Ignore / /

set visualbell
set t_vb=

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

noremap ; :

let mapleader = "\<Space>"

map <C-l> gt
map <C-h> gT

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

" ripgrep (rename-to:rg)
if executable("rg")
    let &grepprg = 'rg --vimgrep --hidden > /dev/null'
    set grepformat=%f:%l:%c:%m
endif

" PLUGIN SETTINGS
call plug#begin('~/.config/nvim/plugged')
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'

Plug 'editorconfig/editorconfig-vim'

Plug 'fatih/vim-go'
Plug 'pangloss/vim-javascript'

Plug 'github/copilot.vim'
call plug#end()

" ale
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 1

" molokai
syntax enable
colorscheme molokai
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi VertSplit ctermbg=NONE
hi Special ctermbg=NONE
hi Identifier ctermbg=NONE

hi Comment ctermfg=102
hi Visual  ctermbg=240
hi Ignore ctermbg=235

" NERDTree SETTINGS
nnoremap <leader>n :NERDTreeFocus<CR>
map <C-n> <plug>NERDTreeTabsToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:airline#extensions#tabline#enabled = 1
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
let NERDTreeShowHidden = 1

" NERDTree git
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusShowIgnored = 1

" vim fzf ripgrep
set runtimepath+=~/.zplug/bin/fzf

function! FZGrep(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call FZGrep(<q-args>, <bang>0)

nnoremap <leader>,p :GFiles<CR>
nnoremap <leader>,f :Files<CR>
nnoremap <leader>,r :RG<CR>
nnoremap <leader>,c :Commits<CR>

" coc.nvim
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)

" Airline SETTINGS
let g:airline_powerline_fonts = 1

" Esc SETTINGS
inoremap jk <Esc>
inoremap jj <Esc>

"/// SPLIT BORDER SETTINGS
hi VertSplit cterm=none
