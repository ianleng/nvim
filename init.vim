" =======================
" Genernal Setting
" =======================
let &t_ut=''
exec "nohlsearch"
set autochdir
set autoindent
set encoding=utf-8
set number
set relativenumber
set mouse=a
set list
set listchars=tab:\|\ ,trail:▫
set cursorline
set wrap
set ignorecase
set smartcase
set scrolloff=5
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set termguicolors
set hidden
"set ttimeoutlen=0
"set notimeout
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.

if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
set colorcolumn=100
set updatetime=100
set virtualedit=block

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" =======================
" Mapping
" =======================
let mapleader="\<SPACE>"
noremap ; :

" Save & quit
noremap Q :q<CR>
"noremap <C-q> :qa<CR>
noremap S :w<CR>

" Copy & Paste
vnoremap Y "+y
"noremap Y "+y
noremap P "+p

" Switch buffer
noremap bn :bnext<cr>
noremap bp :bprevious<cr>

" Search
noremap <LEADER><CR> :nohlsearch<CR>
noremap <leader>nh :nohlsearch<cr>

" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1
noremap <leader>ii :source $MYVIMRC<cr>
noremap <leader>ie :edit $MYVIMRC<cr>

" Search
noremap <LEADER><CR> :nohlsearch<CR>

" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

"noremap <c-j> 10j
"noremap <c-k> 10k
map <leader>sc :set spell!<cr>
map <leader>tt :tabnew<cr>:term<cr>
map <leader>bt :set splitbelow<cr>:split<cr>:res -10<cr>:term<cr>
map <leader>tb :tabclose<cr>
tnoremap <m-c> <C-\><C-N>
tnoremap <m-x> <C-\><C-N><C-O>
"map <leader>tt :call Openterm()<CR>
"function! Openterm() abort
"  let currdir = getcwd()
"  "let netrwdir = fnamemodify(b:netrw_curdir, ':t')
"  "execute 'lcd '.netrwdir
"  execute 'tabnew'
"  execute 'terminal'
"  execute 'lcd '.currdir
"endfunction

" Disable the default s key
noremap s <nop>
noremap b <nop>

" Split setting
noremap sr :set splitright<cr>:vsplit<cr>
noremap sl :set nosplitright<cr>:vsplit<cr>
noremap su :set nosplitbelow<cr>:split<cr>
noremap sb :set splitbelow<cr>:split<cr>

noremap <leader>wh <c-w>h
noremap <leader>wj <c-w>j
noremap <leader>wk <c-w>k
noremap <leader>wl <c-w>l

map <up> :res +5<cr>
map <down> :res -5<cr>
map <left> :vertical resize-5<cr>
map <right> :vertical resize+5<cr>

" =======================
" Tab movement
" =======================
" Create a new tab with tu
noremap tu :tabe<CR>
" Move around tabs with tn and ti
noremap tp :-tabnext<CR>
noremap tn :+tabnext<CR>
" Move the tabs with tmn and tmi
noremap tmp :-tabmove<CR>
noremap tmn :+tabmove<CR>

" =======================
" Directory
" =======================
" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

" =======================
" Compile function
" =======================
noremap <Leader>r :call CompileRunGcc()<CR>
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
		:term python %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device
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
" Plug Install
" =======================
call plug#begin('~/.vim/plugged')

" UI
Plug 'junegunn/seoul256.vim'
Plug 'morhetz/gruvbox'
Plug 'lambdalisue/vim-fullscreen'

" IDE
"Plug 'preservim/nerdtree' |
            "\ Plug 'Xuyuanp/nerdtree-git-plugin' |
"            \ Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}
Plug 'bling/vim-bufferline'
"Plug 'itchyny/vim-cursorword'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'qpkorr/vim-bufkill'
Plug 'OmniSharp/omnisharp-vim'
Plug 'sheerun/vim-polyglot'

" Direction
Plug 'easymotion/vim-easymotion'
Plug 'RRethy/vim-illuminate'
"Plug 'tpope/vim-surround'
Plug 'liuchengxu/vista.vim'

" Git
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Ranger
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

" Funny
Plug 'junegunn/goyo.vim'

call plug#end()

" =======================
" coc plugin
" =======================
let g:coc_global_extensions = [
	\ 'coc-vimlsp',
	\ 'coc-yank',
	\ 'coc-python',
    \ 'coc-omnisharp',
	\ 'coc-snippets',
    \ 'coc-explorer',
    \ 'coc-git',
	\ 'coc-bookmark',
	\ 'coc-translator',
	\ 'coc-json']"

nmap <leader>update :PlugUpgrade<cr>:PlugUpdate<cr>:CocUpdate<cr>

" =======================
" Plug Setting
" =======================

" ------------
" theme
" ------------
"let g:seoul256_background = 235
"let g:seoul256_srgb = 1
"colo seoul256
colo gruvbox

" Opacity
"hi Normal guibg=NONE ctermbg=NONE

" ------------
" airline
" ------------
let g:bufferline_modified = '*'
let g:bufferline_echo = 0

" ------------
" tagbar
" ------------
nmap tb :TagbarToggle<CR>

