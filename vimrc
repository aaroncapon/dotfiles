"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                       "
" Plugin manager:[https://github.com/junegunn/vim-plug] "
"                                                       "
"            --------Sections---------                  "
"            0. General Options                         "
"            1. Mouse and clipboard settings            "
"            2. Movement keys                           "
"            3. Formatting options                      "
"            4. Search options                          "
"            5. Stautsline modifications                "
"            6. Plugins                                 "
"            7. Functions                               "
"                                                       "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  0.General Options                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" If loop prevents mutliple calls to syntax on (can mess up highlighting)
if !exists(" g:syntax_on" )
	syntax enable
endif

" Detect filetype
filetype on

" Quick acces to vimrc
nnoremap <F5> :e $MYVIMRC<CR>
" Reload vimrc
nnoremap <F6> :so $MYVIMRC<CR>

" Exit insert mode from homerow
inoremap jk <Esc>

highlight ColorColumn ctermbg=magenta
" Put Colourcolum in augroup to ensure it is applied to all windows
augroup colourZ
	autocmd!
	autocmd WinEnter,BufEnter * :call matchadd('ColorColumn', '\%81v', 100)
augroup END

" Require certain number of lines to be shown below/above cursor
set scrolloff=4
" Do not redraw screen whilst executing macros
set lazyredraw
" Dictate location of new windows after splits
set splitright
set splitbelow

" Enable simple copy/pasting from visual mode (when using vim GUI)
set guioptions+=Autoselect

" Folding method based on indent of code
set foldmethod=indent
set foldlevel=99

" Do not require save before switching buffers
set hidden

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"             1.Mouse and clipboard settings           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set clipboard^=unnamed
" Enable mouse usage
set mouse=a
" If pasting from default register, do not replace buffer with visual selection
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 2.Movement keys                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allow single j and k movements to treat wrapped lines separately.
" Strict linewise movement resumed when preceeded with a count.
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Remap H and L to SOF and EOL
nnoremap H ^
nnoremap L $

" ------- Prevent use of arrow keys  --------
" Normal mode arrow keys
nnoremap <Left> :echo " No left for you!" <CR>
nnoremap <Right> :echo " No right for you!" <CR>
nnoremap <Up> :echo " No up for you!" <CR>
nnoremap <Down> :echo " No down for you!" <CR>
" Visual mode arrow keys
vnoremap <Left> :<C-u>echo " No left for you!" <CR>
vnoremap <Right> :<C-u>echo " No right for you!" <CR>
vnoremap <Up> :<C-u>echo " No up for you!" <CR>
vnoremap <Down> :<C-u>echo " No down for you!" <CR>
" Insert mode arrow keys (doesn't work..?)
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
" Shortcuts to switch through buffers with ctrl
noremap <C-J> :bnext<CR>
noremap <C-K> :bprev<CR>
" Switch between open windows
noremap <C-h> <C-W><C-h>
noremap <C-l> <C-W><C-l>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              3.Formatting options                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Number current line, and use relative number lines elsewhere
"  set nu
"  set rnu
" Show existing tab with 2 spaces width
set tabstop=2
" When indenting with '>', use 2 spaces width
set shiftwidth=2
" How many spaces are used in insert mode
set softtabstop=2
" Convert tabs to spaces
set expandtab
" Maintain indent from current line to next line
set autoindent
" Wrapped lines follow indentation
set breakindent
" Show lnewrapping by indicating \\ for wrapped line
set showbreak=\\\\\
set textwidth =80
set fileformat=unix
" Underline the current line
set cursorline
" Round indent to multiple of 'shiftwidth'
set shiftround
" Dsiable comment autowrapping, auto insertion of comment leader
autocmd FileType * set formatoptions -=cro


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 4.Search options                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight all matches when searching
set hlsearch
" Mapping to turn of highlighted search results
nnoremap <SPACE><CR> :nohlsearch<CR>
" Search as characters are entered
set incsearch
" Enable autocompletion
" longest inserts the longest common text
" menu ensures a menu still pops up, even if only one selection is shown
" preview shows function attributes in scratch buffer
set completeopt=longest,menuone,preview
" Auto close preview scratch buffer
autocmd CompleteDone * pclose
" Enables possible files to be listed when using tab completion with :e <filename-partial><<TAB>>
set wildmenu
set wildmode=full
" Allow fuzzy searching down through folders
set path+=**

" Always open quickfix window after :make, :grep, etc
augroup openQuickFixWindow
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost l*    lwindow
augroup END

" Recursively search for ctags file up to root folder until one is found
set tags+=./.ctags,.ctags;
" If working on C files, load extra tags files
set tags+=/home/aaron/AliPhysics-ROOT-scripts/.ctags
set tags+=/home/aaron/alice/AliPhysics/.ctags 
set tags+=/home/aaron/repositories/root/.ctags 
" Remap standard bindings to produce list if multiple matches
" Otherwise jump striaght to definition
nnoremap <C-]> g<C-]>
" Specify correct syntax highlighting of ctag files
autocmd BufNewFile,BufRead .ctags set syntax=tags

" Show buffers, then press number of wanted buffer
nnoremap ,, :buffers<cr>:buffer<space>

" Easy acces to Explore and Sexplore
noremap ,e :Explore<cr>
noremap ,s :Lexplore<cr>
" Netrw options
" Restrict window size
let g:netrw_winsize = -28
" Remove netrw banner
let g:netrw_banner = 0
" Use tree style listing for files
let g:netrw_liststyle = 3
" Directories on top and files below
let g:netrw_sort_sequence = '[\/]$,*'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              5.Statusline modification               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2 " Always show statusline (deafault: only shown when files open > 1)
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

Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/tpope/vim-dispatch'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/luochen1990/rainbow'
Plug 'https://github.com/octol/vim-cpp-enhanced-highlight'
Plug 'https://github.com/nanotech/jellybeans.vim'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/semanser/vim-outdated-plugins'
" Install fzf on system from Plug
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/tpope/vim-obsession'
" Initialise plug system
call plug#end()

" --------- fzf -----------
nnoremap ,f :Files<CR>

" --------Easy motion ------
let g:EasyMotion_do_mapping = 0
map <SPACE>w <Plug>(easymotion-w)
map <SPACE>b <Plug>(easymotion-b)
map <SPACE>s <Plug>(easymotion-s2)

" --------GitGutter-------
" Decrease time between updates (done for GitGutter) (default 4000, i.e. 4 seconds)
set updatetime=250
" let g:gitgutter_highlight_lines=1
set diffopt+=vertical " Gdiff split vertical not horizontal
" Hunk mappings
nmap <SPACE>ha <Plug>GitGutterStageHunk
nmap <SPACE>hr <Plug>GitGutterUndoHunk

colorscheme jellybeans
" Alter colours of folds
highlight Folded ctermbg=darkblue
highlight Folded ctermfg=blue


" --------EasyAlgin--------
" Alignment addon (easy align)
"  Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"  Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Colour-coded brackets (Rainbow)
let g:rainbow_active = 1

" ------cpp highlighting -------" 
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                7.Functions                           "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function to toggle ROOT boolean
" Need only have cursor on the same line
nnoremap ,C :call Toggle()<CR>

" Trim all trailing white spaces
command! TrimTrailingWhiteSpace call TrimTrailingWhiteSpace()
