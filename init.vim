" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: @gallon


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
    let has_machine_specific_file = 0
    silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim


" ==============================
" Editor Setup
" ==============================
" ===============
" system
" ===============
" auto change dir
" set autochdir
" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has ('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif


" ===============
" Editor Behavior
" ===============
syntax on
set number
set relativenumber
set cursorline
set mouse-=a

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Tab settings
" Don't expand tab to space
set expandtab
" Set tab = 4 spaces, default 8
set tabstop=4
set shiftwidth=4
set softtabstop=4
" Set tab base on file
set smarttab

"For go
au BufNewFile,BufRead *.go set filetype=go  noexpandtab tabstop=4 shiftwidth=4

"For python
au BufRead,BufNewFile *.py set shiftwidth=4 tabstop=4 softtabstop=4 expandtab smarttab autoindent


" Display unprintable chars
set list
set listchars=tab:\|\ ,trail:▫
set showbreak=↪

" Text display settings
set linebreak
set textwidth=80
set autoindent
set nowrap
set whichwrap+=h,l,<,>,[,]

" Minimal number of screen lines to keep above and below the cursor
set scrolloff=8
" How many lines to scroll at a time, make scrolling appears faster
set scrolljump=4

" Keycode no times out
set ttimeoutlen=0
set notimeout

" Restore cursor's position while reopen file
" base on view
set viewoptions=cursor,folds,slash,unix

" Folds settings
set foldmethod=indent
set foldlevelstart=99
set foldenable
au BufEnter * setlocal fo-=c fo-=r fo-=o
" set formatoptions-=tc

" Always splits to the right and below
set splitright
set splitbelow

set noshowmode
set showcmd
set wildmenu

" Case insensitive search
set ignorecase
set smartcase

set shortmess+=c

" Preview command
set inccommand=split

" Complete options
set completeopt=longest,noinsert,menuone,noselect,preview

" Make scrolling faster
set ttyfast
set lazyredraw
set regexpengine=1

" No beeping but a visual bell
set visualbell

" Backup settings
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo,.
endif

" Highlight column after 'textwidth'
set colorcolumn+=1

" Time that swap file will be written to disk
set updatetime=100

" Autojump to last cursor line
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===============
" Terminal Behaviors
" ===============
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'


" ===============
" Basic Mappings
" ===============
" Set <LEADER> as <SPACE>, ; as :
let mapleader="\<SPACE>"
let g:mapleader = "\<SPACE>"
let maplocalleader = "\<SPACE>"
let g:maplocalleader = "\<SPACE>"
noremap ; :
noremap : q:i

" Save & quit
noremap Q :q<CR>
noremap <c-q> :qa<CR>
noremap S :w<CR>

" Make Y to copy till the end of line
nnoremap Y y$

" Indentation
nnoremap < <<
nnoremap > >>

" Search
noremap <LEADER><CR> :nohlsearch<CR>

" Folding
noremap <silent> <LEADER>o za

" Open up lazygit
noremap \g :term lazygit
noremap <c-g> :tabe<CR>:term lazygit<CR>


" ===============
" Cursor Movement
" ===============
" Faster move
noremap <silent> J 5j
noremap <silent> K 5k
noremap <silent> L $
noremap <silent> H 0
noremap <silent> W 5w
noremap <silent> B 5b
noremap <C-S> 5<c-e>
noremap <C-D> 5<c-y>

" Insert mode cursor movement
inoremap <C-a> <ESC>A


" ===============
" Window Management
" ===============
" Use <space> + new arrow keys for moving the cursor around windows
noremap <leader>w <C-w>w
noremap <leader>k <C-w>k
noremap <leader>j <C-w>j
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l

" tab or buf 1
nnoremap <leader>1 :call functions#tab_buf_switch(1)<cr>
" tab or buf 2
nnoremap <leader>2 :call functions#tab_buf_switch(2)<cr>
" tab or buf 3
nnoremap  <leader>3 :call functions#tab_buf_switch(3)<cr>
" tab or buf 4
nnoremap  <leader>4 :call functions#tab_buf_switch(4)<cr>
" tab or buf 5
nnoremap  <leader>5 :call functions#tab_buf_switch(5)<cr>
" tab or buf 6
nnoremap  <leader>6 :call functions#tab_buf_switch(6)<cr>
" tab or buf 7
nnoremap  <leader>7 :call functions#tab_buf_switch(7)<cr>
" tab or buf 8
nnoremap  <leader>8 :call functions#tab_buf_switch(8)<cr>
" tab or buf 9
nnoremap  <leader>9 :call functions#tab_buf_switch(9)<cr>

