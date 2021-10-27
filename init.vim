" =======================
" Plug Install
" =======================
call plug#begin('~/.vim/plugged')

" UI
Plug 'morhetz/gruvbox'

" IDE
Plug 'preservim/nerdtree' |
			\ Plug 'Xuyuanp/nerdtree-git-plugin' |
			\ Plug 'ryanoasis/vim-devicons' |
			\ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}
Plug 'bling/vim-bufferline'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'qpkorr/vim-bufkill'
"Plug 'OmniSharp/omnisharp-vim'
Plug 'sheerun/vim-polyglot'

" Auto Format
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

" Snippets
" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Direction
Plug 'preservim/tagbar'
Plug 'easymotion/vim-easymotion'
Plug 'RRethy/vim-illuminate'
Plug 'tpope/vim-surround'
"Plug 'liuchengxu/vista.vim'

" Git
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'

" Completion
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Ranger
"Plug 'francoiscabrol/ranger.vim'
"Plug 'rbgrouleff/bclose.vim'

" Funny
"Plug 'junegunn/goyo.vim'

call plug#end()

"=======================
" coc plugin
"=======================
"let g:coc_global_extensions = [
"			\ 'coc-vimlsp',
"			\ 'coc-yank',
"			\ 'coc-snippets',
"			\ 'coc-pyright',
"			\ 'coc-translator',
"			\ 'coc-prettier',
"			\ 'coc-json']"


" FEATURES TO COVER:
" - Fuzzy File Search
" - Tag jumping
" - Autocomplete
" - File Browsing
" - Snippets
" - Build Integration (if we have time)

" GOALS OF THIS TALK:
" - Increase Vim understanding
" - Offer powerful options

" NOT GOALS OF THIS TALK:
" - Hate on plugins
" - Get people to stop using plugins

" {{{ BASIC SETUP
" BASIC SETUP:

" enter the current millenium
set nocompatible

" enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags





" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list





" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings



" SNIPPETS:

" Read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" NOW WE CAN:
" - Take over the world!
"   (with much fewer keystrokes)









" BUILD INTEGRATION:

" Steal Mr. Bradley's formatter & add it to our spec_helper
" http://philipbradley.net/rspec-into-vim-with-quickfix

" Configure the `make` command to run RSpec
set makeprg=bundle\ exec\ rspec\ -f\ QuickfixFormatter

" NOW WE CAN:
" - Run :make to run RSpec
" - :cl to list errors
" - :cc# to jump to error by number
" - :cn and :cp to navigate forward and back

" =======================
" Genernal Setting
" =======================
"let &t_ut=''
set autochdir
set autoindent
set encoding=utf-8
set number
set relativenumber
set mouse=a
filetype plugin on
"set list
"set listchars=tab:\|\ ,trail:▫
set cursorline
set wrap
set ignorecase
set smartcase
"set scrolloff=5
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set termguicolors
set hidden
""set ttimeoutlen=0
""set notimeout
set foldmethod=indent
set foldlevel=99
set foldenable
"set formatoptions-=tc
set splitright
set splitbelow
"set noshowmode
set showcmd
set wildmenu
"set ttyfast "should make scrolling faster
"set lazyredraw "same as above
"set visualbell
"silent !mkdir -p ~/.config/nvim/tmp/backup
"silent !mkdir -p ~/.config/nvim/tmp/undo
""silent !mkdir -p ~/.config/nvim/tmp/sessions
"set backupdir=~/.config/nvim/tmp/backup,.
"
"if has('persistent_undo')
"	set undofile
"	set undodir=~/.config/nvim/tmp/undo,.
"endif
"set colorcolumn=100
"set updatetime=100
"set virtualedit=block
"
"au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" =======================
" Mapping
" =======================
let mapleader="\<SPACE>"

nmap <leader>uu :PlugUpgrade<cr>:PlugUpdate<cr>:CocUpdate<cr>

noremap ; :

" Save & quit
noremap Q :q<CR>
"noremap <C-q> :qa<CR>
noremap S :w<CR>

" Copy & Paste
vnoremap Y "+y
"noremap Y "+y
noremap P "+p

" Search
nnoremap <esc><esc> :noh<return><esc>

" Spell check
map <leader>sc :set spell!<cr>

" Adjacent duplicate words
"noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1
noremap <leader>ii :source $MYVIMRC<cr>
noremap <leader>ie :edit $MYVIMRC<cr>

