" Function to change the contents of a register. Very useful for editing macros
" Change register
function! ChangeReg() abort
  let r = nr2char(getchar())
  if r =~# '[a-zA-Z0-9"@\-:.%#=*"~_/]'
    call feedkeys("q:ilet @" . r . " = \<C-r>\<C-r>=string(@" . r . ")\<CR>\<ESC>", 'n')
  endif
endfunction
