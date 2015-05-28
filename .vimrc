" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

set bs=2                " Allow backspacing over everything in insert mode
set history=500         " keep 500 lines of command history
set shiftwidth=4	" When (un)indenting lines, move them by 4 spaces
set tabstop=4		" use tab width of 8 spaces
set expandtab		" Replace tabs with spaces
set autowrite		" Automatically save changes when compiling
set foldmethod=marker	" Fold against a mark character
set foldmarker={{,}}  	" fold based on double braces
set fillchars=      	" fill folds with blanks


" Make Vim more useful
set nocompatible

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Enhance command-line completion
set wildmenu

" Allow cursor keys in insert mode
set esckeys

" Allow backspace in insert mode
set backspace=indent,eol,start

" Optimize for fast terminal connections
set ttyfast

" Add the g flag to search/replace by default
set gdefault

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Change mapleader
let mapleader=","

" Don’t add empty newlines at the end of files
set binary
set noeol

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" A couple of commands for auto-commenting and uncommenting
map _bc :s/\(.*\)/# \1/:nohlsearch
map _bu :s/^[ \t]*#[ ]\?//:nohlsearch

map _cc :s#\(.*\)#// \1#:nohlsearch
map _cu :s#^[ \t]*//[ ]\?##:nohlsearch

map _vc :s#\(.*\)#" \1#:nohlsearch
map _vu :s/^[ \t]*"[ ]\?//:nohlsearch

map _mc :s#\(.*\)#> \1#:nohlsearch
map _mu :s/^[ \t]*>[ ]\?//:nohlsearch

map _tc :s#\(.*\)#% \1#:nohlsearch
map _tu :s/^[ \t]*%[ ]\?//:nohlsearch

" solaris special key bindings
map [26~ u		" <undo> key
map [24~ :redo	" <again> key

" windows key bindings 
map [5~ 
map [6~ 
map 0H 0
map OF $
map [2~ :set paste!
map [3~ x

" Command fixes for annoying weird capitalization issues
command! Q q
command! W w
command! Wq wq
command! WQ wq

" VIM-Shell
" Ctrl_W e opens up a vimshell in a horizontally split window
" Ctrl_W E opens up a vimshell in a vertically split window
" The shell window will be auto closed after termination
nmap <C-W>e :new \| vimshell bash<CR>
nmap <C-W>E :vnew \| vimshell bash<CR>

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Terminal specific settings
if &term=="linux" || &term=="xterm" || &term=="xterm-color" || &term=="vt100"
  set t_RV=			" don't check terminal version
  set t_Co=8
  set t_Sb=[4%dm
  set t_Sf=[3%dm
  set hlsearch
endif

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on

	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

    autocmd BufNewFile,BufRead *.c source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.h source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.cc source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.cpp source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.hpp source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.java source ~/.vimrc-java
    autocmd BufNewFile,BufRead *.txt source ~/.vimrc-txt
    autocmd BufNewFile,BufRead *.tex source ~/.vimrc-tex
endif
