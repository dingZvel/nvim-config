" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" PLUGINS 
" ~/.config/nvim/plugged (UNIX)
" /user/<username>/appdata/local/nvim/plugged (WINDOWS)
call plug#begin(stdpath('config').'/plugged')

"Looks
Plug 'tomasr/molokai'
Plug 'navarasu/onedark.nvim'
Plug 'kyazdani42/nvim-web-devicons'

"Functional
Plug 'jiangmiao/auto-pairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'glepnir/dashboard-nvim'
Plug 'nvim-telescope/telescope.nvim'

"Hybrid
Plug 'hoob3rt/lualine.nvim'
Plug 'lewis6991/gitsigns.nvim'

"Navigation
Plug 'kyazdani42/nvim-tree.lua'
Plug 'romgrk/barbar.nvim'
Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'

call plug#end()

" KEYBINDINGS

" leaders
let g:mapleader = " "
let g:maplocalleader = ','

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" clear highlight
nnoremap <leader>m :noh<return>
nno <BS> :set hls!\|set hls?<CR>

" init.vim quick edits
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" show colors
nnoremap <leader>c :so $VIMRUNTIME/syntax/hitest.vim<return>

" toggle wrap
nnoremap <buffer><localleader>w :set wrap!<cr>

" buffer settings
nnoremap <s-tab> :bp<return>
nnoremap <tab> :bn<return>
nnoremap <silent><leader>d :bp\|bd #\|BarbarEnable<return>

" save remaps
nnoremap <leader>W :w !diff % -<cr>
nnoremap <leader>w :w<cr>

