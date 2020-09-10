" Vundle stuff
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Git
Plugin 'tpope/vim-fugitive'

" Pretty things
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'Yggdroot/indentLine'
Plugin 'Raimondi/delimitMate'
Plugin 'lilydjwg/colorizer'

Plugin 'udalov/kotlin-vim'

Plugin 'itchyny/lightline.vim'
set noshowmode " configuration for Lightline

" Linting
"Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_check_on_wq = 1

" Work flow
" Plugin 'airblade/vim-rooter'
" Plugin 'kien/ctrlp.vim'

" Scss
" Plugin 'cakebaker/scss-syntax.vim'

" Ruby
" Plugin 'tpope/vim-rails'


" Json
Plugin 'elzr/vim-json'

" Go
" Plugin 'fatih/vim-go'

" PHP
" Plugin 'StanAngeloff/php.vim'

" JS
" Plugin 'heavenshell/vim-jsdoc'

call vundle#end()
filetype plugin indent on

set shell=/bin/zsh


" Set up syntax highlighting
set background=dark
colorscheme badwolf
syntax on

set autowrite		" Automatically save changes when compiling
set backspace=indent,eol,start " Allow backspace in insert mode
set binary " Don’t add empty newlines at the end of files
set bs=2                " Allow backspacing over everything in insert mode
set clipboard=unnamed " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set completeopt=menu,menuone
set confirm
set cursorline " Highlight current line
set encoding=utf-8 nobomb " Use UTF-8 without BOM
set esckeys " Allow cursor keys in insert mode
set expandtab		" Replace tabs with spaces
set exrc " Enable per-directory .vimrc files and disable unsafe commands in them
set fillchars=      	" fill folds with blanks
set foldcolumn=4 " Column to show folds
set nofoldenable " Disable folding"
set foldlevel=2
set foldmethod=syntax " Markers are used to specify folds.
set foldminlines=0 " Allow folding single lines
set foldnestmax=3 " Set max fold nesting level
set formatoptions+=1 " Break before 1-letter words
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=c " Format comments
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=n " Recognize numbered lists
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=r " Continue comments by default
set formatoptions=
set hidden " When a buffer is brought to foreground, remember undo history and marks.
set history=1000         " keep more lines of command history
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Highlight dynamically as pattern is typed
set laststatus=2 " Always show status line
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_ " Show “invisible” characters
set linespace=3
set lispwords+=defroutes " Compojure
set lispwords+=defpartial,defpage " Noir core
set lispwords+=defaction,deffilter,defview,defsection " Ciste core
set lispwords+=describe,it " Speclj TDD/BDD
set list
set magic " Enable extended regexes.
set modeline " Respect modeline in files
set modelines=4 
set mouse=a " Enable mouse in all modes
set noeol
set noerrorbells " Disable error bells
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.
set nostartofline " Don’t reset cursor to start of line when moving around.
set nowrap " Do not wrap lines.
set number " Enable line numbers
set ofu=syntaxcomplete#Complete " Set omni-completion method.
set report=0 " Show all changes.
" set ruler " Show the cursor position
set scrolloff=5 " Start scrolling three lines before the horizontal window border
set secure
set sidescrolloff=3 " Start scrolling three columns before vertical border of window.
set shiftwidth=4	" When (un)indenting lines, move them by 4 spaces
set shortmess=atI " Don’t show the intro message when starting Vim
set showcmd " Show the (partial) command as it’s being typed
" set showmode " Show the current mode
set showtabline=2 " Always show tab bar.
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters.
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
set softtabstop=4 " Tab key results in X spaces
set tabstop=4 " use tab width of X spaces
set title " Show the filename in the window titlebar
set ttyfast " Optimize for fast terminal connections
set ttymouse=xterm " Set mouse type to xterm.
set undofile " Persistent Undo.
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/smarty/*,*/vendor/*,*/node_modules/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*
set wildmenu " Enhance command-line completion
set wildmode=list:longest " Complete only until point of ambiguity.
set winminheight=0 "Allow splits to be reduced to a single line.
set wrapscan " Searches wrap around end of file

let mapleader="," " Change mapleader

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" solaris special key bindings
map [26~ u		" <undo> key
map [24~ :redo
	" <again> key

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

" Clear last search (,qs)
map <silent> <leader>qs <Esc>:noh<CR>
" map <silent> <leader>qs <Esc>:let @/ = ""<CR>

" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

" Buffer navigation (,,) (,]) (,[) (,ls)
map <Leader>, <C-^>
" :map <Leader>] :bnext<CR>
" :map <Leader>[ :bprev<CR>
map <Leader>ls :buffers<CR>

" Close Quickfix window (,qq)
map <leader>qq :cclose<CR>

" Insert newline
map <leader><Enter> o<ESC>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" Join lines and restore cursor location (J)
nnoremap J mjJ`j

" Toggle folds (<Space>)
nnoremap <silent> <space> :exe 'silent! normal! '.((foldclosed('.')>0)? 'zMzx' : 'zc')<CR>

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

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

if &term=="xterm-256color"
    set t_Co=256
endif


" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on

    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    autocmd BufNewFile,BufRead *.gradle set syntax=groovy

    autocmd BufNewFile,BufRead *.c source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.h source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.cc source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.cpp source ~/.vimrc-c
    autocmd BufNewFile,BufRead *.hpp source ~/.vimrc-c

    autocmd BufNewFile,BufRead *.java source ~/.vimrc-java

    autocmd BufNewFile,BufRead *.js source ~/.vimrc-js

    autocmd BufNewFile,BufRead *.txt source ~/.vimrc-txt
    autocmd BufNewFile,BufRead *.md source ~/.vimrc-txt

    autocmd BufNewFile,BufRead *.md source ~/.vimrc-md

    autocmd BufNewFile,BufRead *.tex source ~/.vimrc-tex
endif
