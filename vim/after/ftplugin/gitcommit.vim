" Show the body width boundary
setlocal colorcolumn=73
setlocal textwidth=72

" Warning if first line too long
match ErrorMsg /\%1l.\%>51v/

" Spell check on
setlocal spell