" Switch buffer
noremap bn :bnext<cr>
noremap bp :bprevious<cr>

" Tab
noremap tu :tabe<CR>
noremap tp :-tabnext<CR>
noremap tn :+tabnext<CR>
noremap tmp :-tabmove<CR>
noremap tmn :+tabmove<CR>

" Terminal
map tt :tabnew<cr>:term<cr>
map tb :set splitbelow<cr>:split<cr>:res -10<cr>:term<cr>
map tx :tabclose<cr>
tnoremap <m-c> <C-\><C-N>
tnoremap <m-x> <C-\><C-N><C-O>:q<cr>

" Disable the default s key
noremap s <nop>
noremap b <nop>

" Resize
map <up> :res +5<cr>
map <down> :res -5<cr>
map <left> :vertical resize-5<cr>
map <right> :vertical resize+5<cr>

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" =======================
" Compile function
" =======================
noremap <leader>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc

" =======================
" For Windows
" =======================
"if has("win32")
"	"set shell=powershell.exe
"	set shell=cmd.exe
"	"set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive\ -ExecutionPolicy\ RemoteSigned
"	set shellpipe=|
"	"set shellredir=>
"endif

" =======================
" Plug Setting
" =======================

" ------------
" Theme
" ------------
color gruvbox

" Opacity
"hi Normal guibg=NONE ctermbg=NONE

" ------------
" AutoFormat
" ------------
" Google Format
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

" ------------
" NERDTree
" ------------
nnoremap <leader>nf :NERDTreeFocus<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>nn :NERDTree<CR>
"nnoremap <leader>nf :NERDTreeFind<CR>

let g:NERDTreeGitStatusUseNerdFonts = 1

" ------------
" Airline
" ------------
let g:bufferline_modified = '*'
let g:bufferline_echo = 0

" ------------
" Easymotion
" ------------
"" <Leader>f{char} to move to {char}
map  <Leader>mm <Plug>(easymotion-bd-f)
nmap <Leader>mm <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>ml <Plug>(easymotion-bd-jk)
nmap <Leader>ml <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>mw <Plug>(easymotion-bd-w)
nmap <Leader>mw <Plug>(easymotion-overwin-w)" Move to word

" ------------
" fzf
" ------------
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>ff :Files<CR>
nnoremap <silent> <Leader>fr :Rg<CR>
nnoremap <silent> <Leader>fl :Lines<CR>
nnoremap <silent> <Leader>fg :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>fh :History<CR>
nnoremap <silent> <Leader>fc :History:<CR>
nnoremap <silent> <Leader>fv :Vista finder<CR>

" ------------
" FullScreen
" ------------
let g:fullscreen#start_command = "call rpcnotify(0, 'Gui', 'WindowFullScreen', 1)"
let g:fullscreen#stop_command = "call rpcnotify(0, 'Gui', 'WindowFullScreen', 0)"

" ------------
" Vista
" ------------
"nnoremap <silent> <Leader>vv :Vista<CR>
"nnoremap <silent> <Leader>vc :Vista!<CR>
"nnoremap <silent> <Leader>vt :Vista!!<CR>
"" How each level is indented and what to prepend.
"" This could make the display more compact or more spacious.
"" e.g., more compact: ["▸ ", ""]
"" Note: this option only works for the kind renderer, not the tree renderer.
"let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"
"" Executive used when opening vista sidebar without specifying it.
"" See all the avaliable executives via `:echo g:vista#executives`.
"let g:vista_default_executive = 'ctags'
"
"" Set the executive for some filetypes explicitly. Use the explicit executive
"" instead of the default one for these filetypes when using `:Vista` without
"" specifying the executive.
"let g:vista_executive_for = {
"			\ 'cpp': 'vim_lsp',
"			\ 'php': 'vim_lsp',
"			\ }
"
"" Declare the command including the executable and options used to generate ctags output
"" for some certain filetypes.The file path will be appened to your custom command.
"" For example:
"let g:vista_ctags_cmd = {
"			\ 'haskell': 'hasktags -x -o - -c',
"			\ }
"
"" To enable fzf's preview window set g:vista_fzf_preview.
"" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
"" For example:
""let g:vista_fzf_preview = ['right:50%']
"" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
"let g:vista#renderer#enable_icon = 1
"
"" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
"let g:vista#renderer#icons = {
"			\   "function": "\uf794",
"			\   "variable": "\uf71b",
"			\  }
