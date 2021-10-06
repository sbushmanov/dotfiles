"------------------------------------------------------------------------------"
"                               General settings                               "
"------------------------------------------------------------------------------"
filetype plugin on
filetype indent on
set hlsearch
set incsearch
set smartcase
set wildmenu
set wildmode=longest:list,full
set clipboard=exclude:.*
"------------------------------------------------------------------------------"
"                                    Colorscheme                               "
"------------------------------------------------------------------------------"
colo solarized8_high 
set background=dark
syntax enable
"let g:gruvbox_contrast_light="hard"
"let g:gruvbox_termcolors=256
"------------------------------------------------------------------------------"
"                                     Theme                                    "
"------------------------------------------------------------------------------"
let g:airline_theme= 'edge'
"------------------------------------------------------------------------------"
"                                 Enter spaces                                 "
"------------------------------------------------------------------------------"
nnoremap <CR> o<Esc>
"------------------------------------------------------------------------------"
"                                 Pymode plugin                                "
"------------------------------------------------------------------------------"
let g:pymode = 1
let g:pymode_indent = 1
let g:pymode_motion = 1
let g:pymode_rope = 1
let g:pymode_rope_completion = 1
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_completion_bind = '<C-Tab>'
let g:pymode_options_max_line_length = 100
let g:pymode_options_colorcolumn = 1
"let g:pymode_debug = 1
let g:pymode_lint = 1
let g:pymode_lint_on_fly = 1
let g:pymode_lint_message = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_doc = 0
let g:pymode_doc_bind = 'K'
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>P'
nnoremap <leader>p : !clear; python %:p<CR>
"------------------------------------------------------------------------------"
"                                      COC                                     "
"------------------------------------------------------------------------------"
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
   set signcolumn=number
else
   set signcolumn=yes
endif
let g:coc_global_extensions = ['coc-python']
"------------------------------------------------------------------------------"
"                                   Bash-mode                                  "
"------------------------------------------------------------------------------"
nnoremap <leader>b : !clear; bash %:p<CR>
nnoremap <leader>B : Bash<CR>
"------------------------------------------------------------------------------"
"                                   NERDTree                                   "
"------------------------------------------------------------------------------"
nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"
"------------------------------------------------------------------------------"
"                                Try vim features                              "
"------------------------------------------------------------------------------"
" Save 1,000 items in history
set history=1000
" Show the line and column number of the cursor position
set ruler
" Display the incomplete commands in the bottom right-hand side of your screen.  
set showcmd
" Show a few lines of context around the cursor
set scrolloff=5
" Turn on line numbering
set number
" Turn on file backups
set backup
" Don't line wrap mid-word.
set lbr
" Copy the indentation from the current line.
set autoindent
" Enable smart autoindenting.
set smartindent
" Use spaces instead of tabs
set expandtab
" Enable smart tabs
set smarttab
" Make a tab equal to 4 spaces
set shiftwidth=4
set tabstop=4
" Map Y to act like D and C, i.e. yank until EOL, rather than act like yy
" map Y y$
" Remap VIM 0 to first non-blank character
map 0 ^
" Easily create HTML unorded lists. 
"map <F3> i<ul><CR><Space><Space><li></li><CR><Esc>I</ul><Esc>kcit
"map <F4> <Esc>o<li></li><Esc>cit
" change the mapleader from \ to ,
" NOTE: This has to be set before <leader> is used.
"let mapleader=","
" Quickly save your file.
map <leader>w :w!<cr>
" For more options see ":help option-list" and ":options".
