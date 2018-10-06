#' Calls doxygen for an \R package
#'
#' Creates doxygen documentation based on the given \code{Doxyfile} configuration.  Creates this file with default values (using \code{doxy_init()}) if it doesn't exist.
#'
#' @template param-pkg
#' @template param-doxyfile
#'
#' @return \code{NULL}
#'
#' @examples
#' \dontrun{
#'   doxy()
#' }
#'
#' @export
doxy <- function(
  pkg = ".",
  doxyfile = "inst/doc/doxygen/Doxyfile"
) {
  
  if(!check_for_doxygen()){
    stop("doxygen is not in the system path! Is it correctly installed?")
  }
  
  # run all commands from root folder
  rootFolder <- find_root(pkg)
  initFolder <- getwd()
  on.exit(setwd(initFolder)) # resets to this even after error
  setwd(rootFolder)
  
  # run doxy_init if Doxyfile doesn't exist
  if(file.exists(doxyfile)) {
    if(file.info(doxyfile)$isdir) {
      stop("'", doxyfile, "' is a directory.  doxygen not run.")
    }
  } else {
    doxy_init(rootFolder, doxyfile)
  }
  
  # run doxygen on Doxyfile
  system2(command = "doxygen", args = doxyfile)
  
  return(invisible(NULL))
}

#' Prepares the R package structure for use with doxygen
#'
#' Creates a Doxygen configuration file and sets a few options:
#'     \itemize{
#'        \item{\code{INPUT = src/ inst/include}}
#'        \item{\code{OUTPUT_DIRECTORY = inst/doc/doxygen/}}
#'        \item{\code{GENERATE_LATEX = NO}}
#'        \item{\code{PROJECT_NAME = name_of_R_package}}
#'     }
#'
#' @template param-pkg
#' @template param-doxyfile
#'
#' @return \code{NULL}.
#'
#' @examples
#'
#' \dontrun{
#' doxy_init()
#' }
#'
#' @export
doxy_init <- function (
  pkg = ".",
  doxyfile = "inst/doc/doxygen/Doxyfile"
) {

  if(!check_for_doxygen()){
    stop("doxygen is not in the system path! Is it correctly installed?")
  }

  # move to root directory (error if root not found)
  rootFolder <- find_root(pkg)
  initFolder <- getwd()
  on.exit(setwd(initFolder)) # resets to this even after error
  setwd(rootFolder)

  # prepare the Doxygen folder
  doxyFolder <- dirname(doxyfile)
  dir_create(doxyFolder)

  # create the doxygen configuration file with the default settings
  system2(command = "doxygen", args = c("-g", doxyfile))

  doxyfile_lines <- readLines(doxyfile)
  doxyfile_lines <- replace_tag(doxyfile_lines, "INPUT", "src/ inst/include")
  doxyfile_lines <- replace_tag(doxyfile_lines, "OUTPUT_DIRECTORY", doxyFolder)
  doxyfile_lines <- replace_tag(doxyfile_lines, "GENERATE_LATEX", "NO")
  doxyfile_lines <- replace_tag(doxyfile_lines, "PROJECT_NAME", pkg_name(rootFolder))
  cat(doxyfile_lines, file = doxyfile, sep = "\n")

  return(invisible(NULL))
}

#' Edits an existing Doxyfile
#'
#' Changes options in doxygen config files.
#'
#' @template param-pkg
#' @template param-doxyfile
#' @param options A named vector with new settings. The names represent
#'                the tags.
#'                A list of options can be found here:
#'                \url{https://www.stack.nl/~dimitri/doxygen/manual/config.html}
#'
#' @return \code{NULL}
#'
#' @examples
#'
#' \dontrun{
#' doxy_edit(options = c("EXTRACT_PRIVATE" = "YES"))
#' }
#'
#' @export
doxy_edit <- function (
  pkg = ".",
  doxyfile = "inst/doc/doxygen/Doxyfile",
  options = c()
) {

  rootFolder <- find_root(pkg)
  doxyfile <- file.path(rootFolder, doxyfile)
  doxyfile_lines <- readLines(doxyfile)

  # loop to apply replace_tag() for every element of the vector
  if (length(options) != 0) {
    for (i in 1:length(options)) {
      doxyfile_lines <- replace_tag(doxyfile_lines, names(options)[i], options[i])
    }
  }
  cat(doxyfile_lines, file = doxyfile, sep = "\n")

  return(invisible(NULL))
}

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
