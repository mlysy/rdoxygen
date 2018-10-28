# internal utilities

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

# returns the absolute path to the package root folder
find_root <- function(pkgFolder = ".") {
  rprojroot::find_root(criterion = rprojroot::has_file("DESCRIPTION"),
                       path = pkgFolder)
}

# safely creates a folder, i.e., doesn't overwrite anything
# copied from devtools:::use_directory
dir_create <- function(dirName) {
  if(file.exists(dirName)) {
    if(!file.info(dirName)$isdir) {
      stop("'",
           dirName,
           "' exists but is not a directory.  File not overwritten.",
           call. = FALSE)
    }
  } else {
    dir.create(dirName, showWarnings = FALSE, recursive = TRUE)
  }
  invisible(NULL)
}

# get name of package from its root folder
pkg_name <- function(rootFolder) {
  desc::desc_get_field("Package",
                       file = file.path(rootFolder, "DESCRIPTION"))
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

# get path of one file relative to another
# note: doesn't work if either inputs are folders, not files
# as files needn't have extensions, can't distinguish the two by
# name only, i.e., should use normalizePath(mustWork = TRUE, ...)
rel_path <- function(relFile, baseFile) {
  # split files by directory
  rpaths <- normalizePath(relFile, winslash = "/",
                          mustWork = FALSE)
  rpaths <- strsplit(rpaths, "/")[[1]]
  bpaths <- normalizePath(baseFile, winslash = "/",
                          mustWork = FALSE)
  bpaths <- strsplit(bpaths, "/")[[1]]
  # find common root
  rlen <- length(rpaths)
  blen <- length(bpaths)
  nmin <- min(rlen, blen)
  nroot <- which.min(rpaths[1:nmin] == bpaths[1:nmin])
  # construct relative path
  do.call(file.path,
          c(as.list(rep("..", blen-nroot)), as.list(rpaths[nroot:rlen])))
}

# adds vignette to vignettes folder
# throws and error if an existing vignette has the given name
# and wasn't created by rdoxygen,
add_vignette <- function(vignetteFile) {
  vignetteName <- basename(vignetteFile)
  vignetteTemplate <- system.file("sys", "doxygenVignette.Rmd",
                                  package = "rdoxygen")
  # check if vignette exists
  has_vignette <- file.exists(vignetteFile)
  if(has_vignette) {
    # if it exists, check if it was created with rdoxygen
    yamlDoxygen <- read_yaml(vignetteFile)
    yamlDoxygen <- vignetteYaml$params$doxygenVignette
    has_vignette <- is.null(yamlDoxygen) ||
      (is.logical(yamlDoxygen) && !yamlDoxygen)
  }
  if(has_vignette) {
    stop("Existing vignette '", basename(vignetteFile),
         "' not created by rdoxygen.  Not overwritten.")
  } else {
    file.copy(from = system.file("sys", "doxygenVignette.Rmd",
                                 package = "rdoxygen"),
              to = vignetteFile, overwrite = TRUE)
  }
  invisible(NULL)
}