" Disable the default s key
noremap s <nop>

" Split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>


" ===============
" Tab Management
" ===============
" Create a new tab
noremap tn :tabe<CR>
" Move around tabs
noremap t- :-tabnext<CR>
noremap t= :+tabnext<CR>
" Move the tabs
noremap tm- :-tabmove<CR>
noremap tm= :+tabmove<CR>


" ===============
" Other useful stuff
" ===============
" Source nvim
noremap <Leader>rc :source $HOME/.config/nvim/init.vim<CR>


" Open a terminal window
noremap <Leader>/ :term<CR>

" Press space twice to jump to the next '' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Call figlet
noremap tx :r !figlet

noremap <LEADER>- :lN<CR>
noremap <LEADER>= :lne<CR>

" Find and replace
noremap \s :%s///g<left><left>

" Compile function
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
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :term python3 %
    elseif &filetype == 'html'
        silent! exec "!".g:mkdp_browser." % &"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :term go run %
    endif
endfunc


" ==============================
" Install Plugins with Vim-Plug
" ==============================

call plug#begin('~/.config/nvim/plugged')

" Tab Session et.
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc' " vim-session dep
" Plug 'idanarye/vim-vebugger'
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}
" Plug 'wellle/context.vim'
" Plug 'jceb/vim-orgmode', {'for': ['vim-plug', 'org']}
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}

" Pretty Dress
" Plug 'liuchengxu/eleline.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
"Plug 'morhetz/gruvbox'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rakr/vim-one'
"Plug 'mhartington/oceanic-next'
"Plug 'kristijanhusak/vim-hybrid-material'
"Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ajmwagar/vim-deus'
"Plug 'arzg/vim-colors-xcode'

" Genreal Highlighter
Plug 'jaxbot/semantic-highlight.vim'
Plug 'chrisbra/Colorizer' " Show colors with :ColorHighlight

" Taglist
Plug 'liuchengxu/vista.vim'

" Error checking, handled by coc

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Git
Plug 'airblade/vim-gitgutter'

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
" Plug 'hail2u/vim-css3-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
" Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'jelera/vim-javascript-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'jaxbot/browserlink.vim'

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Rust
Plug 'rust-lang/rust.vim'

" Python
Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'theniceboy/bullets.vim'

" Latex
Plug 'lervag/vimtex'

" Editor Enhancement
"Plug 'Raimondi/delimitMate'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line
Plug 'AndrewRadev/switch.vim' " gs to switch
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'tpope/vim-repeat'
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'junegunn/vim-easy-align' " gaip= to align the = in paragraph,
Plug 'tpope/vim-capslock'   " Ctrl+L (insert) to toggle capslock
Plug 'easymotion/vim-easymotion'
Plug 'machakann/vim-highlightedyank'
Plug 'Konfekt/FastFold'

" Formatter
Plug 'Chiel92/vim-autoformat'

" For general writing
Plug 'junegunn/goyo.vim'

" Bookmarks
Plug 'MattesGroeger/vim-bookmarks'

" Find & Replace
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
Plug 'osyo-manga/vim-anzu'

" Mini Vim-APP
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify'

" Other visual enhancement
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'

" Other useful utilities
Plug 'lambdalisue/suda.vim' " do stuff like :SudoWrite
Plug 'wakatime/vim-wakatime'

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'roxma/nvim-yarp'

call plug#end()



" ==============================
" Plugin Settings
" ==============================
filetype plugin on


" ===============
" Dressup
" ===============
set t_Co=256
set termguicolors

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark    " Setting dark mode
colorscheme deus
let g:deus_termcolors=256

"let ayucolor="mirage"
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:one_allow_italics = 1

"color dracula
"color one
"color deus
"color gruvbox
"let ayucolor="light"
"color ayu
"set background=light
"color xcodedark

hi Normal guibg=NONE ctermbg=None

