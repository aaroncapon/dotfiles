""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                      "
"Plugin manager:[https://github.com/junegunn/vim-plug] "
"                                                      "
"            --------Sections---------                 "
"            0. General Options                        "
"            1. Mouse and clipboard settings           "
"            2. Movement keys                          "
"            3. Formatting options                     "
"            4. Search options                         "
"            5. Stautsline modifications               "
"            6. Plugins                                "
"            7. Functions                              "
"                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"0.General Options                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"If loop prevents mutliple calls to syntax on (can mess up highlighting)
if !exists("g:syntax_on")
    syntax enable
endif

"Detect filetype
filetype on

"Define new map leader
let mapleader=","

"Quick acces to vimrc
nnoremap <F5> :e $MYVIMRC<CR>
"Reload vimrc
nnoremap <F6> :so $MYVIMRC<CR>

"Exit insert mode from homerow
inoremap jk <Esc>

highlight ColorColumn ctermbg=magenta
"Put Colourcolum in augroup to ensure it is applied to all windows
augroup colourZ
	autocmd!
	autocmd WinEnter,BufEnter * :call matchadd('ColorColumn', '\%81v', 100)
augroup END

"Require certain number of lines to be shown below/above cursor
set scrolloff=4
"Do not redraw screen whilst executing macros
set lazyredraw
"Dictate location of new windows after splits
set splitright
set splitbelow

set go+=Autoselect

"Folding method based on indent of code
set foldmethod=indent
set foldlevel=99

"Do not require save before switching buffers
set hidden


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             1.Mouse and clipboard settings           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set clipboard^=unnamed
"Enable mouse usage
set mouse=a


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 2.Movement keys                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Allow single j and k movements to treat wrapped lines separately.
"Strict linewise movement resumed when preceeded with a count.
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

"Remap H and L to SOF and EOL
nnoremap H ^
nnoremap L $

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
noremap <C-J> :bnext<CR>
noremap <C-K> :bprev<CR>
"Switch between open windows
noremap <C-h> <C-W><C-h>
noremap <C-l> <C-W><C-l>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              3.Formatting options                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Number current line, and use relative number lines elsewhere
set nu
set rnu
"Show existing tab with 2 spaces width
set tabstop=2
"When indenting with '>', use 2 spaces width
set shiftwidth=2
"How many spaces are used in insert mode
set softtabstop=2
"Do not convert tabs to spaces
set noexpandtab
"Maintain indent from current line to next line
set autoindent
"Wrapped lines follow indentation
set breakindent
"Show lnewrapping by indicating \\ for wrapped line
set showbreak=\\\\\
set textwidth =80
set fileformat=unix
"Underline the current line
set cursorline
"Disable auto comment insertion on new lines
set formatoptions -=cro

"Set characters that indicate tabs, trailing space etc
set listchars=trail:~
set list

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 4.Search options                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Highlight all matches when searching
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>
"Search as characters are entered
set incsearch
"Enable autocompletion
"longest inserts the longest common text
"menu ensures a menu still pops up, even if only one selection is shown
set completeopt=longest,menuone
"Enables possible files to be listed when using tab completion with :e <filename-partial><<TAB>>
set wildmenu
set wildmode=full
"Allow fuzzy searching down through folders
set path+=**


"Recursively search for ctags file up to root folder until one is found
set tags+=./tags,tags;

"Show buffers, then press number of wanted buffer
nnoremap <leader><leader> :buffers<cr>:buffer<space>

"Easy acces to Explore and Sexplore
noremap <leader>e :Explore<cr>
noremap <leader>s :Lexplore<cr>
"Netrw options
"Restrict window size
let g:netrw_winsize = -28
"Remove netrw banner
let g:netrw_banner = 0
"Use tree style listing for files
let g:netrw_liststyle = 3
"Directories on top and files below
let g:netrw_sort_sequence = '[\/]$,*'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              5.Statusline modification               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2 "Always show statusline (deafault: only shown when files open > 1)
set statusline=
set statusline+=%7*\[%n]
set statusline+=%#PmenuSel#
set statusline+=\%F
set statusline+=\%{fugitive#statusline()}
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\%y
set statusline+=\%{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\%p%%
set statusline+=\%l:%c


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  6.Plugins                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged/')

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow'
Plug 'NLKNguyen/papercolor-theme'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'w0rp/ale'

"Initialise plug system
call plug#end()

"--------GitGutter-------
"Decrease time between updates (done for GitGutter) (default 4000, i.e. 4 seconds)
set updatetime=250
"let g:gitgutter_highlight_lines=1
set diffopt+=vertical "Gdiff split vertical not horizontal

colorscheme PaperColor
set background=dark
"Alter colours of folds
highlight Folded ctermbg=darkblue
highlight Folded ctermfg=blue


"--------EasyAlgin--------
"Alignment addon (easy align)
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"Colour-coded brackets (Rainbow)
let g:rainbow_active = 1

"------cpp highlighting -------"
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                7.Functions                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Function to toggle kTRUE and kFALSE in code
function! Toggle()
	let cursor_pos = getpos('.')
	normal! ^
	let returnVal = search("kFALSE", "e", line("."), "stopline")
	if returnVal != 0
		echo "kTRUE"
		normal! ciw kTRUE
		call setpos('.', cursor_pos)
		return
	endif
	let returnVal = search("kTRUE", "e", line("."), "stopline")
	if returnVal != 0
		echo "kFALSE"
		normal! ciw kFALSE
		call setpos('.', cursor_pos)
		return
	endif
	echo "ROOT boolean not found on line!"
	call setpos('.', cursor_pos)
	return
endfunction

nnoremap <leader>C :call Toggle()<CR>

"Function to removes trailing whitespaces
function! TrimWhitespace()
	let l:save = winsaveview()
	%s/\s\+$//e
	call winrestview(l:save)
endfunction

command! TrimWhitespace call TrimWhitespace()
