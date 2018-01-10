syntax on
filetype plugin indent on

" Favourite config

" Use system clipboard
" https://github.com/neovim/neovim/issues/583
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

" " OS X version:
" function! ClipboardYank()
"   call system('pbcopy', @@)
" endfunction
" function! ClipboardPaste()
"   let @@ = system('pbpaste')
" endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p

" Mouse support
set mouse=a

" The leader key
if ! exists("mapleader")
  let mapleader = ","
endif

if ! exists("g:mapleader")
  let g:mapleader = ","
endif

" Esc from insert mode + save the file
imap jj <Esc>:update<cr>

" Open most recent used files
map <leader><Space> :CtrlPMRUFiles<CR>

" Quickly close the active window/tab
map Q ZQ

" Tab configuration
map <C-a> :tabprevious<CR>
map <C-e> :tabnext<CR>
map <leader>n :tabnew<cr>

" Turn backup off, since most stuff is in Git anyway...
set nobackup
set nowb
set noswapfile

" Delete word after the cursor including space after it in insert mode
:imap <C-D> <C-O>dw

" CTRL+K to delete until the end of line
:imap <C-K> <C-O>D

" List buffers
:map gb :buffers<CR>

" Select words in visual mode with Shift+arrows
nmap <S-Right> ve
nmap <S-Left> vb
" Start visual mode in insert mode
imap <S-Right> <Esc><S-Right>
imap <S-Left> <Esc><S-Left>
" Enter insert mode and insert a space
noremap <Space> i<Space>

" Save file and add it to git
map <F5> :Gwrite<CR>
imap <F5> <Esc><F5>

"" End of Favourite config

set nocompatible
set number
set showmode
set smartcase
set smarttab
set smartindent
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set background=dark
set laststatus=0

" No annoying sound on errors
set noerrorbells
set vb t_vb=

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

try
  colorscheme wombat256mod
catch
endtry

" Match wombat colors in nerd tree
hi Directory guifg=#8ac6f2

" Searing red very visible cursor
hi Cursor guibg=red

" Use same color behind concealed unicode characters
hi clear Conceal

hi Keyword ctermfg=darkcyan
hi Constant ctermfg=5*
hi Comment ctermfg=2*
hi Normal ctermbg=none
hi LineNr ctermfg=darkgrey

execute pathogen#infect()

"Open NERDTree when nvim starts
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Toggle NERDTree with Ctrl-N
map <C-n> :NERDTreeToggle<CR>

"Show hidden files in NERDTree
let NERDTreeShowHidden=1

"Use Grepper with Ack
nnoremap <leader>g :Grepper -tool ack<cr>

"haskell-vim settings
let g:haskell_classic_highlighting = 1
let g:haskell_indent_if = 3
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do = 3
let g:haskell_indent_in = 1
let g:haskell_indent_guard = 2
let g:haskell_indent_case_alternative = 1
let g:cabal_indent_section = 2

" Automatically reload on save
au BufWritePost *.hs InteroReload

" Lookup the type of expression under the cursor
au FileType haskell nmap <silent> <leader>t <Plug>InteroGenericType
au FileType haskell nmap <silent> <leader>T <Plug>InteroType
" Insert type declaration
au FileType haskell nnoremap <silent> <leader>nt :InteroTypeInsert<CR>
" Show info about expression or type under the cursor
au FileType haskell nnoremap <silent> <leader>ni :InteroInfo<CR>

" Open/Close the Intero terminal window
au FileType haskell nnoremap <silent> <leader>nn :InteroOpen<CR>
au FileType haskell nnoremap <silent> <leader>nh :InteroHide<CR>

" Map <Esc> to exit terminal-mode:
tnoremap <Esc> <C-\><C-n>

" Simulate |i_CTRL-R| in terminal-mode: >
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Use `ALT+{h,j,k,l}` to navigate windows from any mode: >
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Reload the current file into REPL
au FileType haskell nnoremap <silent> <leader>nf :InteroLoadCurrentFile<CR>
" Jump to the definition of an identifier
au FileType haskell nnoremap <silent> <leader>ng :InteroGoToDef<CR>
" Evaluate an expression in REPL
au FileType haskell nnoremap <silent> <leader>ne :InteroEval<CR>

" Start/Stop Intero
au FileType haskell nnoremap <silent> <leader>ns :InteroStart<CR>
au FileType haskell nnoremap <silent> <leader>nk :InteroKill<CR>

" Ctrl-{hjkl} for navigating out of terminal panes
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

call neomake#configure#automake('w')
let g:neomake_open_list = 2
let g:neomake_haskell_enabled_makers = []

au FileType haskell nmap <leader>c :GhcModSplitFunCase<CR>
au FileType haskell nmap <leader>s :GhcModSigCodegen<CR>

au FileType haskell nnoremap <silent> <leader>i :HsimportSymbol<CR>
au FileType haskell nnoremap <silent> <leader>m :HsimportModule<CR>

let g:hindent_on_save = 0
au FileType haskell nnoremap <silent> <leader>ph :Hindent<CR>

let g:stylishask_on_save = 0
au FileType haskell nnoremap <silent> <leader>ps :Stylishask<CR>

let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc 
let g:necoghc_enable_detailed_browse = 1

" Tabular
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>
