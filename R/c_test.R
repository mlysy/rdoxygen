#' R frontend of the C function bar
#'
#' A mask function to test if the dummy C code in src/bar.c
#' works.
#'
#' \code{c_test(x)} = x^2.
#'
#' @param x a numeric vector
#'
#' @return a numeric vector x^2
#'
#' @examples
#'
#' \dontrun{
#'   x <- rnorm(10)
#'   c_test(x)
#' }
#'
#' @keywords internal
#'
c_test <- function(x) {
    stopifnot(is.numeric(x))
    out <- .C(C_bar, x = as.double(x), n = length(x))
    return(out$x)
}

