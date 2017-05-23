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
#' Makes a configuration file in inst/doxygen/ and sets a few options:
#'     \itemize{
#'        \item{EXTRACT_ALL = YES}
#'        \item{INPUT = src/}
#'        \item{OUTPUT_DIRECTORY = inst/doxygen/}
#'     }
#' 
#' @param rootFolder A string with the path to the root directory of the R
#'                   package. Default: "."
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
doxy_init <- function (rootFolder = ".") {
  
  if(!check_for_doxygen()){
    stop("doxygen is not in the system path! Is it correctly installed?")
  }
  
  doxyFileName <- "Doxyfile"
  
  # move to root directory
  initFolder <- getwd()
  if (rootFolder != ".") {
    setwd(rootFolder)
  }
  
  # check if DESCRIPTION file is present
  rootFileYes <- length(grep("DESCRIPTION", dir())) > 0
  
  # prepare the doxygen folder
  doxDir <- "inst/doxygen"
  if (!file.exists(doxDir)) {
    dir.create(doxDir, recursive = TRUE)
  }
  setwd(doxDir)
  
  # prepare the doxygen configuration file with the initial settings
  system(paste0("doxygen -g ", doxyFileName))
  doxyfile <- readLines("Doxyfile")
  doxyfile <- replace_tag(doxyfile, "EXTRACT_ALL",      "YES")
  doxyfile <- replace_tag(doxyfile, "INPUT",            "src/")
  doxyfile <- replace_tag(doxyfile, "OUTPUT_DIRECTORY", "inst/doxygen/")
  cat(doxyfile, file = doxyFileName, sep = "\n")
  setwd(initFolder)
  
  return(NULL)
}

#' Edits an existing Doxyfile
#' 
#' Changes options in doxygen config files.  
#' 
#' @param pathToDoxyfile A string with the relative path to the Doxyfile.
#'                       Default: "./inst/doxygen/Doxyfile"
#' @param options A named vector with new settings. The names represent
#'                the tags
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
  pathToDoxyfile = "./inst/doxygen/Doxyfile",
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
#'                       Default: "./inst/doxygen/Doxyfile"
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
  pathToDoxyfile = "./inst/doxygen/Doxyfile"
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
    devtools::document()
  }
  
}

#' check for doxygen
#'
#' helper function to check if doxygen is in the system path
#' 
#' @return TRUE
#'
check_for_doxygen <- function(){
  return(nchar(Sys.which("doxygen")) > 0)
}