" ===============
" Startify
" ===============
"let g:startify_custom_header = [
            "\ '        _   _ _____ _     _     ___     ____    _    _     _     ___  _   _  ',
            "\ '       | | | | ____| |   | |   / _ \   / ___|  / \  | |   | |   / _ \| \ | | ',
            "\ '       | |_| |  _| | |   | |  | | | | | |  _  / _ \ | |   | |  | | | |  \| | ',
            "\ '       |  _  | |___| |___| |__| |_| | | |_| |/ ___ \| |___| |__| |_| | |\  | ',
            "\ '       |_| |_|_____|_____|_____\___/   \____/_/   \_\_____|_____\___/|_| \_| ',
            "\ '',
            "\ '',
"\]


" ===============
" airline.vim
" ===============

let g:airline_theme='deus'

let g:airline_powerline_fonts = 1
let g:airline_extensions = ['tabline', 'virtualenv', 'branch']
let g:airline#extensions#tabline#enabled = 1
let g:airline#extension#tabline#show_splits = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'
let g:airline#extensions#hunks#enabled = 1

let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#branch#enabled = 1

let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_highlighting_cache = 1
let g:airline#extensions#tabline#show_tab_type = 1


" ===============
" Vim-repeat
" ===============
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)


" ===============
" GitGutter
" ===============
let g:gitgutter_signs = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap <Leader>H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>


" ===============
" Nerdcommenter
" ===============
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 0


" ===============
" Floaterm
" ===============
let g:floaterm_position      = 'center'
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F10>'


" ===============
" Coc
" ===============
" fix the most annoying bug that coc has
silent! au BufEnter,BufRead,BufNewFile * silent! unmap if

let g:coc_global_extensions = ['coc-vimlsp', 'coc-python', 'coc-java', 'coc-rls','coc-texlab' , 'coc-json', 'coc-yank', 'coc-gitignore', 'coc-git', 'coc-explorer']

" use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
" \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

nmap tt :CocCommand explorer<CR>

" coc-todolist
noremap ta :CocCommand todolist.create<CR>
noremap td :CocCommand todolist.upload<CR>
noremap tD :CocCommand todolist.download<CR>
noremap tc :CocCommand todolist.clearNotice<CR>
noremap tc :CocCommand todolist.clearNotice<CR>
noremap tl :CocList --normal todolist<CR>


" coc-translator
nmap ts <Plug>(coc-translator-p)

" coc-markmap
command! Markmap CocCommand markmap.create


" ===============
" MarkdownPreview
" ===============
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1
            \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let vim_markdown_preview_hotkey='<C-p>'


" ===============
" Latex
" ===============
let g:tex_flavor='latex'

" 阅读器相关的配置 包含正反向查找功能 仅供参考
let g:vimtex_view_general_viewer = 'skim'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options
\ = '-reuse-instance -forward-search @tex @line @pdf'
\ . ' -inverse-search "' . exepath(v:progpath)
\ . ' --servername ' . v:servername
\ . ' --remote-send \"^<C-\^>^<C-n^>'
\ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
\ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
\ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'

set conceallevel=1
let g:tex_conceal='abdmg'
" let g:vimtex_quickfix_mode=0


" ===============
" Vim-table-mode
" ===============
noremap <Leader>tm :TableModeToggle<CR>


" ===============
" Vim-bookmarks
" ===============
let g:bookmark_no_default_key_mappings = 1
nmap mt <Plug>BookmarkToggle
nmap ma <Plug>BookmarkAnnotate
nmap ml <Plug>BookmarkShowAll
nmap mn <Plug>BookmarkNext
nmap mp <Plug>BookmarkPrev
nmap mc <Plug>BookmarkClear
nmap mx <Plug>BookmarkClearAll
nmap mk <Plug>BookmarkMoveUp
nmap mj <Plug>BookmarkMoveDown
nmap <Leader>g <Plug>BookmarkMoveToLine
let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_manage_per_buffer = 1
let g:bookmark_save_per_working_dir = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1
let g:bookmark_location_list = 1


" ===============
" Undotree
" ===============
noremap <Leader>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function! g:Undotree_CustomMap()
    nmap <buffer> k <plug>UndotreeNextState
    nmap <buffer> j <plug>UndotreePreviousState
    nmap <buffer> K 5<plug>UndotreeNextState
    nmap <buffer> J 5<plug>UndotreePreviousState
endfunc


" ===============
" Vim-multiple-cursor
" ===============
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key = '<c-n>'
let g:multi_cursor_select_all_word_key = '<a-n>'
let g:multi_cursor_start_key = 'g<c-n>'
let g:multi_cursor_select_all_key = 'g<a-k>'
let g:multi_cursor_next_key = '<c-n>'
let g:multi_cursor_prev_key = '<c-p>'
let g:multi_cursor_skip_key = '<C-s>'
let g:multi_cursor_quit_key = '<Esc>'


