# internal utilities

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