" ------------
" easymotion
" ------------
" Move to word
map  \w <Plug>(easymotion-bd-w)
nmap \w <Plug>(easymotion-overwin-w)

" Move to line
map \l <Plug>(easymotion-bd-jk)
nmap \l <Plug>(easymotion-overwin-line)

" <Leader>f{char} to move to {char}
map  \f <Plug>(easymotion-bd-f)
nmap \f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap \s <Plug>(easymotion-overwin-f2)

" ------------
" omnisharp
" ------------
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_selector_findusages = 'fzf'

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview', 'popup'
" and 'popuphidden' if you don't want to see any documentation whatsoever.
" Note that neovim does not support `popuphidden` or `popup` yet:
" https://github.com/neovim/neovim/issues/10996
if has('patch-8.1.1880')
  set completeopt=longest,menuone,popuphidden
  " Highlight the completion documentation popup background/foreground the same as
  " the completion menu itself, for better readability with highlighted
  " documentation.
  set completepopup=highlight:Pmenu,border:off
else
  set completeopt=longest,menuone,preview
  " Set desired preview window height for viewing documentation.
  set previewheight=5
endif

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp'] }

augroup omnisharp_commands
  autocmd!

  " Show type information automatically when the cursor stops moving.
  " Note that the type is echoed to the Vim command line, and will overwrite
  " any other messages in this space including e.g. ALE linting messages.
  autocmd CursorHold *.cs OmniSharpTypeLookup

  " The following commands are contextual, based on the cursor position.
  autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfu <Plug>(omnisharp_find_usages)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfi <Plug>(omnisharp_find_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospd <Plug>(omnisharp_preview_definition)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ospi <Plug>(omnisharp_preview_implementations)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ost <Plug>(omnisharp_type_lookup)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osd <Plug>(omnisharp_documentation)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfs <Plug>(omnisharp_find_symbol)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osfx <Plug>(omnisharp_fix_usings)
  autocmd FileType cs nmap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)
  autocmd FileType cs imap <silent> <buffer> <C-\> <Plug>(omnisharp_signature_help)

  " Navigate up and down by method/property/field
  autocmd FileType cs nmap <silent> <buffer> [[ <Plug>(omnisharp_navigate_up)
  autocmd FileType cs nmap <silent> <buffer> ]] <Plug>(omnisharp_navigate_down)
  " Find all code errors/warnings for the current solution and populate the quickfix window
  autocmd FileType cs nmap <silent> <buffer> <Leader>osgcc <Plug>(omnisharp_global_code_check)
  " Contextual code actions (uses fzf, vim-clap, CtrlP or unite.vim selector when available)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  autocmd FileType cs xmap <silent> <buffer> <Leader>osca <Plug>(omnisharp_code_actions)
  " Repeat the last code action performed (does not use a selector)
  autocmd FileType cs nmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)
  autocmd FileType cs xmap <silent> <buffer> <Leader>os. <Plug>(omnisharp_code_action_repeat)

  autocmd FileType cs nmap <silent> <buffer> <Leader>os= <Plug>(omnisharp_code_format)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osnm <Plug>(omnisharp_rename)

  autocmd FileType cs nmap <silent> <buffer> <Leader>osre <Plug>(omnisharp_restart_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>osst <Plug>(omnisharp_start_server)
  autocmd FileType cs nmap <silent> <buffer> <Leader>ossp <Plug>(omnisharp_stop_server)
augroup END

" Enable snippet completion, using the ultisnips plugin
" let g:OmniSharp_want_snippet=1

" ------------
" vista
" ------------
noremap <leader>vv :Vista coc<cr>
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works the LSP executives, doesn't work for `:Vista ctags`.
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
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" ------------
" fzf
" ------------
noremap <silent> fb :Buffers<CR>
noremap <silent> fh :History<CR>
noremap <silent> fl :Lines<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

" ------------
" vimspector
" ------------
nnoremap <c-l> :UndotreeToggle<cr>

" ------------
" vimspector
" ------------
"if has("win32")
"    set json_path='~\AppData\Local\nvim\sample_vimspector_json'
"endif
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	"execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
	"execute '0r $HOME\AppData\Local\nvim\sample_vimspector_json\'.a:template
	execute '0r c:\Users\qsle\AppData\Local\nvim\sample_vimspector_json\'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'dir /b c:\Users\qsle\AppData\Local\nvim\sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
			"\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
noremap <leader>db :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad

" ------------
" coc-translator
" popup
" ------------
nmap ts <Plug>(coc-translator-p)

" ------------
" coc-explorer
" ------------
nmap <leader>e :CocCommand explorer<CR>
nmap <c-x> :BD<cr>
" ------------
" lazygit
" ------------
let g:lazygit_floating_window_winblend = 0 " transparency of floating window
let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window

" ------------
" FullScreen
" ------------
let g:fullscreen#start_command = "call rpcnotify(0, 'Gui', 'WindowFullScreen', 1)"
let g:fullscreen#stop_command = "call rpcnotify(0, 'Gui', 'WindowFullScreen', 0)"

" ------------
" coc-yank
" ------------
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" ------------
" COC
" ------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

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
  inoremap <silent><expr> <c-l> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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
  else
    call CocAction('doHover')
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

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
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
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
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

