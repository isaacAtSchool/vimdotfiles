"" Block for vim-plug vim plugin manager {{{

call plug#begin('~/.vim/plugged')
" gruvbox theme
Plug 'morhetz/gruvbox'

" easy escape lets the user press jk to exit insert mode
Plug 'zhou13/vim-easyescape'

" airline is a status line for vim that's neat
Plug 'vim-airline/vim-airline'

" themes for the airline status bar plugin
Plug 'vim-airline/vim-airline-themes'

" easyMotion plugin to highlight possible targets for motions
Plug 'easymotion/vim-easymotion'

" vim surround let's the surrounding of text be changed
Plug 'tpope/vim-surround'

" javascript improved folding and syntax
Plug 'pangloss/vim-javascript'

" python mode editing plugin, monolithic, multi-featured
" adds 
"   in editing run
"   add/ remove breakpoints
"   python folding
"   move operators
"   code checking
"   linting and style error autofix
"   refactoring (by rope tools)
"   strong code completion
"   goto definition
"
Plug 'python-mode/python-mode'

" Autocomplete pop up box as you type 
Plug 'Valloric/YouCompleteMe', { 'on': [] }

" emmet for vim
Plug 'mattn/emmet-vim'  

call plug#end()
"end of plugin list
" }}}

"" Airline plugin theme change
let g:airline_theme='gruvbox'

""colorschemes added using plugin manager
let &termguicolors=1
let &background="dark"
let g:gruvbox_contrast_dark='soft'
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox

"" the next section follows vimscript the hard way

" GLOBAL OPTIONS {{{
" variable for the global leader
let mapleader="\\"
" variable set for the local leader
let maplocalleader=","
" match parens for functional goodness
" set showmatch
let &showmatch = 1
" match override default matchtime of 5
" set matchtime=3
let &matchtime=3
" show line numbers
" set number
let &number = 1
" set fold level on file open to all closed
" set foldlevelstart=0
let &foldlevelstart = 0

" always wrap by default
let &wrap = 745

" turn off the vim intro screen 
set shortmess+=I

" set the dictionary location for vim
set dictionary=/usr/share/dict/words

" }}}


"" VIM MAPPINGS  {{{

" <localleader> type mappings should go in the sections devoted to languages
" or contexts that they are concerned with

" Make the command line easier to reach
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Make space more useful
nnoremap <space> za

" print an ascii cat 
" echom ">^.^<"
" set the shortcut for the minus symbol, don't know if i like this
noremap <leader>- ddp

" paste up versn of the previous map
noremap <leader>_ S<esc>P

" capitalize whole WORD in insert mode with ctrl+u
inoremap <leader><c-u> <esc>viWUi

" capitalize WORD in normal mode
nnoremap <leader><c-u> viWU

" easily edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" easily reload vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

"mapping 'strong' versions of h and l with H and L
nnoremap H 0
nnoremap L $

" mapping the visual surround with quotes
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>

"new line below and above without entering insert mode
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" null the arrow keys
noremap <Up> <nop>
noremap <Right> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
" }}}

"" ABBREVIATIONS/SNIPPETS {{{
"fixing some common spelling mistakes 
iabbrev tehn then
iabbrev teh the
iabbrev mpa map

"using abbrevitions to shortcut my email, and hello world
iabbrev @@ ixm009@shsu.edu
iabbrev helwo Hello, World
" }}}

"" AUTOCOMMAND GROUPS
"" source the vimrc so no autocmds are loaded more than once

" EMMET plugin settings {{{
let g:user_emmet_leader_key='<C-e>'
" }}}

" Vimscript file settings part 1 {{{
augroup filetype_vimscript
	autocmd!
	autocmd FileType vim setlocal tabstop=4	
	autocmd FileType vim setlocal expandtab
	autocmd FileType vim setlocal shiftwidth=4	
	autocmd FileType vim setlocal foldlevel=0
    autocmd FileType vim setlocal foldmethod=marker
augroup END	
" }}}

" Javascript file settings {{{
augroup filetype_JavaScript
    autocmd!
    autocmd FileType javascript setlocal number wrap
    autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 expandtab
    " here are some snippet-like abbrevs for langs I code in
    " javascript
    autocmd FileType javascript :iabbrev <buffer> iff if ()<Left>
    autocmd FileType javascript :iabbrev <buffer> funcn function(){<CR>}
    autocmd FileType javascript nnoremap <buffer> <leader>c 0i//<esc>
    autocmd FileType javascript setlocal foldmethod=syntax
augroup END
" }}}

" The next section is for editing md files, basically i just want an easy way
" to write annotations
"easy headers up to level 5, place cursor in the center of header annotation
" Markdown file settings {{{ 
augroup filetype_markdown
    autocmd FileType markdown nnoremap <buffer> <localleader>h1 i##<esc>
    autocmd FileType markdown nnoremap <buffer> <localleader>h2 i####<esc>h
    autocmd FileType markdown nnoremap <buffer> <localleader>h3 i######<esc>hh
    autocmd FileType markdown nnoremap <buffer> <localleader>h4 i########<esc>hhh
    autocmd FileType markdown nnoremap <buffer> <localleader>h5 i##########h<esc>hhh
    "easy bullet
    autocmd FileType markdown nnoremap <buffer> <localleader>b  ^i* <esc>
    
    "easy bold and italic
    autocmd FileType markdown nnoremap <buffer> <localleader>bo  i****<esc>h
    autocmd FileType markdown nnoremap <buffer> <localleader>i  i**<esc>
    "easy links and images
    autocmd FileType markdown nnoremap <buffer> <localleader>l []()<esc>hh
    autocmd FileType markdown nnoremap <buffer> <localleader>im ![]()<esc>hh
    "code block
    autocmd FileType markdown nnoremap <buffer> <localleader>c i```<esc>o```<esc>kl
augroup END
" }}}

" bash script file settings {{{
augroup filetype_bash
	autocmd!
	autocmd FileType sh setlocal tabstop=4	
	autocmd FileType sh setlocal expandtab
	autocmd FileType sh setlocal shiftwidth=4	
    " wrap a whole word in ${} for var expansion
	autocmd FileType sh  nnoremap <localleader>V :<c-u>normal! viWA}<esc>hviW`<<esc>i${<esc>E
   " wrap a word (iw) in ${} for variable expansion
	autocmd FileType sh  nnoremap <localleader>v :<c-u>normal! viwA}<esc>hviw`<<esc>i${<esc>E
augroup END
" }}}
" Responsible coding chapter 18

" Vimscript file settings ---------------------------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" html file settings ---------------------------------------- {{{
augroup filetype_html
    autocmd!
    autocmd FileType html setlocal foldmethod=syntax
    autocmd FileType html EmmetInstall
    
augroup END
" }}}

" python file settings {{{
augroup filetype_python
	autocmd!
	autocmd FileType python setlocal tabstop=4	
	autocmd FileType python setlocal expandtab
	autocmd FileType python setlocal shiftwidth=4	
	autocmd FileType python setlocal foldlevel=99
	autocmd FileType python setlocal foldlevelstart=99
augroup END
" }}}
