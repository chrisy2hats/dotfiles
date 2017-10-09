set spelllang=en_gb "Setting my spell check to english. This can be enabled using :set spell and disabled using :set nospell 
 
"Making marks persistant
set viminfo='100,f1

"colour scheme avaliable at https://github.com/sjl/badwolf
colo badwolf  "setting colour scheme. Default is "ron" for dark terminals and peachpuff for light terminals
let g:solarized_termcolors=256

"Setting tab to 4 spaces. This is language aware so in python tab is a tab but
"in haskell a tab is 4 spaces
filetype plugin indent on
"set tabstop=4 shiftwidth=4 expandtab 



set encoding=utf-8 nobomb

set viminfo='1000,f1 "Dunno what this does
"set wrapmargin=8
"Enabling syntax highlighting
syntax on
set background=dark
"Enabling relative line numbers
set relativenumber
set number
"set ls=2 "enables statusline at the bottom
set modeline
"%F is filename
"%h file modified flag 
"[%04l,%04v] is line and column number
"[%p%%] is percentage down file
"[%L] is total lines
"set statusline=%F\ [%4l,%4v][%p%%]\ [%L]

"set autoindent "Enabling auto Indent

"Allows for efficient block commenting
vnoremap <silent> # :s/^#//<cr>:noh<cr>
vnoremap <silent> -# :s/^#//<cr>:noh<cr>

"Command Aliases
command WQ wq
command Wq wq
command W w
command Q q
"command Q\! q!
command Tab set tabstop=4 shiftwidth=4 expandtab
command NoTab set noexpandtab
command Notab set noexpandtab


"map <F4> :w
"map <M-F5> :w
"
"map <Alt><S> :w
"map <M-s> <:w>
"map <C-M-D> <:w>
"noremap <C-s> <esc>:w<cr>


"Making vim respect my bash aliases - Currently broken
"set shell=/bin/bash\ --rcfile\ ~/.bashrc\ -i
"set shell=/bin/bash\ -i
"set shell=/bin/bash
