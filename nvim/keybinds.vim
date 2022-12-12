" Basic keybinds
nnoremap <silent> <c-S> :w<CR>
nnoremap <silent> <c-C> :x!<CR>

" barbar.vim keybind
nnoremap <silent> <S-RIGHT> <Cmd>BufferNext<CR>
nnoremap <silent> <S-LEFT> <Cmd>BufferPrevious<CR>
nnoremap <silent> <S-c> <Cmd>BufferClose<CR>

" NERDTree keybind
nnoremap <silent> <S-TAB> <Cmd>NERDTreeToggle<CR>
nnoremap <silent> <s-DOWN> <Cmd>NERDTreeFocus<CR>

" autcomplete coc
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


"floatterm 
nnoremap <silent> <s-t> <cmd>FloatermToggle<CR>

" find files
nnoremap <silent> <S-F> <Cmd>Telescope find_files hidden=true<CR>
