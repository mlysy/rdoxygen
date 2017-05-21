#' c_test
#' 
#' @export
c_test <- function(x) {
    stopifnot(is.numeric(x))
    out <- .C(C_bar, x = as.double(x), n = length(x))
    return(out$x)
}

