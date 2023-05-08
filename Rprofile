options(prompt = crayon::blue("R> "))
options(continue="... ")
options(editor="vim")
options(width = 100)
options(stringsAsFactors=FALSE)

q <- function (save="no", ...) {
  quit(save=save, ...)
}

options(error = quote({dump.frames(to.file=TRUE); q()}))
