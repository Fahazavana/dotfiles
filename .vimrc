" VIM Configuration - Fahazavana (RJL)
" Annulation de la compatibilité avec l'ancetra VI
set nocompatible



""""""""""""""""""""""""""""""""""""""""
"  	PLUGIN
""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall | q
endif

" My plugins
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'mattn/emmet-vim'
Plug 'vim-syntastic/syntastic'
Plug 'ctrlpvim/ctrlp.vim' "Fuzzy file finder
Plug 'mileszs/ack.vim'	 "Ack content file finder
Plug 'ryanoasis/vim-devicons'
" Plug 'terryma/vim-multiple-cursors' "CTRL +N Deprecated
Plug 'mg979/vim-visual-multi'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'frazrepo/vim-rainbow'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tc50cal/vim-terminal'
Plug 'preservim/tagbar' "Vim plugin that displays tags in a window, ordered by scope
"molokai theme plugin
Plug 'tomasr/molokai'
Plug 'glepnir/dashboard-nvim'
Plug 'https://github.com/folke/which-key.nvim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
set encoding=UTF-8
call plug#end()



""""""" PLUGIN SETTING """"""
" Theme de couleur 
set background=dark 
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

"Coc Sett
let g:coc_global_extension=[
			\ 'coc-snippets',
			\ 'coc-pairs',
			\ 'coc-tsserver',
			\'coc-pyright',
			\'coc-vimtex',
			\'coc-html',
			\'coc-prettier']



" Demmarage automatique de NERDTree
" autocmd VimEnter * NERDTree


""""""""""""""""""""""""""""""
" -- AFFICHAGE
" Met a jour le titre de votre fenetre ou de " votre terminal 

set title 

" Affiche le numero des lignes
set number  
set relativenumber

" Affiche la position actuelle du curseur
set ruler

" Affiche les lignes trop longues sur plusieurs
set wrap 

" Affiche un minimum de 3 lignes autour du curseur " (pour le scroll)
set scrolloff=3  

" -- RECHERCHE 

" Ignore la casse lors d’une recherche
set ignorecase


" Si une recherche contient une majuscule, 
" re-active la sensibilite a la casse   
set smartcase 

" Surligne les resultats de recherche pendant la saisie 
set incsearch

" Surligne les resultats de recherche 
set hlsearch 

" -- Beep 

" Empeche Vim de beeper 
set visualbell 
set noerrorbells 

" Active le comportement ’habituel’ de la touche retour en arriere
set backspace=indent,eol,start 

" Cache les fichiers lors de l’ouverture d’autres fichiers set hidden



" Active la coloration syntaxique 
syntax enable 

" Active les comportements specifiques aux types de fichiers comme la syntaxe et l’indentation 
filetype on 
filetype plugin on 
filetype indent on



" Font setting
"set guifont=Monaco:h13 
"set antialias



"""""""""""""""
" KEY MAPPING "
"""""""""""""""
" QUITTER le mode INSERTION/VISUEL 
imap ;; <Esc>
map ;; <Esc>


" LEADER
let mapleader = ","


" Invoquer CTRLP 
let g:ctrlp_map = '<leader>c'


" ACK SETTING
" Parametres par defaut pour ack 
" Place un marqueur et cherche 
let g:ackprg="ack -H --nocolor --nogroup --column" 
nmap <leader>j mA:Ack<space> 
" Place un marqueur et cherche le mot sous le curseur 
nmap <leader>ja mA:Ack "<C-r>=expand("<cword>")<cr>"
nmap <leader>jA mA:Ack "<C-r>=expand("<cWORD>")<cr>"


" TAGBAR
nmap <F8> :TagbarToggle<CR>

" For DASHBOARD
let g:dashboard_default_executive ='fzf'


" NERDTREE
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

set t_Co=256
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_theme='tomorrow'
" powerline symbols
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ' '
let g:airline_symbols.branch = ' '
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' ☰ '
let g:airline_symbols.colnr = ' c/n '
let g:airline_symbols.dirty='⚡'


inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"	" https://github.com/neoclide/coc.nvim#example-vim-configuration
inoremap <silent><expr> <c-space> coc#refresh()

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" gi - go to implementation
nmap <silent> gi <Plug>(coc-implementation)

" gr - find references
nmap <silent> gr <Plug>(coc-references)

" gh - get hint on whatever's under the cursor
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" List errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>

" list commands available in tsserver (and others)
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" restart when tsserver gets wonky
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

" view all errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>

" manage extensions
nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>

" rename the current word in the cursor
nmap <leader>cr  <Plug>(coc-rename)
nmap <leader>cf  <Plug>(coc-format-selected)
vmap <leader>cf  <Plug>(coc-format-selected)

" run code actions
vmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)


" Prettier 
map <F4> <Plug>(coc-prettier)
"next prevous buffer
map <F2> :bprevious<CR>
map <F3> :bnext<CR>

"  Execute current file with node
nnoremap <leader>nr :!node %
