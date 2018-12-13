" Function to toggle kTRUE and kFALSE
function! Toggle()
	let s:cursor_pos = getpos('.')
	normal! ^
	let s:returnVal = search("kFALSE", "e", line("."), "stopline")
	if s:returnVal != 0
		echo "kTRUE"
		.s/kFALSE/kTRUE/g
		call setpos('.', s:cursor_pos)
		return
	endif
	let s:returnVal = search("kTRUE", "e", line("."), "stopline")
	if s:returnVal != 0
		echo "kFALSE"
		.s/kTRUE/kFALSE/g
		call setpos('.', s:cursor_pos)
		return
	endif
	echo "ROOT boolean not found on line!"
	call setpos('.', s:cursor_pos)
	return
endfunction
