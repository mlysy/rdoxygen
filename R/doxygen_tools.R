#' Replace a value for a given tag on file in memory
#' 
#' Scan the lines and change the value for the named tag if one line has 
#' this tag, add a line at the end if no line has this tag and return a 
#' warning if several lines matching the tag.
#' 
#' @param fileStrings A vector with each string containing a line of the 
#'                    file
#' @param tag The tag to be searched for
#' @param newVal The new value for the tag
#' 
#' @return The vector of strings with the new value
#' 
replace_tag <- function (fileStrings, tag, newVal) {
  iLine  <- grep(paste0("^", tag, "\\>"), fileStrings)
  nLines <- length(iLine)
  if (nLines == 0){
    line <- paste0(tag, "\t= ", newVal)
    iLine <- length(fileStrings) + 1
  } else if (nLines > 0){
    line <- gsub("=.*", paste0("= ", newVal), fileStrings[iLine])
    if(nLines > 1){
      warning(paste0(
        "File has", nLines, 
        "for key", tag, 
        "check it up manually"
      ))
    }
  }
  fileStrings[iLine] <- line
  return(fileStrings)
}

#' Prepares the R package structure for use with doxygen
#' 
#' Makes a configuration file in inst/doxygen and set a few options:
#'     \itemize{
#'        \item{EXTRACT_ALL = YES}
#'        \item{INPUT = src/}
#'        \item{OUTPUT_DIRECTORY = inst/doxygen/}
#'        \item{EXTRACT_PRIVATE = YES}
#'     }
#' 
#' @param rootFolder The root path of the R package
#' 
#' @return TRUE
#' 
#' @examples
#' 
#' \dontrun{
#' doxy_init()
#' }
#' 
#' @export
doxy_init <- function (rootFolder = ".") {
  doxyFileName <- "Doxyfile"
  initFolder <- getwd()
  if (rootFolder != ".") {
    setwd(rootFolder)
  }
  rootFileYes <- length(grep("DESCRIPTION", dir())) > 0
  # prepare the doxygen folder
  doxDir <- "inst/doxygen"
  if (!file.exists(doxDir)) {
    dir.create(doxDir, recursive = TRUE)
  }
  setwd(doxDir)
  
  # prepare the doxygen configuration file
  system(paste0("doxygen -g ", doxyFileName))
  doxyfile <- readLines("Doxyfile")
  doxyfile <- replace_tag(doxyfile, "EXTRACT_ALL",      "YES")
  doxyfile <- replace_tag(doxyfile, "INPUT",            "src/")
  doxyfile <- replace_tag(doxyfile, "OUTPUT_DIRECTORY", "inst/doxygen/")
  cat(doxyfile, file = doxyFileName, sep = "\n")
  setwd(initFolder)
  return(TRUE)
}

#' Edits an existing Doxyfile
#' 
#' Changes options in doxygen config files.  
#' 
#' @param pathToDoxyfile relative path to the Doxyfile
#'                       Default: "./inst/doxygen/Doxyfile"
#' @param options named vector with new settings. 
#'                A list of options can be found here:
#'                \url{https://www.stack.nl/~dimitri/doxygen/manual/config.html}    
#'    
#' @return TRUE
#' 
#' @examples
#' 
#' \dontrun{
#' doxy_edit(options = c("EXTRACT_PRIVATE" = "YES"))
#' }
#' 
#' @export
doxy_edit <- function (
  pathToDoxyfile = "./inst/doxygen/Doxyfile",
  options = c()
  ) {
  doxyfile <- readLines(pathToDoxyfile)
  for (i in 1:length(options)) {
    doxyfile <- replace_tag(doxyfile, names(options)[i], options[i])
  }
  cat(doxyfile, file = pathToDoxyfile, sep = "\n")
  return(TRUE)
}

#' Calls doxygen for an R package
#' 
#' Triggers doxygen documentation for the code in src/. Triggers also 
#' the setup (with \code{doxy_init()}) before the first run. 
#' 
#' @param doxygen A boolean: should doxygen be ran on documents in src?
#'                Default: TRUE if a src folder exist and FALSE if not
#' @param roxygen A boolean: should devtools::document() be ran after the 
#'                creation of the doxygen documentation?
#'                Default: FALSE
#' 
#' @return The value returned by devtools::document()
#' 
#' @examples
#' \dontrun{
#'   doxy()
#' }
#' 
#' @export
doxy <- function(doxygen = file.exists("src"), roxygen = FALSE) {
  if (doxygen) {
    doxyFileName <- "inst/doxygen/Doxyfile"
    if (!file.exists(doxyFileName)) {
      doxy_init()
    }
    system(paste("doxygen", doxyFileName))
  }
  if (roxygen) {
    devtools::document()
  }
}