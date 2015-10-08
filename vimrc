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
Plugin 'tpope/vim-abolish'
Plugin 'scrooloose/syntastic'
Plugin 'marijnh/tern_for_vim'
Plugin 'wavded/vim-stylus.git'
Plugin 'peterhoeg/vim-qml'
Plugin 'vim-scripts/dbext.vim'
Plugin 'farseer90718/vim-taskwarrior'
Plugin 'rking/ag.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-scripts/loremipsum'
Plugin 'wakatime/vim-wakatime'
Plugin 'tpope/vim-dispatch'
Plugin 'janko-m/vim-test'
Plugin 'FredKSchott/CoVim'


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

" disable completopt preview
set completeopt=menuone

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

" Run Make - this runs the !make
map <leader>mk :Make<CR>
map <leader>mkr :Make run<CR>

" Run make - this runs makeprg
map <leader>r :make<CR>

" Tasks
map <leader>tt :call Toggle_task_status()<CR>

" Don't confirm switching when a buffer is not saved
set hidden

if has("autocmd")
  " Set File type to 'text' for files ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text
  autocmd BufNewFile,BufRead todo.txt,*.task,*.tasks,*.todo  setfiletype task
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript

  " Enable soft-wrapping for text files
  autocmd FileType text,markdown,html,xhtml,eruby setlocal wrap linebreak nolist

  " Enable indent folds for tasks
  autocmd FileType task set foldmethod=indent

  " Enable indent folds for qml
  autocmd FileType qml set foldmethod=indent

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
"set list listchars=tab:»·,trail:·
" Delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Use Ag instead of Grep when available
if executable("ag")
  set grepprg="ag --vimgrep"
  let g:ackprg = 'ag --vimgrep'
endif

" Enable Ninja if available
if executable("ninja") && filereadable("./build.ninja")
  command! Ninja execute "!ninja"
  set makeprg=ninja
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
nmap <Leader>a: :Tabularize /:/l2r2<CR>
vmap <Leader>a: :Tabularize /:/l2r2<CR>

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

" Let YCM load config files in code folder automatically
let g:ycm_extra_conf_globlist = ['~/code/*','!~/*']
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1


" Change CamelCase to snake_case
nmap <Leader>cts :s#\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<CR>
vmap <Leader>cts :s#\%V\(\<\u\l\+\\|\l\+\)\(\u\)#\l\1_\l\2#g<CR>

" Ctrl-P Hide build/dist folders
let g:ctrlp_custom_ignore = '\v(build|dist|tmp|bower_components|node_modules|cordova|build_cache|Godeps)$'

" Setup Vim Test
let test#strategy = "dispatch"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" Use Go Imports
let g:go_fmt_command = "goimports"

" Collaborative Vim
let CoVim_default_name = "kayle"
let CoVim_default_port = "1337"

" Project Specific VimRC
set exrc
set secure
