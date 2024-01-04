" Based on "How to Do 90% of What Plugins Do (With Just Vim)
" https://www.youtube.com/watch?v=XA2WjJbmmoM



" ========
" Features
" ========

" - Fuzzy File Search
" - Tag jumping
" - Autocomplete
" - File Browsing
" - Snippets



" ========
" VIM-PLUG
" ========

" Although I don't like using plugins...
" Emmet is a must. Who wants to type HTML and CSS by hand? Not I.

if empty(system('which curl'))
  echoerr "Error: curl is not installed. Please install curl and try again."
else 
  " Install vim-plug automatically
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

" List your plugins here
call plug#begin('~/.vim/plugged')
  Plug 'mattn/emmet-vim'
  Plug 'lambdalisue/suda.vim'
call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


" ===========
" BASIC SETUP
" ===========

" enter the current millenium
" tells vim to not bother pretending to be vi
set nocompatible

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" blinking cursor
:set guicursor=a:blinkwait5-blinkon5-blinkoff5

" line numbers
:set number

" manage tab sizes
:set expandtab
:set tabstop=2
:set shiftwidth=2

" =============
" FINDING FILES
" =============

" Search down into subfolders
" Provides tab-completion for all file-related tasks
" Double asterisk makes it recursive
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer



" ===========
" TAG JUMPING
" ===========

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags



" ============
" AUTOCOMPLETE
" ============

" The good stuff is documented in |ins-completion|

" Automatically sort tags file on save
autocmd BufWritePost *.tags silent! !sort -o %.tags %

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list



" =============
" FILE BROWSING
" =============

" Tweaks for browsing
" let g:netrw_banner=0      " disable banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings



" ========
" SNIPPETS
" ========

" Read an empty HTML template and move cursor to title
nnoremap ,html 	:-1read	$HOME/.config/nvim/snippets/htmltemplate.html<CR>6jf>a
" React functional component named after the current filename
nnoremap ,rfc :execute '-1read $HOME/.config/nvim/snippets/react-functional-component.js' \| %s/MyComponent/\=expand('%:t:r')/g<CR>

