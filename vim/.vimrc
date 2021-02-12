if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'urbainvaes/vim-ripple', {'for': ['python', 'julia']}
Plug 'davidhalter/jedi-vim', {'for': ['python']}
Plug 'fatih/vim-go', {'for': ['go']}
Plug 'lervag/vimtex', {'for': ['tex']}
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'julialang/julia-vim', {'for': ['julia']}
Plug 'morhetz/gruvbox'
Plug 'romainl/Apprentice'
call plug#end()

let g:python3_host_prog="/home/ginko/.virtualenvs/nvim/bin/python3"
let g:tex_flavor = "latex"

let mapleader=' '

set hidden
set number
set noswapfile 
set ignorecase
set smartcase
set hlsearch
set linebreak
set smartindent
set showmatch
set noshowmode
set clipboard+=unnamedplus
set mouse=a
set whichwrap+=<,>,h,l
set shiftwidth=4
set tabstop=4
set tags+=.tags
set completeopt=longest,menuone
set grepprg=rg\ --vimgrep

set t_Co=256
set termguicolors
set background=dark
colorscheme gruvbox

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>


xmap ga <Plug>(EasyAlign)

" Intelligently navigate tmux panes and Vim splits using the same keys.
" See https://sunaku.github.io/tmux-select-pane.html for documentation.
let progname = substitute($VIM, '.*[/\\]', '', '')
set title titlestring=%{progname}\ %f\ +%l\ #%{tabpagenr()}.%{winnr()}
if &term =~ '^screen' && !has('nvim') | exe "set t_ts=\e]2; t_fs=\7" | endif

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)


function! Grep(...)
	return system(join([&grepprg] + [a:1] + [expandcmd(join(a:000[1:-1], ' '))], ' '))
endfunction

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
  
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd WinEnter * if winnr('$') == 1 && &buftype == "quickfix"|q|endif
	autocmd WinEnter * if winnr('$') == 1 && &filetype == "netrw"|q|endif
augroup END
