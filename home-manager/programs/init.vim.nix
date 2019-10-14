{ pkgs, ... }:

''
source ${pkgs.vimPlugins.vim-plug.rtp}/plug.vim
" Pluigins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'

" Oceanic Theme
Plug 'mhartington/oceanic-next'

" Bottom bar
Plug 'vim-airline/vim-airline'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'

" Surround
Plug 'tpope/vim-surround'

" Fuzzy Search
Plug '${pkgs.vimPlugins.fzfWrapper}/share/vim-plugins/fzf'
Plug 'junegunn/fzf.vim'

" Menu
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Generall Syntax
" Plug 'sheerun/vim-polyglot'

" Autosave
Plug '907th/vim-auto-save'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

" Comments
Plug 'scrooloose/nerdcommenter'

" TS
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'typescript.tsx'] }

" Plug 'leafgarland/typescript-vim'
" Plug 'peitalin/vim-jsx-typescript'


" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" For nvim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
set background=dark
set mouse=a

" Split bottom or right
set splitbelow
set splitright

" no numbers in term
au TermOpen * setlocal nonumber norelativenumber

" set t_Co=256  " The option is needed for vim 7
syntax enable
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

let g:airline_theme='oceanicnext'

" Display
set number
set ruler
set wrap

" not for haskell and ts on
" let g:polyglot_disabled = ['haskell', 'typescript', 'typescript.tsx', 'scala']

" Enable autosave on startup
let g:auto_save = 1
" --------------- Mappings ---------------------

" Leader mapping
map <Space> <Leader>

" FZF mappings
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fr :Tags<CR>

nnoremap <Leader>fa :Ag<CR>

nnoremap <Leader>; :Buffers<CR>
nnoremap <Leader>fg :GitFiles<CR>

" Git 
" Open vimagit pane
nnoremap <leader>gs :Magit<CR>       " git status
nnoremap <Leader>gb :Gblame<CR>      " git blame

" NerdTree
nnoremap <Leader>y :NERDTreeFind<CR>
map <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>

" Navigate between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Nerdcomment
let g:NERDCreateDefaultMappings = 0
nmap <leader>cc <plug>NERDCommenterToggle

" GitGutter
" Jump between hunks
nmap <Leader>gn <Plug>GitGutterNextHunk  " git next
nmap <Leader>gp <Plug>GitGutterPrevHunk  " git previous

" ----------------- Helpful stuff ---------------------------
" 
" init.vim
" Source current config while editing: :so %
" Source init.vim from somewhere else: :so $MYVIMRC
"
" Nerdtree
" toggle open close with: space + n or ctrl+n
" nerdtree find open with space + y, close with q
"
" Buffers
" space + ;
" splint horizontally from buffer search ctrl + x
" splint vertically from buffer search ctrl + v
" open from fzf buffer inn new tab ctrl + t
"
" Vim surround
" ysiw] you surround inner word ]
" cs'" change surrounding from ' to "
"
" Comments
" Leader cc comment
" Leader cu uncomment
"
" Jump marks 
" Jump to previous ctrl + o for older jumps and ctrl + i for next jumps
"
" GitGutter
" preview, stage, and undo hunks with <leader>hp, <leader>hs, and <leader>hu 
''

