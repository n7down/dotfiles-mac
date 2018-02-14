set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'scrooloose/nerdtree'
Plugin 'myusuf3/numbers.vim'
Plugin 'xuyuanp/nerdtree-git-plugin'
Plugin 'valloric/youcompleteme'
Plugin 'scrooloose/syntastic'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'universal-ctags/ctags'
Plugin 'tpope/vim-surround'
Plugin 'moll/vim-bbye'
Plugin 'Chiel92/vim-autoformat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on
filetype plugin indent on
set laststatus=2            " be iMproved, required
set encoding=utf-8

set autoindent
set noexpandtab
set tabstop=4
set shiftwidth=4

" nerdtree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

map <C-t> :NERDTreeToggle<CR>

" hemisu
set background=dark
colorscheme hemisu

" air-line
let g:airline_solarized_bg='dark'

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" air-line tabs
let g:airline#extensions#tabline#enabled = 1

" numbers
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" backspace
set backspace=indent,eol,start

" buffers
" nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nmap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
" nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nmap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
" map <C-d> :bp<bar>sp<bar>bn<bar>bd<CR>
map <C-w> :Bdelete<CR>

" mouse
set mouse=a

" nerdtree git plugin
let g:NERDTreeIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ 'Ignored'   : '☒',
			\ "Unknown"   : "?"
			\ }

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0 " Don't auto open/close location list
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode="passive"
let g:syntastic_enable_signs=0

nnoremap <silent> <c-e> :SyntasticCheck<CR> :lopen<CR>
let g:syntastic_error_symbol = "✖"
let g:syntastic_warning_symbol = "!"
let g:syntastic_cpp_check_header = 1
let g:syntastic_c_check_header = 1
let g:syntastic_c_include_dirs = ['src', 'src/main', 'src/main/target/BETAFLIGHTF3']
let g:syntastic_cpp_include_dirs = ['src', 'src/main']

" this is causing issues
let g:ycm_filetype_specific_completion_to_disable = {
			\ 'cpp': 1
			\ }
let g:ycm_show_diagnostics_ui = 0

function! ToggleErrors()
	if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
		" No location/quickfix list shown, open syntastic error location panel
		Errors
	else
		lclose
	endif
endfunction

" nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>

" tagbar
nmap <C-y> :TagbarToggle<CR>

" start tagbar on startup
"autocmd VimEnter * nested :TagbarOpen
"autocmd BufEnter * nested :call tagbar#autoopen(0)

let g:tagbar_type_cpp = {
			\ 'ctagstype' : 'c++',
			\ 'kinds'     : [
			\ 'd:macros:1:0',
			\ 'p:prototypes:1:0',
			\ 'g:enums',
			\ 'e:enumerators:0:0',
			\ 't:typedefs:0:0',
			\ 'n:namespaces',
			\ 'c:classes',
			\ 's:structs',
			\ 'u:unions',
			\ 'f:functions',
			\ 'm:members:0:0',
			\ 'v:variables:0:0'
			\ ],
			\ 'sro'        : '::',
			\ 'kind2scope' : {
			\ 'g' : 'enum',
			\ 'n' : 'namespace',
			\ 'c' : 'class',
			\ 's' : 'struct',
			\ 'u' : 'union'
			\ },
			\ 'scope2kind' : {
			\ 'enum'      : 'g',
			\ 'namespace' : 'n',
			\ 'class'     : 'c',
			\ 'struct'    : 's',
			\ 'union'     : 'u'
			\ }
			\ }

au BufWinLeave,BufWritePost,BufLeave * if expand("%") != "" && &buftype == "" | silent mkview! | endif
au BufWinEnter,BufReadPost,BufEnter * if expand("%") != "" && &buftype == "" | silent loadview | endif

" snips
let g:UltiSnipsExpandTrigger="<C-z>"
let g:UltiSnipsJumpForwardTrigger="<C-s>"
let g:UltiSnipsJumpBackwardTrigger="<C-x>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" redo
nmap <S-u> :redo<CR>

" window switching
" right
:nmap <silent> <C-h> :wincmd h<CR>
" down
:nmap <silent> <C-j> :wincmd j<CR>
" up
:nmap <silent> <C-k> :wincmd k<CR>
" left
:nmap <silent> <C-l> :wincmd l<CR>

" cscope
" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

	""""""""""""" Standard cscope/vim boilerplate

	" use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
	set cscopetag

	" check cscope for definition of a symbol before checking ctags: set to 1
	" if you want the reverse search order.
	set csto=0

	" add any cscope database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add the database pointed to by environment variable
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif

	" show msg when any other cscope db added
	set cscopeverbose
endif

" check https://github.com/chazy/cscope_maps/blob/master/plugin/cscope_maps.vim for mappings
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d<C-R>=expand("<cword>")<CR><CR>

nmap <C-]>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-]>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-]>d :scs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-]><C-]>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-]><C-]>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-]><C-]>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-]><C-]>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-]><C-]>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-]><C-]>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-]><C-]>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-]><C-]>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
