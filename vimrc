set encoding=utf-8 nobomb

set viminfo='1000,f1 "Dunno what this does
"set wrapmargin=8
"Enabling syntax highlighting
syntax on

"Enabling relative line numbers
set relativenumber
"set ls=2 "enables statusline at the bottom
set modeline
"%F is filename
"%h file modified flag 
"[%04l,%04v] is line and column number
"[%p%%] is percentage down file
"[%L] is total lines
"set statusline=%F\ [%4l,%4v][%p%%]\ [%L]

set autoindent "Enabling auto Indent

"Allows for efficient block commenting
vnoremap <silent> # :s/^#//<cr>:noh<cr>
vnoremap <silent> -# :s/^#//<cr>:noh<cr>

"Command Aliases
command WQ wq
command Wq wq
command W w
command Q q

"map <F4> :w
"map <M-F5> :w
"
"map <Alt><S> :w
"map <M-s> <:w>
"map <C-M-D> <:w>
"noremap <C-s> <esc>:w<cr>
