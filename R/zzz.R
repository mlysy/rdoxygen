# General roxygen tags
#' @useDynLib rdoxygen, .registration = TRUE, .fixes = "C_"
#' 
#' @export
.onUnload <- function (libpath) {
  library.dynam.unload("rdoxygen", libpath)
}