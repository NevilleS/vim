set nocompatible

" Vundle setup begin
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'tomtom/tlib_vim.git'
Plugin 'tpope/vim-abolish.git'
Plugin 'MarcWeber/vim-addon-mw-utils.git'
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'tpope/vim-rails.git'
Plugin 'thoughtbot/vim-rspec.git'
Plugin 'garbas/vim-snipmate.git'
Plugin 'honza/vim-snippets.git'

" Vundle setup end
call vundle#end()

" Basic config
syntax enable
filetype plugin on
filetype indent on
set expandtab
set autoindent
set bs=2
set guifont=Consolas
set hidden

" Use solarized colorscheme
set t_Co=16
set background=dark
let g:solarized_termcolors=16
colorscheme solarized

" Disable the arrow keys
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>

" Highlight search results
set incsearch
set hlsearch

" Tell VIM to always put a status line, even if there is only one window
set laststatus=2

" Configure airline status/tab line
let g:airline#extensions#tabline#enabled = 1

" Switch between buffers with tab and shift-tab
nmap <tab> :bnext<CR>
nmap <S-tab> :bprev<CR>
nmap <Leader>q :bdelete<CR>

" NERD Tree settings
" Toggle the NERD Tree on and off with F7
nmap <F7> :NERDTreeToggle %<CR>

" Disable the fancy arrows, they don't work for me
"let NERDTreeDirArrows = 0

" Andrew's ninja-folding
" - zM (collapse all folds)
" - zR (expand all folds)
" - <space> expands or collapses a given fold
set foldmethod=indent foldlevel=999
nmap <silent> <space> :exe 'silent!normal!za' <cr>
highlight Folded ctermbg=Black ctermfg=DarkBlue

" Show line numbers... (nah)
set nu

" Highlight whitespace errors
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Richard's gosu vim hints for astyle
set modeline "enable reading of vim settings from specially formatted comments
set ts=2 sts=2 sw=2 expandtab "make tab key conform to coding guidelines
"let w:m1=matchadd('Search', '\%>80v.\%<122v', -1) "highlight lines >80 chars in yellow
"let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1) " highlight lines > 120 chars in red
let w:m3=matchadd('ErrorMsg', '\t', -1) " highlight tabs in red
set cindent "indent as you type
set cinoptions='t0g0' "tweak indenting style
set tw=120

" Enable mouse support
set mouse=a
set mousehide

" Don't do full tab completion unless you hit tab 3 times
set wildmode=longest,list,full
set wildmenu

" Ignore dependencies for CtrlP
set wildignore+=*/bower_components/*,*/node_modules/*,*/dist/*

" Configure Windows
if has("win32")
    let g:ruby_path = "C:\Ruby193\bin"
endif

if has("autocmd")
    " Restore cursor position
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
endif

" Add vim-rspec runner command
command! Run :call RunNearestSpec()
map <Leader>r :call RunNearestSpec()<CR>

" Edit the vimrc, and auto-reload it after a change
command! Vimrc :e ~/.vim/vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
