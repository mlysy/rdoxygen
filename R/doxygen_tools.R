#' Calls doxygen for an \R package
#'
#' Creates doxygen documentation and optionally wraps it as an \R vignette.
#'
#' @template param-pkg
#' @template param-doxyfile
#' @template param-options
#' @param vignette A boolean. Should a vignette be added with \code{doxy_vignette}? Default: \code{FALSE}.
#'
#' @return \code{NULL}
#'
#' @details This function will first create a \code{Doxyfile} with \code{\link{doxy_init}} if it doesn't yet exist.  Next, it runs \code{Doxygen} on the \code{Doxyfile}, and if \code{vignette = TRUE}, creates a vignette allowing the Doxygen documentation to be viewed from within \R with a call to \code{vignette()}.  The Doxygen vignette is created with default options.  To modify these options, see \code{\link{doxy_vignette}}.
#'
#' @export
doxy <- function(
  pkg = ".",
  doxyfile = "inst/doxygen/Doxyfile",
  options = c(),
  vignette = FALSE
) {

  if(!check_for_doxygen()){
    stop("doxygen is not in the system path! Is it correctly installed?")
  }

  # run all commands from root folder
  rootFolder <- find_root(pkg)
  initFolder <- getwd()
  on.exit(setwd(initFolder)) # resets to this even after error
  setwd(rootFolder)

  ## first_run <- FALSE
  # run doxy_init if Doxyfile doesn't exist
  if(file.exists(doxyfile)) {
    if(file.info(doxyfile)$isdir) {
      stop("'", doxyfile, "' is a directory. doxygen not run.")
    }
  } else {
    doxy_init(rootFolder, doxyfile)
    ## first_run <- TRUE
  }

  # run doxy_edit if there are options given
  if(length(options) > 0) {
    doxy_edit(
      pkg,
      doxyfile,
      options
    )
  }

  # run doxy_vignette if vignette = TRUE and vignette file does not yet exist
  if (vignette) {
    ## if (!file.exists(file.path("vignettes", name))) {
      doxy_vignette(pkg = pkg)
    ## }
  }

  # run doxygen on Doxyfile
  system2(command = "doxygen", args = doxyfile)

  ## if(first_run) {
  ##   message("\nYou may like to add some lines to your .gitignore file to track the Doxyfile with git:\n")
  ##   message("# unignores inst/doc")
  ##   message("!inst/doc")
  ##   message("# ignore everything inside inst/doc but not inst/doc itself")
  ##   message("inst/doc/*")
  ##   message("# unignore Doxyfile")
  ##   message("!inst/doc/doxygen/Doxyfile")
  ## }

  return(invisible(NULL))
}

