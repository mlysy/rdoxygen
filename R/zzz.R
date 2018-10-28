# General roxygen tags
#' @useDynLib rdoxygen
#' @importFrom Rcpp sourceCpp
NULL

.onUnload <- function (libpath) {
  library.dynam.unload("rdoxygen", libpath)
}
