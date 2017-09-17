" Vundle vimrc
"set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

call vundle#end()

filetype plugin indent on "This is required for YCM

" Enable folding. These options slowed vim down quite a bit
"Left out for now as not used so often
"set foldmethod=syntax
"set foldlevel=2

set completeopt=longest,menuone

set clipboard+=unnamed
set paste
set go+=a

"Enabling easy toggle of paste mode
set pastetoggle=<F2>

"Show lnewrapping by indicating \\ for wrapped line
set showbreak=\\\\\
"Allow single j and k movements to treat wrapped lines separately.
"Strict linewise movement resumed when preceeded with a count.
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'


"Enables possible files to be listed when using tab completion with :e <filename-partial><<TAB>>
set wildmenu
set wildmode=full
"Allow fuzzy searching down through folders
set path+=**

"Alignment addon (easy align)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Decrease time between updates (done for GitGutter) (default 4000, i.e. 4 seconds)
set updatetime=250
let g:gitgutter_highlight_lines=1
set diffopt+=vertical "Gdiff split vertical not horizontal

"If loop prevents mutliple calls to syntax on (can mess up highlighting)
if !exists("g:syntax_on")
    syntax enable
endif


set nu "Number lines
set rnu "Relative number lines
"set spell spelllang=en_gb
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth =79
set expandtab
set autoindent "Keep same indentation on new as on previous line
set smartindent
set fileformat=unix
"set ignorecase smartcase "Case insesitive searching
set cursorline "Underline the current line
set incsearch "Search as characters are entered
set hlsearch "Highlight all matches when searching

let mapleader=","
nnoremap <leader><space> :nohlsearch<CR>
set mouse=a
set breakindent "wrapped lines follow indentation

"Shortcuts to switch through buffers with ctrl
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
"Switch between open windows
map <C-h> <C-W><C-h>
map <C-l> <C-W><C-l>

"Key to alievate shitty pasting in vim (press F5 before pasting into vim. Then F5 afterwards to resume normal indentation.
nnoremap <F5> :set invpaste paste?<Enter>
imap <F5> <C-O><F5>
set pastetoggle=<F5>

"" --------- Status line shizzle -------
set laststatus=2 "Always show statusline (deafault: only shown when files open > 1)
"%<number. indicates background colour for that piece of information
set statusline=
set statusline+=%7*\[%n]
set statusline+=%#PmenuSel#
set statusline+=\ %F
set statusline+=\ %{fugitive#statusline()}
""set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
"set statusline+=\ 

execute pathogen#infect()

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"Colour-coded brackets
let g:rainbow_active = 1

"Solarized colour scheme settings
"syntax on
let g:solarized_termcolors=256
set t_Co=256 
set background=dark
colorscheme solarized
