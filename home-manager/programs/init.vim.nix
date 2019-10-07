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
" Surround
Plug 'tpope/vim-surround'

" Fuzzy Search
Plug '${pkgs.vimPlugins.fzfWrapper}/share/vim-plugins/fzf'
Plug 'junegunn/fzf.vim'

" Menu
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'


" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

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

" NerdTree
map <C-n> :NERDTreeToggle<CR>

" Helpful stuff
" 
" init.vim
" Source current config while editing: :so %
" Source init.vim from somewhere else: :so $MYVIMRC
"
" Nerdtree
" toggle open close with: ctrl-n
''
