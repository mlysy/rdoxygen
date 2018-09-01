#' Updates and adds doxygen options in a line string vector
#'
#' Scans the lines and changes the value for the named tag if one line has
#' this tag, adds a line at the end if no line has this tag and returns a
#' warning if several lines match the tag.
#'
#' @param fileStrings A vector with each string containing a line of the
#'                    file
#' @param tag  A string with the tag to be searched for
#' @param newVal A string with the new value for the tag
#'
#' @return The vector of strings with the new value
#' @keywords internal
#'
replace_tag <- function (fileStrings, tag, newVal) {

  # get and count lines with the tag
  iLine  <- grep(paste0("^", tag, "\\>"), fileStrings)
  nLines <- length(iLine)

  if (nLines == 0){
    # if tag is not present, add it with its value at the bottom
    line <- paste0(tag, "\t= ", newVal)
    iLine <- length(fileStrings) + 1
  } else if (nLines > 0){
    # if tag is present once, replace its value
    line <- gsub("=.*", paste0("= ", newVal), fileStrings[iLine])
    if(nLines > 1){
      # if tag is present multiple times, do nothing and throw warning
      warning(paste0(
        "File has", nLines,
        "for key", tag, ". ",
        "Check it up manually."
      ))
    }
  }
  fileStrings[iLine] <- line

  return(fileStrings)
}

#' Prepares the R package structure for use with doxygen
#'
#' Creates a Doxygen configuration file and sets a few options:
#'     \itemize{
#'        \item{EXTRACT_ALL = YES}
#'        \item{INPUT = src/}
#'        \item{OUTPUT_DIRECTORY = inst/doc/doxygen/}
#'     }
#'
#' @template param-pkgFolder
#' @template param-pathToDoxyfile
#'
#' @return NULL
#'
#' @examples
#'
#' \dontrun{
#' doxy_init()
#' }
#'
#' @export
doxy_init <- function (pkgFolder = ".",
                       pathToDoxyfile = "inst/doc/doxygen/Doxyfile") {

  if(!check_for_doxygen()){
    stop("doxygen is not in the system path! Is it correctly installed?")
  }


  doxyFileName <- "Doxyfile"

  # move to root directory
  initFolder <- getwd()
  on.exit(setwd(initFolder)) # resets to this even after error
  rootFolder <- normalizePath(rootFolder, winslash="/")
  setwd(rootFolder)

  # check if DESCRIPTION file is present
  ## rootFileYes <- length(grep("DESCRIPTION", dir())) > 0
  if(length(grep("DESCRIPTION", dir())) == 0) {
    stop("rootFolder is not the root directory of a package.")
  }

  # prepare the doxygen folder
  if (!file.exists(doxyFolder)) {
    dir.create(doxyFolder, recursive = TRUE)
  }
  setwd(doxyFolder)

  # prepare the doxygen configuration file with the initial settings
  system(paste0("doxygen -g ", doxyFileName))
  doxyfile <- readLines("Doxyfile")
  doxyfile <- replace_tag(doxyfile, "EXTRACT_ALL",      "YES")
  doxyfile <- replace_tag(doxyfile, "INPUT",            "src/")
  doxyfile <- replace_tag(doxyfile, "OUTPUT_DIRECTORY", doxyFolder)
  cat(doxyfile, file = doxyFileName, sep = "\n")

  return(NULL)
}

#' Edits an existing Doxyfile
#'
#' Changes options in doxygen config files.
#'
#' @param pathToDoxyfile A string with the relative path to the Doxyfile.
#'                       Default: "./inst/doc/doxygen/Doxyfile"
#' @param options A named vector with new settings. The names represent
#'                the tags.
#'                A list of options can be found here:
#'                \url{https://www.stack.nl/~dimitri/doxygen/manual/config.html}
#'
#' @return NULL
#'
#' @examples
#'
#' \dontrun{
#' doxy_edit(options = c("EXTRACT_PRIVATE" = "YES"))
#' }
#'
#' @export
doxy_edit <- function (
  pathToDoxyfile = "./inst/doc/doxygen/Doxyfile",
  options = c()
  ) {

  doxyfile <- readLines(pathToDoxyfile)

  # loop to apply replace_tag() for every element of the vector
  if (length(options) != 0) {
    for (i in 1:length(options)) {
      doxyfile <- replace_tag(doxyfile, names(options)[i], options[i])
    }
  }
  cat(doxyfile, file = pathToDoxyfile, sep = "\n")

  return(NULL)
}

#' Calls doxygen for an R package
#'
#' Triggers doxygen documentation for the code in src/. Triggers also
#' the setup (with \code{doxy_init()}) at the first run.
#'
#' @param doxygen A boolean: should doxygen be ran on documents in src/?
#'                Default: TRUE if a src folder exist and FALSE if not
#' @param roxygen A boolean: should devtools::document() be ran after the
#'                creation of the doxygen documentation?
#'                Default: FALSE
#' @param pathToDoxyfile A string with the relative path to the Doxyfile.
#'                       Default: "./inst/doc/doxygen/Doxyfile"
#'
#' @return NULL or the value returned by devtools::document()
#'
#' @examples
#' \dontrun{
#'   doxy()
#' }
#'
#' @export
doxy <- function(
  doxygen = file.exists("src"),
  roxygen = FALSE,
  pathToDoxyfile = "./inst/doc/doxygen/Doxyfile"
  ) {

  if(!check_for_doxygen()){
    stop("doxygen is not in the system path! Is it correctly installed?")
  }

  # doxygen
  if (doxygen) {
    doxyFileName <- pathToDoxyfile
    if (!file.exists(doxyFileName)) {
      doxy_init()
    }
    system(paste("doxygen", doxyFileName))
  }

  # roxygen
  if (roxygen) {
    if (!requireNamespace("devtools",
                          versionCheck = list(op = ">=", version = "1.12.0"),
                          quietly = TRUE)) {
        stop("Package 'devtools' must be installed for option 'roxygen = TRUE' to work.",
         call. = FALSE)
    }
    devtools::document()
  }

}

#' check for doxygen
#'
#' helper function to check if doxygen is in the system path
#'
#' @return TRUE
#' @keywords internal
#'
check_for_doxygen <- function(){
  return(nchar(Sys.which("doxygen")) > 0)
}
