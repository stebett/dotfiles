setlocal autowrite
nmap gb <Plug>(go-build)
nmap gr <Plug>(go-run)
let g:go_list_type = "quickfix"
let g:go_imports_autosave = 1
let g:go_bin_path = $HOME . "/.vimgo"