" primeagen remaps
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJz`v

" STANDARD SETTINGS

" natural split settings
set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99

" Code Editor settings
filetype plugin on
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Core settings
cd E:\Coding
filetype plugin on
set tabstop=4
"set fileencodings=utf-8,gbk2312,gbk,gb18030,cp936
"set encoding=utf-8
syntax on
set nu 
set clipboard=unnamedplus " public copy/paste register
set ruler
"set nowrap
set showcmd
set noswapfile " doesn't create swap files
set noshowmode
set shortmess+=c
set omnifunc=syntaxcomplete#Complete
set shell=cmd
set hidden
"set sidescroll=1
set history=1024
"set number
" 显示相对行号，便于 nj/nk 跳转
"set relativenumber number
" 插入模式显示绝对行号，普通模式显示相对行号
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber

" Indentation and mouse
set backspace=indent,eol,start " let backspace delete over lines
" 自适应不同语言的智能缩进
filetype indent on
" 自动缩进
set autoindent
" 使用 C/C++ 语言的自动缩进方式
set cindent
" C/C++ 语言的具体缩进方式
set cinoptions=g0,:0,N-s,(0
" 智能选择对齐方式
set smartindent
" 当一行字符超过窗口宽度时，禁止换行显示
set nowrap
" 当打开换行显示时，在空格处换行
set linebreak
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 打开断行模块对亚洲语言支持
" m 表示允许在两个汉字之间断行， 即使汉字之间没有出现空格
" B 表示将两行合并为一行的时候， 汉字与汉字之间不要补空格
set formatoptions+=mB
" 横向滚动的最少列数
set sidescroll=10
" 光标离窗口上下边界 5 行时窗口自动滚动
set scrolloff=5
" 最多可以撤销的改变个数
set undolevels=1000
" 保存缓冲区重载撤销的最大行数(number of lines to save for undo)
set undoreload=10000

"set autoindent
"set smartindent " allow vim to best-effort guess the indentation
set autoread
set pastetoggle=<F1> " enable paste mode
set mouse+=a

" Searching
set smartcase
set ignorecase
set wildmenu "graphical auto complete menu

"set lazyredraw "redraws the screne when it needs to
set showmatch "highlights matching brackets
set incsearch "search as characters are entered
set nohlsearch "remove highlight

"if has("win32")
"    set fileencoding=chinese
"else
"    set fileencoding=utf-8
"endif
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"解决consle输出乱码
language messages zh_CN.utf-8


" run code
"augroup compileandrun
"    autocmd!
"    autocmd filetype python nnoremap <f5> :w <bar> :!python3 % <cr>
"	autocmd filetype cpp nnoremap <silent> <f3> :!g++ -O0 -fsyntax-only %<cr>
"	autocmd filetype cpp nnoremap <silent> <f4> :!start cmd /c a.exe ^& pause<cr><cr>
"	autocmd filetype cpp nnoremap <silent> <f5> :!g++ -O2 %<cr> :!start cmd /c a.exe ^& pause<cr><cr>
"    autocmd filetype java nnoremap <f5> :w <bar> !javac % && java %:r <cr>
" augroup END
map <F5> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

"custom
autocmd BufEnter * silent! lcd %:p:h


" RICING

" true colours
if !has('gui_running')
  set t_Co=256
endif
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

" colorscheme
set background=dark
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

" GUI SETTINGS

" standard
"set guifont=Cascadia\ Code:h14
set guifont=JetBrainsMono\ NF:h14
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" neovide specific
function Neovide_fullscreen()
    if g:neovide_fullscreen == v:true
        let g:neovide_fullscreen=v:false
    else
        let g:neovide_fullscreen=v:true
    endif
endfunction
map <F11> :call Neovide_fullscreen()<cr>
" Temperory till, neovide resolves the blur issues
let g:neovide_window_floating_opacity = 0
let g:neovide_floating_blur = 0
let g:neovide_floating_opacity = 0.9

" PLUGIN SETTINGS


" --- LOOKS ---
" NO-config: <colorscheme>, nvim-web-devicons


" --- FUNCTIONAL ---

" NO-config: auto-pairs, plenary

"VIM-FLOATERM
let g:floaterm_keymap_toggle = '<F1>'

" DASHBOARD
let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_header = [
						\'','','','',
						\'Welcome back, dingZvel!', 
						\'','','','',
	 \] " Change to your name

let g:dashboard_custom_shortcut={
\ 'last_session'       : '      ',
\ 'find_history'       : '      ',
\ 'find_file'          : 'CTRL P',
\ 'new_file'           : '      ',
\ 'change_colorscheme' : '      ',
\ 'find_word'          : '      ',
\ 'book_marks'         : '      ',
\ }

" TELESCOPE
nnoremap <silent><C-P> :Telescope find_files<cr>

"
" --- HYBRID ---

" LUALINE
lua require('custom.lualine')

" GITSIGNS
lua require('gitsigns').setup()
nnoremap <silent><leader>gn :Gitsigns next_hunk<cr>zzzv
nnoremap <silent><leader>gp :Gitsigns prev_hunk<cr>zzzv
nnoremap <silent><leader>gg :Gitsigns preview_hunk<cr>
nnoremap <leader>gs :Gitsigns stage_hunk<cr>
nnoremap <leader>gc :!git commit -m "
nnoremap <leader>gp :!git push<cr>

" --- NAVIGATION ---

" NVIM TREE
" lua settings

lua require('plugin-config/nvimTree')

" cursorline
autocmd! BufEnter * call ToggleCursorLine()
function! ToggleCursorLine()
    if (bufname("%") =~ "NvimTree")
        setlocal cursorline
    else
        setlocal nocursorline
    endif
endfunction
 
" BARBAR 
let bufferline = get(g:, 'bufferline', {})
" (compatibility with NVIM-TREE)
let s:treeEnabled=0
function! ToggleNvimTree()
	   if s:treeEnabled
			 lua require('custom.tree').close()
			 let s:treeEnabled = 0
	   else
			 lua require('custom.tree').open()
			 let s:treeEnabled = 1
	   endif
endfunction
nnoremap <silent><leader>f :call ToggleNvimTree()<cr>
let bufferline.auto_hide = v:true
let bufferline.animation = v:true
let bufferline.no_name_title = "untitled"

" QUICK SCOPE
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" SNEAK 
" global
let g:sneak#prompt = '  '
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
let g:sneak#label = 1
" highlights
highlight Sneak guifg=white guibg=#708be6 ctermfg=black ctermbg=red gui=none
highlight SneakScope guifg=black guibg=#49A3ff ctermfg=red ctermbg=yellow gui=italic
" remap plugs for 
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;
