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
Plugin 'thoughtbot/vim-rspec.git'
Plugin 'garbas/vim-snipmate.git'
Plugin 'honza/vim-snippets.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'leafgarland/typescript-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'Shougo/vimproc.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'tpope/vim-commentary'
Plugin 'wincent/loupe'
Plugin 'vim-ruby/vim-ruby.git'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'fatih/vim-go'

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
set cursorline

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
"nnoremap <cr> :nohlsearch<cr>

" Tell VIM to always put a status line, even if there is only one window
set laststatus=2

" Configure airline status/tab line
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Switch between buffers with tab and shift-tab
nmap <tab> :bnext<CR>
nmap <S-tab> :bprev<CR>
nmap <Leader>q :bdelete<CR>
nmap <Leader>Q :bdelete!<CR>

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

" Line numbers
"set nu "regular
set rnu "relative

" Highlight whitespace errors
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Richard's gosu vim hints for astyle
set modeline "enable reading of vim settings from specially formatted comments
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab "make tab key conform to coding guidelines
" let w:m1=matchadd('Search', '\%>80v.\%<102v', -1) "highlight lines > 80 chars in yellow
" let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1) " highlight lines > 100 chars in red
" let w:m3=matchadd('ErrorMsg', '\t', -1) " highlight tabs in red
" set cindent "indent as you type
" set cinoptions='t0g0' "tweak indenting style
set textwidth=100

" Enable mouse support
set mouse=a
set mousehide

" Don't do full tab completion unless you hit tab 3 times
set wildmode=longest,list,full
set wildmenu

" Navigate between quickfix entries quickly
nnoremap <silent> <C-j> :cn<CR>
nnoremap <silent> <C-k> :cp<CR>

" Ignore dependencies for CtrlP
" (from https://github.com/ctrlpvim/ctrlp.vim README)
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Add vim-rspec runner command
command! Spec :call RunNearestSpec()
map <Leader>s :call RunNearestSpec()<CR>

" YouCompleteMe tweaks
let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" Typescript stuff
"     <C-]> : go to type definition
"     <C-t> : go back from definition
" <Leader>t : echo type information at cursor
" <Leader>r : rename symbol at cursor
autocmd FileType typescript setlocal completeopt+=menu,preview
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
let g:tsuquyomi_disable_quickfix = 0 "set this to disable the auto build on save
"autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
autocmd BufNewFile,BufRead *.graphql set filetype=typescript.jsx

" Markdown (prose) stuff
" <C-m>        : generate markdown preview
" :TableFormat : format table nicely
" :GenTocGFM   : generate table of contents at cursor
" :UpdateToc   : update table of contents
let vim_markdown_preview_github=1 " use github-flavoured markdown for vim-mardown-preview
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Google Chrome'
autocmd FileType markdown setlocal textwidth=0 " disable auto textwidth

" Python stuff
autocmd FileType python setlocal textwidth=79 " 80 characters, PEP-8 style

" Edit the vimrc, and auto-reload it after a change
command! Vimrc :e ~/.vim/vimrc
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
