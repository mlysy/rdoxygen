#' @details For git users: by default the Doxygen documentation is stored in \code{inst/doc/doxygen}, but this folder is often added to \code{.gitignore} (e.g., by \code{devtools::use_vignettes}).  To unignore some or all of the Doxygen documentation, you may wish to add the following lines to the package \code{.gitignore}:
#' \preformatted{
#' # ignore inst/doc, but allow its contents to be selectively unignored
#' !inst/doc
#' inst/doc/*
#'
#' # unignore just the Doxyfile (need Doxygen to recompile the docs)
#' !inst/doc/doxygen/Doxyfile
#'
#' # unignore all the Doxygen documentation
#' !inst/doc/doxygen
#' }
