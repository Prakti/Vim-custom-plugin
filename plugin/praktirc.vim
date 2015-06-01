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
map <leader>s :source ~/.vim/bundle/Vim-custom-plugin/plugin/praktirc.vim<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vim/bundle/Vim-custom-plugin/plugin/praktirc.vim<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost praktirc.vim source ~/.vim/bundle/Vim-custom-plugin/plugin/praktirc.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable

if has("gui_running")
  set guifont=Monospace\ 10
  colorscheme jellybeans
  set background=dark
  set guioptions-=m
  set guioptions-=T
  set guioptions-=e
else
  set background=dark
  colorscheme jellybeans
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
" Moving in Buffers and Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Use the arrows to switch through buffers
map <right> :bn<cr>
map <left> :bp<cr>

"Use Control-Arrows to switch tabs
map <C-right> gt
map <C-left> gT

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
" Create toggling for error-window on per-buffer base
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle window on
function! EWinOn() "Toggle on
  cwindow
  map <buffer> <leader>w :call EWinOff()<cr>
endfunction

" Toggle window off
function! EWinOff()
  cclose
  map <buffer> <leader>w :call EWinOn()<cr>
endfunction

" Put everything into place
map <leader>w :call EWinOn()<cr>


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

" NERDTree
autocmd BufRead,BufNew :call NERDTree
map <leader>t :NERDTreeToggle<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRL-P Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_map = '<c-f>'

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.git\|^\.coffee\|^vendor'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.space = "\ua0"

let g:airline_right_alt_sep = "\uf053"
let g:airline_left_alt_sep = "\uf054"
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.branch = "\uf126"
let g:airline_symbols.readonly = "\uf023"
let g:airline_symbols.linenr = "\uf0da"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP Syntax Override
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PhpSyntaxOverride()
  hi! def link phpDocTags  phpDefine
  hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
  autocmd!
  autocmd FileType php call PhpSyntaxOverride()
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ultisnips configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

let g:UltiSnipsEditSplit = "vertical"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Display trailing whitespace as an errror:
match ErrorMsg '\s\+$'

"Automatically remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''
