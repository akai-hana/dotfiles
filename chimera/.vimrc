source $VIMRUNTIME/defaults.vim

syntax on
set nomodeline
set background=dark
set nocompatible

set bs=2       " Allow backspacing over everything in insert mode
set ai         " Always set auto-indenting on
set history=50 " keep 50 lines of command history
set ruler      " Show the cursor position all the time

" Don't use Ex mode, use Q for formatting
map Q gq

" When doing tab completion, give the following files lower priority.
set suffixes+=.info,.aux,.log,.dvi,.bbl,.out,.o,.lo

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd    " Show (partial) command in status line.
set showmatch  " Show matching brackets.
set ignorecase " Do case insensitive matching
set smartcase  " Do smart case matching
set incsearch  " Incremental search
set autowrite  " Automatically save before commands like :next and :make
set hidden     " Hide buffers when they are abandoned
set mouse=a    " Enable mouse usage (all modes)

" make colors coherent
" (this setting only makes sense with my xresources color palette)
set t_Co=255

" basic number and relative number on the left
set rnu
set nu

"" improve visual mode block indenting
" remains in visual mode after block indenting, to not have to re-enter it every time
vnoremap < <gv
vnoremap > >gv

"" `-clipboard`-compiled vim system clipboard bypass
" lets you copy a register to system clipboard with <"+y> even if your vim
" doesn't have clipboard support (which is the case of lots of default
" distro-provided vim builds)
vnoremap <silent> "+y  y:call  system('xclip -selection clipboard', @")<CR>
nnoremap <silent> "+yy yy:call system('xclip -selection clipboard', @")<CR>
nnoremap <silent> "+y y:call   system('xclip -selection clipboard', @")<CR>

" Plugin list starts here
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'   " 'Think of sensible.vim as one step above nocompatible' -tpope

Plug 'jiangmiao/auto-pairs' " also a sensible default
Plug 'tpope/vim-surround'   " cs'` to change 'text' to `text`

Plug 'ziglang/zig.vim'      " ... Except Zig which doesn't work for some reason

Plug 'mhinz/vim-startify' " better menu screen with numerical file selection history

Plug 'vim-airline/vim-airline'        " Better terminal bottom bar
Plug 'vim-airline/vim-airline-themes' " base16 support (native terminal colors)

Plug 'tpope/vim-commentary'    " `gcc` || `gc<motion>`
Plug 'junegunn/vim-easy-align' " `vipga<symbol>` || `gaip<symbol>`

Plug 'wfxr/minimap.vim' " Cool minimap
Plug 'preservim/nerdtree'

Plug 'Stoozy/vimcord' " discord RPC

call plug#end()

" trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim-easy-align binds setup
" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" minimap and airline xresources theme init
let g:minimap_auto_start = 1      " enable minimap
let g:airline_theme = 'base16'    " Xresources
let g:zig_fmt_autosave = 0        " no auto formatting on file save
