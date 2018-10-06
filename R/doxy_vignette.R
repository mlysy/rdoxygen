#' Creates a doxygen vignette
#'
#' Creates an R Markdown wrapper for the doxygen documentation so that it can be viewed from within R with a call to \code{vignette()}.
#'
#' @template param-pkg
#' @param index A string with the path relative to \code{pkg/inst} of the \code{index.html} file of the doxygen documentation.  Default: \code{doc/doxygen/html}, see Note.
#' @param name A string giving the name of the \code{.Rmd} vignette file wrapping the documentation, as well as the name to retrieve the documentation using \code{vignette()}.  Default: \code{"doxygenVignette.Rmd"}
#' @param overwrite A boolean for whether to overwrite the file \code{pkg/vignettes/name.Rmd} if found.  Otherwise returns an error.  Default: \code{FALSE}
#'
#' @return \code{NULL}
#'
#' @details This function creates the file \code{vignettes/name.Rmd} in the package root folder, containing the necessary meta-data for viewing the Doxygen HTML documentation from within R with a call to \code{vignette()}.  When the vignette is built (e.g., with \code{R CMD build} or \code{devtools::build_vignettes()}), a file \code{inst/doc/name.html} is created, and it is this file which is opened by the call to \code{vignette("name")} after the package is installed.  The contents of \code{inst/doc/name.html} are simply a "redirect" to the Doxygen index file, \code{index/index.html}.
#'
#' @note The call to \code{vignette()} will *only* open HTML files stored in the \code{doc} subfolder of an installed package.  Therefore the Doxygen documentation referred to by \code{index} must be stored in a subfolder of \code{inst/doc} for the call to \code{vignette()} post-installation to work.
#'
#' @export
doxy_vignette <- function(
  pkg = ".",
  index = "doc/doxygen/html",
  name = "doxygenVignette.Rmd",
  overwrite = FALSE
) {
  
  # move to root directory
  initFolder <- getwd()
  on.exit(setwd(initFolder)) # resets to this even after error
  pkg <- normalizePath(pkg, winslash="/")
  setwd(pkg)
  if(length(grep("DESCRIPTION", dir())) == 0) {
    stop("pkg is not the root directory of a package.")
  }


  # path of doxygen index file relative to inst/doc
  indexFile <- file.path("..", index, "index.html")

  # vignette name and file name
  if(tolower(tools::file_ext(name)) != "rmd") {
    name <- paste0(name, ".Rmd")
  }
  ## if(tools::file_ext(name) == "Rmd") {
  ##   vignetteFile <- name
  ##   name <- tools::file_path_sans_ext(vignetteFile)
  ## } else {
  ##   vignetteFile <- paste0(name, ".Rmd")
  ## }

  # check if file name already exists
  name <- file.path("vignettes", name)
  suppressWarnings({
    pass <- file.copy(from = system.file("sys", "doxygenVignette.Rmd",
                                         package = "rdoxygen"),
                      to = file.path(pkg, name),
                      overwrite = overwrite, recursive = TRUE)
  }
  )
  if(!pass) {
    stop("Vignette file '", file.path("vignettes", basename(name)),
         "' already exists.  Not overwritten.")
  }

  # modify template vignette to link to Doxygen doc
  vignetteLines <- readLines(name)
  vignetteLines <- gsub(pattern = "@doxy::Redirect@",
                        replacement = indexFile,
                        x = vignetteLines)
  cat(vignetteLines, sep = "\n", file = name)

  invisible(NULL)
}
