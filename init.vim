" =======================
" Plug Install
" =======================
call plug#begin('~/.vim/plugged')

" UI
Plug 'morhetz/gruvbox'
Plug 'lambdalisue/vim-fullscreen'

" IDE
Plug 'preservim/nerdtree' |
			\ Plug 'Xuyuanp/nerdtree-git-plugin' |
			\ Plug 'ryanoasis/vim-devicons' |
			\ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}
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
Plug 'easymotion/vim-easymotion'
Plug 'RRethy/vim-illuminate'
Plug 'tpope/vim-surround'
Plug 'liuchengxu/vista.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Ranger
"Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Funny
"Plug 'junegunn/goyo.vim'

call plug#end()

"=======================
" coc plugin
"=======================
let g:coc_global_extensions = [
			\ 'coc-vimlsp',
			\ 'coc-yank',
			\ 'coc-snippets',
			\ 'coc-pyright',
			\ 'coc-translator',
			\ 'coc-prettier',
			\ 'coc-json']"

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
if has("win32")
	"set shell=powershell.exe
	set shell=cmd.exe
	"set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive\ -ExecutionPolicy\ RemoteSigned
	set shellpipe=|
	"set shellredir=>
endif

" =======================
" Plug Setting
" =======================

" ------------
" Theme
" ------------
colo gruvbox

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
nnoremap <silent> <Leader>vv :Vista<CR>
nnoremap <silent> <Leader>vc :Vista!<CR>
nnoremap <silent> <Leader>vt :Vista!!<CR>
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
			\ 'cpp': 'vim_lsp',
			\ 'php': 'vim_lsp',
			\ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
			\ 'haskell': 'hasktags -x -o - -c',
			\ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
"let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
			\   "function": "\uf794",
			\   "variable": "\uf71b",
			\  }

" ------------
" coc
" ------------
" Translator
nmap ts <Plug>(coc-translator-p)

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"
" coc-default
"
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
	" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
