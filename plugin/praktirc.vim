"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  ___________  _____
"  \______    \/  __ \      -- Prakti's .vimrc --
"    \_____   /  /_/ /
"       \____/  ___.'
"           /__/
"
" (c) by Prakti - http://www.prakti.org
"       Inspired by Amix - URL
"               and Mitsuhiko -
"  Tip:
"   If you find anything that you can't understand than do this:
"   help keyword OR helpgrep keywords
"  Example:
"   Go into command-line mode and type helpgrep nocompatible, ie.
"   :helpgrep nocompatible
"   then press <leader>c to see the results, or :botright cw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible

"Sets how many lines of history VIM has to remember
set history=400

"Enable filetype plugin
filetype plugin indent on

"Set to auto read when a file is changed from the outside
set autoread

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :tabe! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable

if has("gui_running")
  set guifont=Monospace\ 10
  colorscheme candycode
  set guioptions-=m
  set guioptions-=T
else
  set background=dark
  colorscheme default
endif

autocmd BufEnter * :syntax sync fromstart

" Highlight cursorline
set cursorline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

set fileencodings=utf-8,latin-1,iso-8859-15
setglobal fileencoding=utf-8
set encoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Backspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch

"Toggle Error-Window
map <leader>w :cwindow<cr>

":nohl shortcut
map <leader>n :nohl<cr>

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""

"Always show the statusline
set laststatus=2

function! CurDir()
   let curdir = substitute(getcwd(), '/home/myself', "~/", "g")
   return curdir
endfunction

"Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c


""""""""""""""""""""""""""""""
" Visual Search with * and #
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving in Tabs 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Use the arrows to switch through tabs
map <right> gt
map <left> gT

"Moving tab-pages
noremap <silent> <M-right>  :if tabpagenr() == tabpagenr("$")\|tabm 0\|el\|exe "tabm ".tabpagenr()\|en<CR>
noremap <silent> <M-left> :if tabpagenr() == 1\|exe "tabm ".tabpagenr("$")\|el\|exe "tabm ".(tabpagenr()-2)\|en<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"Behaviour of automatic buffer switching
set switchbuf=usetab,newtab

"Show tab-line: 0: never, 1: if necessary, 2: always
set stal=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Move a line of text using alt
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

set completeopt=menu,longest

" do simple omnicompletion
inoremap <C-space> <C-X><C-O>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Open a dummy buffer for paste
map <leader>q :tabe ~/buffer<cr>

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set fen
set fdl=2
set foldcolumn=5


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set smarttab
set shiftwidth=2
set lbr
set tw=78

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
set ai
set si
set cindent
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Yank Ring
map <leader>y :YRShow<cr>

" Tag list (ctags)
let Tlist_Sort_Type = "name"
let Tlist_Show_Menu = 1
map <leader>t :Tlist<cr>

autocmd BufRead,BufNew :call TList

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''