"Vim options 
syntax on
set nu
set smartindent
set incsearch
set autoindent
set showcmd 
set nocompatible             
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

""Leader key 
let mapleader=" "

"remappings
imap jk <Esc>
imap kj <Esc>
nnoremap <Leader>y :!g++ -o main.exe  % && echo "Compilation done" && ./main.exe <CR>
"nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <Leader>nt :NERDTree<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
"nnoremap <C-f> :NERDTreeFind<CR>

"Plugin manager install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
   execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
"Colorscheme
Plug 'morhetz/gruvbox'
"C++ syntax highlighting
Plug 'bfrg/vim-cpp-modern'

"Bottom line customization
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"fuzzy file findind
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"vim grep search for stuff
Plug 'jremmen/vim-ripgrep'
"File navigator
Plug 'preservim/nerdtree'
call plug#end()


"ColorScheme

colorscheme gruvbox
set background=dark


"configure ripgrep to search in current project

if executable('rg')
	let g:rg_derive_root = 'true'
endif

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
set showcmd
