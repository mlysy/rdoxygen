# check doxyfile
check_doxyfile <- function(doxyPath){
  doxyfile <- readLines(file.path(doxyPath, "Doxyfile"))
  doxyfile <- sapply(
    doxyfile,
    function(x){gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", x, perl=TRUE)}
  )
  res <- length(grep("HTML_COLORSTYLE_HUE = 120", doxyfile)) >= 1
  return(res)
}

# check css
check_css <- function(doxyPath){
  css <- readLines(file.path(doxyPath, "html", "doxygen.css"))
  css <- sapply(
    css,
    function(x){gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", x, perl=TRUE)}
  )
  res <- length(grep("color: #357B35;", css)) >= 1
  return(res)
}

# normalize path
norm_path <- function(path) {
  path <- normalizePath(path, winslash = "/", mustWork = FALSE)
  gsub("/+", "/", path)
}
