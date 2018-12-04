" Function to remove trailing whitespaces
function! TrimTrailingWhiteSpace()
	let s:save = winsaveview()
	%s/\s\+$//e
	call winrestview(s:save)
endfunction

