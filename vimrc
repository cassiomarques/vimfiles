set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'CSApprox'
Plugin 'rking/ag.vim'
Plugin 'Align'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'bkad/CamelCaseMotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-endwise'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-markdown'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-rails'
Plugin 'luochen1990/rainbow'                        " Rainbow parentheses
Plugin 'tpope/vim-rake'
Plugin 'msanders/snipmate.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tomtom/tcomment_vim'
Plugin 'guns/vim-clojure-static'                    " Clojure stuff
Plugin 'tpope/vim-dispatch'                         " Run commands in a tmux split pane
Plugin 'tpope/vim-fireplace'                        " Clojure stuff
Plugin 'dgrnbrg/vim-redl'
Plugin 'tpope/vim-salve'                            " Integrates Leiningen with Vim and adds lots of cool stuff for Clojure
Plugin 'tpope/vim-fugitive'                         " Git stuff
Plugin 'vim-ruby/vim-ruby'
Plugin 'gcmt/wildfire.vim'                          " Select blocks of things
Plugin 'edkolev/tmuxline.vim'                       " Send commands from Vim to a tmux pane
Plugin 'tpope/vim-surround'
Plugin 'venantius/vim-eastwood'                     " Syntax check/linting for Clojure
Plugin 'flazz/vim-colorschemes'                     " Lots of colorschemes
Plugin 'morhetz/gruvbox'                            " Colorscheme
Plugin 'guns/vim-sexp'                              " Like Paredit...
Plugin 'guns/vim-clojure-highlight'                 " Better syntax highlighting for Clojure
Plugin 'tpope/vim-sexp-mappings-for-regular-people' " Key-bindings for vim-sexp
Plugin 'epeli/slimux'                               " Send stuff to a tmux pane

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

syntax on                 " Enable syntax highlighting
" syntax sync minlines=256
filetype plugin indent on " Enable filetype-specific indenting and plugins

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,perl,tex set shiftwidth=2
autocmd FileType c,cpp,java,javascript,python,xml,xhtml,html set shiftwidth=2
autocmd FileType javascript set shiftwidth=2

" Removes trailing spaces when saving the buffer
autocmd BufWritePre * :%s/\s\+$//e

augroup filetypedetect
  au! BufNewFile,BufRead *.ch setf cheat
  au BufNewFile,BufRead *.liquid setf liquid
  au! BufRead,BufNewFile *.haml setfiletype haml
  autocmd BufNewFile,BufRead *.yml setf eruby
  autocmd BufRead,BufNewFile *.prawn set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile set filetype=ruby
  autocmd BufNewFile,BufRead *.clj set filetype=clojure
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
augroup END

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
augroup END


au! BufNewFile,BufRead *.haml set filetype=haml

"=====================================================================
" MAPPINGS
"=====================================================================
" Build tags for the current directory
nmap <F2> :!/usr/local/Cellar/ctags/5.8/bin/ctags -R .<CR>

" Clears CtrlP cache
nmap <F3> :CtrlPClearCache<CR>
" Opens CtrlP in buffer mode
nmap <leader>b :CtrlPBuffer<CR>

function AgWord()
  let l:Command = expand("<cword>")
  execute ":Ag " . l:Command
endfunction

nmap <leader>a :call AgWord()<CR>

" Remove search highlighting with <ENTER>
:nnoremap <Space> :nohlsearch<cr>

" Runs the current spec file using Zeus
nmap <leader>t :!zeus rspec %<CR>

" No arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Changing tabs
nmap <Tab> :tabnext<CR>
nmap <S-Tab> :tabprevious<CR>

" Opens Syntastic Errors window and jumps to it.
map <M-e> :Errors<CR><C-w>j

"Remove trailing spaces with \rt
nmap <leader>rt :%s/\s\+$//<CR>

"Ctags search always lists all occurrences
nmap <C-]> g<C-]>

"make Y consistent with C and D
nnoremap Y y$

