""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                      "
"--------Sections---------                             "
"0. General Options                                    "
"1. Mouse and clipboard settings                       "
"2. Movement keys                                      "
"3. Formatting options                                 "
"4. Search options                                     "
"5. Stautsline modifications                           "
"6. Plugins                                            "
"   - Plug                                             "
"   - Gitgutter                                        "
"   - Solarized                                        "
"   - EasyAlign                                        "
"7. Functions                                          "
"                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"0.General Options                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"If loop prevents mutliple calls to syntax on (can mess up highlighting)
if !exists("g:syntax_on")
    syntax enable
endif

"Define new map leader
let mapleader=","

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)


"Require certain number of lines to be shown below/above cursor
set scrolloff=4
"Do not redraw screen whilst executing macros
set lazyredraw
"Dictate location of new windows after splits
set splitright
set splitbelow

set go+=a


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"1.Mouse and clipboard settings                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set clipboard+=unnamed
"Enable mouse usage
set mouse=a 
"Key to alievate shitty pasting in vim (press F5 before pasting into vim. Then F5 afterwards to resume normal indentation.
nnoremap <F5> :set invpaste paste?<Enter>
inoremap <F5> <C-O><F5>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"2.Movement keys                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Allow single j and k movements to treat wrapped lines separately.
"Strict linewise movement resumed when preceeded with a count.
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

"------- Prevent use of arrow keys  --------
"Normal mode arrow keys
nnoremap <Left> :echo "No left for you!"<CR>
nnoremap <Right> :echo "No right for you!"<CR>
nnoremap <Up> :echo "No up for you!"<CR>
nnoremap <Down> :echo "No down for you!"<CR>
"Visual mode arrow keys
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
"Insert mode arrow keys (doesn't work..?)
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
"Shortcuts to switch through buffers with ctrl
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>
"Switch between open windows
map <C-h> <C-W><C-h>
map <C-l> <C-W><C-l>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"3.Formatting options                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Number current line, and use relative number lines elsewhere
set nu
set rnu 
"New tab formatting
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
"Do not convert tabs to spaces
set noexpandtab
"Maintain indent from current line to next line
set autoindent
"wrapped lines follow indentation
set breakindent 
"Show lnewrapping by indicating \\ for wrapped line
set showbreak=\\\\\
set textwidth =79
set fileformat=unix
set cursorline "Underline the current line


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"4.Search options                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Highlight all matches when searching
set hlsearch 
nnoremap <leader><space> :nohlsearch<CR>
set incsearch "Search as characters are entered
"Enable autocompletion
"longest inserts the longest common text
"menu ensures a menu still pops up, even if only one selection is shown
set completeopt=longest,menuone
"Enables possible files to be listed when using tab completion with :e <filename-partial><<TAB>>
set wildmenu
set wildmode=full
"Allow fuzzy searching down through folders
set path+=**
"Case insenstive searching
set ignorecase
"Disable ignorecase IF capitals used in search pattern
set smartcase

"Center page when searching for matching bracket
nnoremap } }zz
nnoremap { {zz

"Show buffers, then press number of wanted buffer
nnoremap <leader><leader> :buffers<cr>:buffer<space>

"Easy acces to Explore and Sexplore
noremap <leader>e :Explore<cr>
noremap <leader>s :Sexplore<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"5.Statusline modification                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2 "Always show statusline (deafault: only shown when files open > 1)
set statusline=
set statusline+=%7*\[%n]
set statusline+=%#PmenuSel#
set statusline+=\ %F
set statusline+=\ %{fugitive#statusline()}
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"6.Plugins                                             " 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged/')

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'altercation/vim-colors-solarized'

Plug 'junegunn/vim-easy-align'

Plug 'luochen1990/rainbow'

"Initialise plug system
call plug#end()

"--------GitGutter-------
"Decrease time between updates (done for GitGutter) (default 4000, i.e. 4 seconds)
set updatetime=250
let g:gitgutter_highlight_lines=1
set diffopt+=vertical "Gdiff split vertical not horizontal

"--------Solarized-------
let g:solarized_termcolors=256
set t_Co=256 
set background=dark
colorscheme solarized

"--------EasyAlgin--------
"Alignment addon (easy align)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Colour-coded brackets
let g:rainbow_active = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"7.Functions                                           " 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Function to toggle kTRUE and kFALSE in code
function! Toggle()
    let word = expand("<cword>")
    if word == "kFALSE"
        echo "kTRUE"
        return "kTRUE"
    elseif word == "kTRUE"
        echo "kFALSE"
        return "kFALSE"
    endif
endfunction