" ===============
" Bullets.vim
" ===============
let g:bullets_enabled_file_types = [
            \ 'markdown',
            \ 'text',
            \ 'gitcommit',
            \ 'scratch'
            \]


" ===============
" Vista.vim
" ===============
noremap <silent> <Leader>v :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
            \   "function": "\uf794",
            \   "variable": "\uf71b",
            \  }
function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()


" ===============
" Ultisnips
" ===============
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" ===============
" Anzu
" ===============
set statusline=%{anzu#search_status()}
nnoremap = n
nnoremap - N


" ===============
" Vim-go
" ===============
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0


" ===============
" AutoFormat
" ===============
nnoremap \f :Autoformat<CR>


" ===============
" OmniSharp
" ===============
" let g:OmniSharp_typeLookupInPreview = 1
" let g:omnicomplete_fetch_full_documentation = 1

" let g:OmniSharp_server_use_mono = 1
" let g:OmniSharp_server_stdio = 1
" let g:OmniSharp_highlight_types = 2
" let g:OmniSharp_selector_ui = 'ctrlp'

" autocmd Filetype cs nnoremap <buffer> gd :OmniSharpPreviewDefinition<CR>
" autocmd Filetype cs nnoremap <buffer> gr :OmniSharpFindUsages<CR>
" autocmd Filetype cs nnoremap <buffer> gy :OmniSharpTypeLookup<CR>
" autocmd Filetype cs nnoremap <buffer> ga :OmniSharpGetCodeActions<CR>
" autocmd Filetype cs nnoremap <buffer> <LEADER>rn :OmniSharpRename<CR><C-N>:res +5<CR>

" sign define OmniSharpCodeActions text=💡

" augroup OSCountCodeActions
    " autocmd!
    " autocmd FileType cs set signcolumn=yes
    " autocmd CursorHold *.cs call OSCountCodeActions()
" augroup END

" function! OSCountCodeActions() abort
    " if bufname('%') ==# '' || OmniSharp#FugitiveCheck() | return | endif
    " if !OmniSharp#IsServerRunning() | return | endif
    " let opts = {
                " \ 'CallbackCount': function('s:CBReturnCount'),
                " \ 'CallbackCleanup': {-> execute('sign unplace 99')}
                " \}
    " call OmniSharp#CountCodeActions(opts)
" endfunction

" function! s:CBReturnCount(count) abort
    " if a:count
        " let l = getpos('.')[1]
        " let f = expand('%:p')
        " execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
    " endif
" endfunction


" ===============
" Colorizer
" ===============
let g:colorizer_syntax = 1


" ===============
" Vim-easymotion
" ===============
let g:EasyMotion_leader_key = ","


" ===============
" Goyo
" ===============
map <Leader>gy: Goyo<CR>


" ===============
" Fastfold
" ===============
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook               = 1
let g:fastfold_fold_command_suffixes  = ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'ze', 'zu']
let g:markdown_folding                = 1
let g:tex_fold_enabled                = 1
let g:vimsyn_folding                  = 'af'
let g:xml_syntax_folding              = 1
let g:javaScript_fold                 = 1
let g:sh_fold_enabled                 = 7
let g:ruby_fold                       = 1
let g:perl_fold                       = 1
let g:perl_fold_blocks                = 1
let g:r_syntax_folding                = 1
let g:rust_fold                       = 1
let g:php_folding                     = 1


" ===============
" Vim-easy-align
" ===============
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" ===============
" Rainbow
" ===============
let g:rainbow_active = 1


" ===============
" Vim-session
" ===============
let g:session_directory = $HOME."/.config/nvim/tmp/sessions"
let g:session_autosave = 'no'
let g:session_autoload = 'no'
"let g:session_autosave_periodic = 1
"let g:session_autosave_silent = 1
set sessionoptions-=buffers
set sessionoptions-=options
noremap so :OpenSession<CR>
noremap ss :SaveSession<CR>
noremap sc :CloseSession<CR>
noremap sd :DeleteSession<CR>
noremap sa :AppendTabSession<CR>


" ===============
" Suda.vim
" ===============
let g:suda_smart_edit = 1


" ==============================
" Necessary Commands to Execute
" ==============================
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ~/.config/nvim/_machine_specific.vim"
endif
