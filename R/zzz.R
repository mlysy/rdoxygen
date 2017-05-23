# General roxygen tags
#' @useDynLib rdoxygen, .registration = TRUE, .fixes = "C_"
#' 

.onUnload <- function (libpath) {
  library.dynam.unload("rdoxygen", libpath)
}