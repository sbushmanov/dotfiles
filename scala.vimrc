"------------------------------------------------------------------------------"
"                                    Plugins                                   "
"------------------------------------------------------------------------------"
call plug#begin('/home/sergey/.vimscala/plugged')

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
    Plug 'ryanoasis/vim-devicons'
    Plug 'https://github.com/sainnhe/gruvbox-material'
    Plug 'lifepillar/vim-solarized8'
    Plug 'sainnhe/edge'
    Plug 'sbdchd/neoformat'
    Plug 'neomake/neomake' ", {'for':[]}
    Plug 'jiangmiao/auto-pairs'
    Plug 'cometsong/CommentFrame.vim'
    Plug 'psf/black', { 'branch': 'stable' }
    "Plug 'neovim/nvim-lspconfig'
    "Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build', 'branch': 'main' }

call plug#end()
"------------------------------------------------------------------------------"
"                               General Settings                               "
"------------------------------------------------------------------------------"
filetype plugin on
filetype indent on
set hlsearch
set incsearch
set smartcase
set wildmenu
set wildmode=longest:list,full
set backspace=indent,eol,start
set ttimeoutlen=0
set undofile
set undodir=/home/sergey/.vimscala/undo/
autocmd FileType json syntax match Comment +\/\/.\+$+
set clipboard=unnamedplus
set history=2000
nmap <leader>s :!sbt run <Cr>
nmap <Enter> o<Esc>
nmap <C-_> I# <ESC>
let g:python3_host_prog = '/home/sergey/anaconda3/bin/python'
"------------------------------------------------------------------------------"
"                                 Airline theme                                "
"------------------------------------------------------------------------------"
"let g:airline_theme='edge'
let g:airline_powerline_fonts = 1
colo solarized8_high
set background=dark
syntax enable

set number
nmap <silent> <F2> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

autocmd FileType json syntax match Comment +\/\/.\+$+

let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sc'] = ''

" Tabline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Show buffer number for easier switching between buffer,
" see https://github.com/vim-airline/vim-airline/issues/1149
let g:airline#extensions#tabline#buffer_nr_show = 1

" Buffer number display format
let g:airline#extensions#tabline#buffer_nr_format = '%s. '

" Whether to show function or other tags on status line
let g:airline#extensions#vista#enabled = 1
let g:airline#extensions#gutentags#enabled = 1

" Do not show search index in statusline since it is shown on command line
let g:airline#extensions#anzu#enabled = 0

" Enable vim-airline extension for nvim-lsp
let g:airline#extensions#nvimlsp#enabled = 1
"------------------------------------------------------------------------------"
"                                   Neoformat                                  "
"------------------------------------------------------------------------------"
let g:neoformat_scala_scalafmt = {
        \ 'exe': 'scalafmt-native',
        \ 'args': ['--stdin'],
        \ 'stdin': 1,
        \ }
nmap <buffer> <C-l> :Neoformat <Cr>
"------------------------------------------------------------------------------"
"                                      COC                                     "
"------------------------------------------------------------------------------"

" Because no one likes to be blinded by awful colors
highlight CocErrorSign guifg=#E06C75
highlight CocWarningSign guifg=#E5C07B
highlight StatusLineStatus guifg=#4B5263 guibg=#2C323C
highlight StatusLineError guifg=#E06C75 guibg=#2C323C
highlight StatusLineWarning guifg=#E5C07B guibg=#2C323C

set statusline=%n\   " buffer number
set statusline+=%t\ %M%r%h%w\  " file modified, readonly, help, preview
set statusline+=%#StatusLineError#%{CocMinimalErrors()}\ " coc-errors
set statusline+=%#StatusLineWarning#%{CocMinimalWarnings()}\ " coc-warnings
set statusline+=%#StatusLineStatus#%{CocMinimalStatus()}%#StatusLine#\ " coc status
set statusline+=%=%Y\  " filetype
set statusline+=%{&ff}\  " right align line endings
set statusline+=%l,%v\ " curser position
set statusline+=%p%%\  " percentage on page
" Gets Errors and Warnings for buffer plus the Status message from coc.nvim
function! StatusDiagnosticForBuffer() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✘' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, '' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction

" Gets Errors and Warnings for the entire workspace from coc.nvim
function! StatusDiagnosticForWorkspace() abort
  let diagnostics = CocAction('diagnosticList')
  if type(diagnostics) == v:t_list
    let errors = []
    let warnings = []
    for diagnostic in diagnostics
      if diagnostic['severity'] == 'Error'
        call add(errors, diagnostic)
      endif
      if diagnostic['severity'] == 'Warning'
        call add(warnings, diagnostic)
      endif
    endfor
    return " ✘ " . string(len(errors)) . "  " . string(len(warnings)) . " "
  endif
endfunction

" Just gets the status message from coc.nvim
function! CocMinimalStatus() abort
  return get(g:, 'coc_status', '')
endfunction

" Just gets the errors from the current buffer
function! CocMinimalErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✘' . info['error'])
  endif
  return join(msgs)
endfunction

" Just gets the warnings from the current buffer
function! CocMinimalWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'warning', 0)
    call add(msgs, '' . info['warning'])
  endif
  return join(msgs)
endfunction

" If hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHold
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c
set shortmess-=F

" Always show signcolumns
set signcolumn=yes

" Help Vim recognize *.sbt and *.sc as Scala files
au BufRead,BufNewFile *.sbt,*.sc set filetype=scala

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" used in the tab autocompletion for coc
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Used to expand decorations in worksheets
nmap <leader>ws <Plug>(coc-metals-expand-decoration)

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
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

xmap <leader>al  <Plug>(coc-codeaction-line)
nmap <leader>al  <Plug>(coc-codeaction-line)
nmap <leader>ca  <Plug>(coc-codeaction-cursor)

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

nnoremap <leader>cl :<C-u>call CocActionAsync('codeLensAction')<CR>

" Use `:Format` for format current buffer
command! -nargs=0 F :call CocActionAsync('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

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

" Notify coc.nvim that <enter> has been pressed.
" Currently used for the formatOnType feature.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Toggle panel with Tree Views
nnoremap <silent> <space>t :<C-u>CocCommand metals.tvp<CR>
" Toggle Tree View 'metalsPackages'
nnoremap <silent> <space>tp :<C-u>CocCommand metals.tvp metalsPackages<CR>
" Toggle Tree View 'metalsCompile'
nnoremap <silent> <space>tc :<C-u>CocCommand metals.tvp metalsCompile<CR>
" Toggle Tree View 'metalsBuild'
nnoremap <silent> <space>tb :<C-u>CocCommand metals.tvp metalsBuild<CR>
" Reveal current current class (trait or object) in Tree View 'metalsPackages'
nnoremap <silent> <space>tf :<C-u>CocCommand metals.revealInTreeView metalsPackages<CR>
