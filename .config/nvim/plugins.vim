" man.vim: invoked by :Man {name}
source $VIMRUNTIME/ftplugin/man.vim

" let Vundle manage Vundle, required
" ---------------------------------------------------
Plugin 'gmarik/Vundle.vim'

" vim-color-gruvbox
" ---------------------------------------------------
Plugin 'morhetz/gruvbox'

" vim-airline
" ---------------------------------------------------
Plugin 'bling/vim-airline'

if has('gui_running')
    let g:airline_powerline_fonts = 1
else
    let g:airline_powerline_fonts = 0
endif

let g:airline#extensions#tabline#enabled = 0 " NOTE: When you open lots of buffers and typing text, it is so slow.
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_b = "%{fnamemodify(bufname('%'),':p:.:h').'/'}"
let g:airline_section_c = '%t'
let g:airline_section_warning = airline#section#create(['whitespace']) " NOTE: airline#section#create has no effect in .vimrc initialize pahse
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#whitespace#check(),0)}'
let g:airline_section_warning = ''

" ctrlp: invoke by <ctrl-p>
Plugin 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:10'
let g:ctrlp_follow_symlinks = 2
let g:ctrlp_max_files = 0 " Unset cap of 10,000 files so we find everything
nnoremap <unique> <leader>bs :CtrlPBuffer<CR>

" vim-fugitive: invoke most by :Gdiff
" ---------------------------------------------------
Plugin 'tpope/vim-fugitive'

" vim-surround: invoke when you select words and press 's'
" ---------------------------------------------------
Plugin 'tpope/vim-surround'

xmap s <Plug>VSurround


" nerdtree: invoke by :NERDTreeToggle
" ---------------------------------------------------
Plugin 'scrooloose/nerdtree'

let g:NERDTreeWinSize = 30
let g:NERDTreeMouseMode = 1
let g:NERDTreeMapToggleZoom = '<Space>'

" nerdcommenter: invoke by <leader>c<space>, <leader>cl, <leader>cu, <F11> or <C-F11>
" ---------------------------------------------------
Plugin 'scrooloose/nerdcommenter'

let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDCustomDelimiters = {
            \ 'vimentry': { 'left': '--' },
            \ }

" like syntactic just async
Plugin 'neomake/neomake'
let g:neomake_javascript_jshint_maker = {
    \ 'args': ['--verbose'],
    \ 'errorformat': '%A%f: line %l\, col %v\, %m \(%t%*\d\)',
    \ }
let g:neomake_javascript_enabled_makers = ['jscs']

" run neomake on write
autocmd! BufWritePost * Neomake

" undotree: invoke by <Leader>u
" ---------------------------------------------------
Plugin 'mbbill/undotree'

nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1
let g:undotree_WindowLayout = 4

" NOTE: this will prevent undotree closed then jump to minibufexpl
function! g:CloseUndotree()
    call UndotreeHide()
    call ex#window#goto_edit_window()
endfunction

function g:Undotree_CustomMap()
    if has('gui_running')
        nnoremap <silent> <script> <buffer> <ESC> :call g:CloseUndotree()<CR>
    else
        nnoremap <silent> <script> <buffer> <leader><ESC> :call g:CloseUndotree()<CR>
    endif
endfunction

" tabular: invoke by <leader>= alignment-character
" ---------------------------------------------------
Plugin 'godlygeek/tabular'

nnoremap <silent> <leader>= :call g:Tabular(1)<CR>
xnoremap <silent> <leader>= :call g:Tabular(0)<CR>
function! g:Tabular(ignore_range) range
    let c = getchar()
    let c = nr2char(c)
    if a:ignore_range == 0
        exec printf('%d,%dTabularize /%s', a:firstline, a:lastline, c)
    else
        exec printf('Tabularize /%s', c)
    endif
endfunction

" LargeFile
" ---------------------------------------------------
Plugin 'vim-scripts/LargeFile'
let g:LargeFile= 5 " files >= 5MB will use LargeFile rules

"}}}

" ex-cref: invoke by <leader>cr
" ---------------------------------------------------
Plugin 'exvim/ex-cref'

" this is modified for default c syntax highlight settings
" make it don't highlight error pattern
let c_gnu              = 1
let c_no_curly_error   = 1
let c_no_bracket_error = 1


Plugin 'ntpeters/vim-better-whitespace'
nnoremap <unique> <leader>w :StripWhitespace<CR>

" ex-typescript
" ---------------------------------------------------
Plugin 'exvim/ex-typescript'

" emmet-vim
" ---------------------------------------------------
Plugin 'mattn/emmet-vim'

" make sure emmet only enable in html,css files
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" vim-javascript
" ---------------------------------------------------
Plugin 'pangloss/vim-javascript'

" vim-coffee-script
" ---------------------------------------------------
Plugin 'kchmck/vim-coffee-script'

" vim-html
" ---------------------------------------------------
Plugin 'exvim/ex-indenthtml.vim'


" vim-css-color
" ---------------------------------------------------
Plugin 'ap/vim-css-color'

" vim-css3-syntax
Plugin 'hail2u/vim-css3-syntax'

" vim-jade
Plugin 'digitaltoad/vim-jade'
" vim-less
" ---------------------------------------------------
Plugin 'groenewege/vim-less'

" vim-stylus
" ---------------------------------------------------
Plugin 'wavded/vim-stylus'


" conque-GDB
" ---------------------------------------------------
Plugin 'vim-scripts/Conque-GDB'

let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly

Plugin 'Shougo/deoplete.nvim'

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#disable_auto_complete = 0
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#ignore_case = 1
let g:deoplete#enable_smart_case= 1

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
Plugin 'carlitux/deoplete-ternjs'

" haskell completer
Plugin 'eagletmt/neco-ghc'
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup end
" tern
let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
autocmd FileType javascript setlocal omnifunc=tern#Complete

" Autocomplete for python
Plugin 'davidhalter/jedi-vim'

"Clean whitespace on current lines only
Plugin 'thirtythreeforty/lessspace.vim'

Plugin 'airblade/vim-gitgutter'

Plugin 'tpope/vim-obsession'

Plugin 'othree/eregex.vim'

"Have K split lines the way J joins lines
nnoremap <expr>K getline('.')[col('.')-1]==' ' ? "r<CR>" : "i<CR><Esc>"
