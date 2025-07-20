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

" ripgrep (rename-to:rg)
if executable("rg")
    let &grepprg = 'rg --vimgrep --hidden > /dev/null'
    set grepformat=%f:%l:%c:%m
endif

" PLUGIN SETTINGS
call plug#begin('~/.config/nvim/plugged')
" Plug 'arcticicestudio/nord-vim'
" Plug 'cocopon/iceberg.vim'
Plug 'projekt0n/github-nvim-theme'

Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'slim-template/vim-slim'

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'

Plug 'editorconfig/editorconfig-vim'

Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-rails'
Plug 'mattn/vim-goimports'

Plug 'github/copilot.vim'
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'main' }
call plug#end()

" Copilot
lua << EOF
require('copilot').setup({
    suggestion = { enabled = true },
    panel = { enabled = true },
})
EOF

" CopilotChat
lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
}

function CopilotChatBuffer()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end

vim.api.nvim_set_keymap("n", "<leader>cc", "<cmd>lua CopilotChatBuffer()<cr>", { noremap = true, silent = true })
EOF

" ale
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 1

" goimports
let g:goimports = 1

" select color
syntax enable

" colorscheme nord
" colorscheme iceberg
colorscheme github_dark_dimmed

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=236
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#3a3a3a ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#4e4e4e ctermbg=237

" NERDTree SETTINGS
nnoremap <leader>n :NERDTreeFocus<CR>
map <C-n> <plug>NERDTreeTabsToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:airline#extensions#tabline#enabled = 1
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
let NERDTreeShowHidden = 1

" 終了時にmks! NERDTreeはエラーになるので事前に閉じる
autocmd VimLeave * NERDTreeClose
autocmd VimLeave * mks!

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

nnoremap <leader>p :GFiles<CR>
nnoremap <leader>g :GFiles?<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :RG<CR>
nnoremap <leader>c :Commits<CR>

" coc.nvim
let g:coc_global_extensions = [
      \'coc-solargraph',
      \'coc-sh',
      \'coc-html',
      \'coc-css',
      \'coc-json',
      \'coc-tsserver',
      \'coc-vetur',
      \'coc-pyright', 
      \'coc-go',
      \'coc-solargraph', 
      \'coc-rust-analyzer',
      \'coc-phpls',
      \'coc-angular'
      \]

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

" asdf path
let $PATH = expand('~/.asdf/shims:') . $PATH
let $PATH = expand('~/.asdf/bin:') . $PATH
