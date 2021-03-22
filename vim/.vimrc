if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'jpalardy/vim-slime'
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
runtime! plugin/sensible.vim

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

set background=dark
set t_Co=256
" set termguicolors

colorscheme gruvbox
hi Normal ctermbg=NONE guibg=NONE
set ls=0

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>


xmap ga <Plug>(EasyAlign)

let g:slime_target = "tmux"
let g:slime_cell_delimiter = "#%"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

" nmap <S-CR> <Plug>SlimeSendCell
" nmap <S-CR> <Plug>SlimeSendCell :set nohlsearch<CR> /#%<CR>:let @/ = ""<CR>:set hlsearch<CR>+


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
