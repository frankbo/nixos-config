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

" Testing
Plug 'janko/vim-test'

" Surround
Plug 'tpope/vim-surround'

" Fuzzy Search
Plug '${pkgs.vimPlugins.fzfWrapper}/share/vim-plugins/fzf'
Plug 'junegunn/fzf.vim'

" Menu
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Generall Syntax
Plug 'sheerun/vim-polyglot'

" Autosave
Plug '907th/vim-auto-save'

" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
 
" Comments
Plug 'scrooloose/nerdcommenter'

" Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'

" TS
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['typescript', 'typescript.tsx'] }
Plug 'maxmellon/vim-jsx-pretty'

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

" not for haskell
let g:polyglot_disabled = ['haskell']

" Enable autosave on startup
let g:auto_save = 1

" --------------- Coc Settings start -----------

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','''''')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" --------------- Coc Settings End -------------

" --------------- Mappings ---------------------

" Autoformat with prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Leader mapping
map <Space> <Leader>

" FZF mappings
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fr :Tags<CR>

nnoremap <Leader>fa :Rg<CR>

nnoremap <Leader>; :Buffers<CR>
nnoremap <Leader>fg :GitFiles<CR>

" Git 
" Open vimagit pane
nnoremap <Leader>gb :Gblame<CR>      " git blame

" Testing
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestFile<CR>


" NerdTree
nnoremap <Leader>n :NERDTreeFind<CR>

" Nerdcomment
let g:NERDCreateDefaultMappings = 0
nmap <leader>cc <plug>NERDCommenterToggle

" GitGutter
" Jump between hunks
nmap <Leader>gn :GitGutterNextHunk<CR>  " git next
nmap <Leader>gp :GitGutterPrevHunk<CR>  " git previous

" Magit Coc stuff
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ----------------- Helpful stuff ---------------------------
" 
" init.vim
" Source current config while editing: :so %
" Source init.vim from somewhere else: :so $MYVIMRC
"
" Nerdtree
" toggle open close with: ctrl+n
" nerdtree find open with space + n, close with q
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
" Jump between splits with ctrl+w ctrl+j or k 
"
" Pick next or previous in dropdown with ctrl + n and ctrl + p. Select with ctrl + y
"
" GitGutter
" preview, stage, and undo hunks with <leader>hp, <leader>hs, and <leader>hu 
''

