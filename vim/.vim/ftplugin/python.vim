set define=^class
autocmd BufWritePost *.py silent make! <afile> | silent redraw!

let g:jedi#popup_on_dot = 0
let g:vimspector_enable_mappings = 'HUMAN'

nnoremap gr :wa <bar> !python % <cr>
