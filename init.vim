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


" ==============================
" Install Plugins with Vim-Plug
" ==============================

call plug#begin('~/.config/nvim/plugged')

" Tab Session et.
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc' " vim-session dep

" Pretty Dress
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'morhetz/gruvbox'
"Plug 'ayu-theme/ayu-vim'
"Plug 'rakr/vim-one'
"Plug 'mhartington/oceanic-next'
"Plug 'kristijanhusak/vim-hybrid-material'
"Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'ajmwagar/vim-deus'
"Plug 'arzg/vim-colors-xcode'

" Taglist
Plug 'liuchengxu/vista.vim'

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Rust
Plug 'rust-lang/rust.vim', {'for': 'rust'}

" Editor Enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdcommenter' " in <space>cn to comment a line
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align' " gaip= to align the = in paragraph,
Plug 'easymotion/vim-easymotion'
Plug 'machakann/vim-highlightedyank'
Plug 'Konfekt/FastFold'
Plug 'christoomey/vim-tmux-navigator'

" Find & Replace
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Mini Vim-APP
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify'

" Other visual enhancement
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'

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
let g:coc_global_extensions = [
        \ 'coc-vimlsp',
        \ 'coc-rust-analyzer',
        \ 'coc-python',
        \ 'coc-json',
        \ 'coc-yank',
        \ 'coc-gitignore',
        \ 'coc-snippets',
        \ 'coc-git',
        \ 'coc-explorer']

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

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'Gallon Hu'


" ===============
" Rust
" ===============
let g:rustfmt_autosave = 1


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
" Vista.vim
" ===============
noremap <silent> <Leader>v :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
            \   "function": "\uf794",
            \   "variable": "\uf71b",
            \  }


" ===============
" FZF
" ===============
noremap <silent> <C-p> :Files<CR>
noremap <silent> <C-f> :Rg<CR>
noremap <silent> <C-h> :History<CR>
noremap <C-t> :BTags<CR>
noremap <silent> <C-l> :Lines<CR>
noremap <silent> <C-w> :Buffers<CR>
noremap <leader>, :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

noremap <c-d> :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }


" ===============
" Fzf-gitignore
" ===============
noremap <LEADER>gi :FzfGitignore<CR>


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
" Vim-easymotion
" ===============
let g:EasyMotion_leader_key = ","


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
let g:sh_fold_enabled                 = 7
let g:r_syntax_folding                = 1
let g:rust_fold                       = 1


" ===============
" Vim-easy-align
" ===============
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)


" ===============
" Rainbow
" ===============
let g:rainbow_active = 1


" ==============================
" Necessary Commands to Execute
" ==============================
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
    exec "e ~/.config/nvim/_machine_specific.vim"
endif