#' Prepares the R package structure for use with doxygen
#'
#' Creates a Doxygen configuration file and sets a few options:
#'     \itemize{
#'        \item{\code{INPUT = src/ inst/include}}
#'        \item{\code{OUTPUT_DIRECTORY = inst/doxygen/}}
#'        \item{\code{GENERATE_LATEX = NO}}
#'        \item{\code{HIDE_UNDOC_MEMBERS = YES}}
#'        \item{\code{USE_MATHJAX = YES}}
#'        \item{\code{PROJECT_NAME = name_of_R_package}}
#'     }
#'
#' @template param-pkg
#' @template param-doxyfile
#'
#' @details While the package developer is free to change the \code{OUTPUT_DIRECTORY} to wherever they like, the default value above is suggested for compatibility with the \pkg{devtools} package authoring workflow.  See \code{\link{doxy_vignette}} for details.
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
  doxyfile = "inst/doxygen/Doxyfile"
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
  doxyfile_lines <- replace_tag(doxyfile_lines, "HIDE_UNDOC_MEMBERS", "YES")
  doxyfile_lines <- replace_tag(doxyfile_lines, "USE_MATHJAX", "YES")
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
#' @template param-options
#'
#' @return \code{NULL}
#'
#' @export
doxy_edit <- function (
  pkg = ".",
  doxyfile = "inst/doxygen/Doxyfile",
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
#' Creates an \R Markdown wrapper for the doxygen documentation, so that it can be viewed from within \R with a call to \code{vignette()}.
#'
#' @template param-pkg
#' @param index A string with the path relative to \code{inst/doxygen} of the doxygen \code{index.html} file. Default: \code{html} (see \strong{Note}).
#' @param viname A string giving the name of the \code{.Rmd} vignette file wrapping the documentation, as well as the name by which to retrieve the documentation using \code{vignette()}.  Default: \code{"pkgName-Doxygen.Rmd"}.
#' @param vientry A character string specifying the vignette Index Entry to use.  Default: "pkgName C++ library documentation".
#'
#' @return \code{NULL}
#'
#' @details This function creates the file \code{vignettes/viname.Rmd} in the package root folder, containing the necessary meta-data for viewing the Doxygen HTML documentation from within \R with a call to \code{vignette()}.
#'
#' @note The call to \code{vignette()} will *only* open HTML files stored in the \code{doc} subfolder of an installed package.  Therefore, a natural location for the doxygen documentation (doxydoc) is in \code{inst/doc/doxygen}.  However, the latest version of \pkg{devtools} incontrovertibly deletes \code{inst/doc} during the build/install process.  Due to the ubiquitous usage of \pkg{devtools} among \R package developers, the doxydoc is stored here in \code{inst/doxygen}, and during the build process, moved (or technically, copied and source added to \code{.Rbuildignore}) via a \code{vignettes/Makefile}.  Packages with their own such \code{Makefile} will not have it overwritten, and developers may view the default \code{Makefile} provided by \pkg{rdoxygen} with the call
#' \preformatted{
#' cat(readLines(system.file("sys", "Makefile",
#'                           package = "rdoxygen")), sep = "\n")
#' }
#'
#' @export
doxy_vignette <- function(pkg = ".",
                          index = "html",
                          viname, vientry) {
  # run all commands from root folder
  rootFolder <- find_root(pkg)
  initFolder <- getwd()
  on.exit(setwd(initFolder)) # resets to this even after error
  setwd(rootFolder)

  # set custom vignette elements

  # vignette name
  pkgName <- pkg_name(rootFolder)
  if(missing(viname)) viname <- paste0(pkgName, "-Doxygen.Rmd")
  if(tolower(tools::file_ext(viname)) != "rmd") {
    viname <- paste0(viname, ".Rmd")
  }
  # index entry
  if(missing(vientry)) {
    vientry <- paste0(pkgName, " C++ library documentation")
  }
  # relative path from inst/doxygen to index.html
  indexFile <- rel_path(baseFile = file.path(rootFolder, "inst", "doxygen",
                                             viname),
                        relFile = file.path(rootFolder, "inst", "doxygen",
                                            index, "index.html"))


  # create vignette folder if it doesn't exist
  ## dir_create(file.path(rootFolder, "vignettes"))
  silent_out(usethis::use_directory("vignettes", ignore = FALSE))

  # copy template doxyVignette to vignettes folder
  vignetteFile <- file.path(rootFolder, "vignettes", viname)
  add_vignette(vignetteFile)

  # modify vignette template
  vignetteLines <- readLines(vignetteFile)
  vignetteLines <- gsub(pattern = "@doxy::Redirect@",
                        replacement = indexFile,
                        x = vignetteLines)
  vignetteLines <- gsub(pattern = "@doxy::Index@",
                        replacement = vientry,
                        x = vignetteLines)
  cat(vignetteLines, sep = "\n", file = vignetteFile)


  # devtools compatibility
  add_Makefile() # add vignettes/Makefile
  # ignore vignette source in package tarball
  silent_out({
    usethis::use_build_ignore(file.path("vignettes", "Makefile"))
    usethis::use_build_ignore(file.path("inst", "doxygen"))
  })

  # create vignette dependencies
  silent_out({
    desc::desc_set_dep("knitr", "Suggests")
    desc::desc_set_dep("rmarkdown", "Suggests")
    desc::desc_set("VignetteBuilder", "knitr")
  })

  invisible(NULL)
}
