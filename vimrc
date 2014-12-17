set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

Plugin 'fatih/vim-go'
Plugin 'valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'mileszs/ack.vim'
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'samsonw/vim-task'
Plugin 'Raimondi/delimitMate' "auto close quotes, paren, etc
Plugin 'rizzatti/dash.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mattn/emmet-vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'

""""""""" Snippets """""""""""
" Track the engine.
Plugin 'SirVer/ultisnips'
"
" " Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
""""""""""""""""""""""""""""""


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50 " keep 50 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set incsearch  " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" Colors
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

colorscheme railscasts

" Enable the following to keep terminal color
"hi Normal guibg=NONE ctermbg=NONE
hi clear SignColumn


" Show line numbers
set number
set numberwidth=5

" Turn on Mouse Capture
set mouse=a

" Switch wrap off for everything
set formatoptions=tcqw
set nowrap
set textwidth=80
set colorcolumn=80

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Always display the status line
set laststatus=2

" \ is the leader character
let mapleader = ","

" Go mappings
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gbd <Plug>(go-build)
au FileType go nmap <leader>gtst <Plug>(go-test)
au FileType go nmap <leader>gcov <Plug>(go-coverage)
au FileType go nmap <Leader>gdoc <Plug>(go-doc)
au FileType go nmap gds <Plug>(go-def-split)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>s <Plug>(go-implements)

" Swap header and implementation
map <leader>sw :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Run make
map <leader>mr :make<CR>

" Tasks
map <leader>tt :call Toggle_task_status()<CR>

" Don't confirm switching when a buffer is not saved
set hidden

if has("autocmd")
  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text
  autocmd BufNewFile,BufRead todo.txt,*.task,*.tasks,*.todo  setfiletype task

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically load .vimrc source when saved
  autocmd BufWritePost .vimrc source $MYVIMRC

  augroup END
endif

" Hide search highlighting
map <Leader>h :set invhls <CR>

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·
" Delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" Tags
map <Leader>` :TagbarToggle<CR>
set tags=./tags;

" Friendly save - will not re-enter insert mode
nmap <Leader>w :w<CR>
imap <Leader>w <Esc><Leader>w
" will restore visual select
vmap <Leader>w <Esc><Leader>wgv

" Beautification

nmap <Leader>a= :Tabularize decl_assign<CR>
vmap <Leader>a= :Tabularize decl_assign<CR>
nmap <Leader>a: :Tabularize /: <CR>
vmap <Leader>a: :Tabularize /: <CR>

" Configure Ultisnips + YCM to play nice
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

" Local config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