" Align Ruby hashes
vmap ah :Align =><CR>
" Align by '='
vmap ae :Align =<CR>
" Align JavaScript objects with : (comma)
vmap ac :Align :<CR>
" Align blocks (or anything delimited by opening brackets)
vmap ab :Align {<CR>

" Run current test
map <Leader>t :call RunCurrentTest()<CR>
map <Leader>o :call RunCurrentLineInTest()<CR>

" Save file as root
cnoremap sudow w !sudo tee % >/dev/null

"Clojure Stuff
nnoremap <leader>e :%Eval<CR>
nnoremap <leader>r :Require!<CR>

"=====================================================================
" PLUGIN CONFIGURATIONS
"=====================================================================
" Load matchit (% to bounce from do to end, etc.)
runtime! plugin/matchit.vim
runtime! macros/matchit.vim

" Rainbow
let g:rainbow_active = 1
au Syntax * RainbowToggle

let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\   'ctermfgs': ['darkgray', 'darkgreen', 'darkmagenta', 'darkcyan', 'darkred', '97'],
\   'operators': '_,_',
\   'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
\   'separately': {
\       '*': {},
\       'lisp': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\           'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan', 'darkred', 'darkgreen'],
\       },
\       'clojure': {
\           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
\           'ctermfgs': ['darkgray', 'darkgreen', 'darkmagenta', 'darkcyan', 'darkred', '97'],
\       },
\       'html': {
\           'parentheses': [['(',')'], ['\[','\]'], ['{','}'], ['<\a[^>]*[^/]>\|<\a>','</[^>]*>']],
\       },
\       'tex': {
\           'operators': '',
\           'parentheses': [['(',')'], ['\[','\]']],
\       },
\   }
\}

"Ctrl-P
let g:ctrlp_dotfiles = 0
let g:ctrlp_map = '<leader>p'
let g:ctrlp_max_files = 0

let g:ctrlp_custom_ignore = {'file': '\.git$\|\.hg$\|\.svn$\|DS_Store', 'dir': 'coverage', 'link': '',}
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
let g:ctrlp_user_command = ['.hg/', 'hg --cwd %s locate -I .']
let g:ctrlp_open_new_file = 't'

" Vim Airline Settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Syntastic settings
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=0
let g:syntastic_javascript_checkers = ['jshint']

" Clojure-Vim
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1

" Slimux configuration
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map <Leader>a :SlimuxShellLast<CR>
map <Leader>k :SlimuxSendKeysLast<CR>

"=====================================================================
" Colorscheme, Tmux, etc
"=====================================================================
set background=dark
colorscheme Tomorrow-Night

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

"==================================================================================
" Test-running stuff
"==================================================================================
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("!cucumber")
      exec g:bjo_test_runner g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("!rspec")
      exec g:bjo_test_runner g:bjo_test_file
    else
      call SetTestRunner("!ruby -Itest")
      exec g:bjo_test_runner g:bjo_test_file
    endif
  else
    exec g:bjo_test_runner g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec "!rspec" g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

function! CorrectTestRunner()
  if match(expand('%'), '\.feature$') != -1
    return "cucumber"
  elseif match(expand('%'), '_spec\.rb$') != -1
    return "rspec"
  else
    return "ruby"
  endif
endfunction

"=====================================================================
" VIM SETTINGS
"=====================================================================
set encoding=utf-8 " Necessary to show unicode glyphs

set nobackup
set noswapfile
set shell=/bin/zsh
set nowritebackup
set path=$PWD/public/**,$PWD/**
set sessionoptions=blank,buffers,curdir,help,resize,tabpages,winsize
set laststatus=2

"tell the term has 256 colors
set t_Co=256

set guioptions-=T
set guioptions-=m
set switchbuf=usetab
set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

set cf  " Enable error files & error jumping.

if $TMUX == ''
  set clipboard+=unnamed  " Yanks go on clipboard instead.
endif

set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set nu  " Line numbers on
set nowrap  " Line wrapping off
set timeoutlen=250  " Time to wait after ESC (default causes an annoying delay)
set ignorecase smartcase
set hlsearch

" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set nocp incsearch
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set autoindent
set smarttab
set expandtab

" Visual
set showmatch  " Show matching brackets.
set mat=5  " Bracket blinking.
set list
set lcs=tab:\ \ ,extends:>,precedes:<
set novisualbell  " No blinking .
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.
set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes

