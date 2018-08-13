#' Creates a doxygen vignette
#'
#' Creates an R Markdown wrapper for the doxygen documentation so that it can be viewed from within R with a call to \code{vignette()}.
#'
#' @param rootFolder A string with the path to the root directory of the R
#'                   package. Default: "."
#' @param pathToIndex A string with the path relative to \code{rootFolder/inst} of the \code{index.html} file of the doxygen documentation.  Default: \code{doxygen/html}, but see Note.
#' @param vignetteName A string giving the name of the \code{.Rmd} vignette file wrapping the documentation, as well as the name to retrieve the documentation using \code{vignette()}.  Default: \code{"doxygenVignette.Rmd"}
#' @param overwrite A boolean for whether to overwrite the file \code{rootFolder/vignettes/vignetteName.Rmd} if found.  Otherwise returns an error.  Default: \code{FALSE}
#'
#' @return \code{NULL}
#'
#' @details This function creates the file \code{vignettes/vignetteName.Rmd} in the package root folder, containing the necessary meta-data for viewing the Doxygen HTML documentation from within R with a call to \code{vignette()}.  When the vignette is built (e.g., with \code{R CMD build} or \code{devtools::build_vignettes()}), a file \code{inst/doc/vignetteName.html} is created, and it is this file which is opened by the call to \code{vignette("vignetteName")} after the package is installed.  The contents of \code{inst/doc/vignetteName.html} are simply a "redirect" to the Doxygen index file, \code{pathToIndex/index.html}.
#'
#' @note The call to \code{vignette()} will *only* open HTML files stored in the \code{doc} subfolder of an installed package.  Therefore the Doxygen documentation referred to by \code{pathToIndex} must be stored in a subfolder of \code{inst/doc} for the call to \code{vignette()} post-installation to work.
#'
#' @export
doxy_vignette <- function(rootFolder = ".",
                          pathToIndex = "doxygen/html",
                          vignetteName = "doxygenVignette.Rmd",
                          overwrite = FALSE) {
  # move to root directory
  initFolder <- getwd()
  on.exit(setwd(initFolder)) # resets to this even after error
  rootFolder <- normalizePath(rootFolder, winslash="/")
  setwd(rootFolder)
  if(length(grep("DESCRIPTION", dir())) == 0) {
    stop("rootFolder is not the root directory of a package.")
  }


  # path of doxygen index file relative to inst/doc
  indexFile <- file.path("..", pathToIndex, "index.html")

  # vignette name and file name
  if(tolower(tools::file_ext(vignetteName)) != "rmd") {
    vignetteName <- paste0(vignetteName, ".Rmd")
  }
  ## if(tools::file_ext(vignetteName) == "Rmd") {
  ##   vignetteFile <- vignetteName
  ##   vignetteName <- tools::file_path_sans_ext(vignetteFile)
  ## } else {
  ##   vignetteFile <- paste0(vignetteName, ".Rmd")
  ## }

  # check if file vignetteName already exists
  vignetteName <- file.path("vignettes", vignetteName)
  suppressWarnings({
    pass <- file.copy(from = system.file("sys", "doxygenVignette.Rmd",
                                         package = "rdoxygen"),
                      to = file.path(rootFolder, vignetteName),
                      overwrite = overwrite, recursive = TRUE)
  }
  )
  if(!pass) {
    stop("Vignette file '", file.path("vignettes", basename(vignetteName)),
         "' already exists.  Not overwritten.")
  }

  # modify template vignette to link to Doxygen doc
  vignetteLines <- readLines(vignetteName)
  vignetteLines <- gsub(pattern = "@doxy::Redirect@",
                        replacement = indexFile,
                        x = vignetteLines)
  cat(vignetteLines, sep = "\n", file = vignetteName)

  invisible(NULL)
}
