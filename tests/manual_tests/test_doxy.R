context("Tests of doxy, doxy_init and doxy_edit functions")

wd <- getwd()
setwd("../../")

# check doxyfile
check_doxyfile <- function(){
  doxyfile <- readLines("./inst/doxygen/Doxyfile")
  doxyfile <- sapply(
    doxyfile, 
    function(x){gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", x, perl=TRUE)}
  )
  res <- length(grep("HTML_COLORSTYLE_HUE = 120", doxyfile)) >= 1
  return(res)
}

# check css
check_css <- function(){
  css <- readLines("./inst/doxygen/html/doxygen.css")
  css <- sapply(
    css, 
    function(x){gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", x, perl=TRUE)}
  )
  res <- length(grep("color: #357B35;", css)) >= 1
  return(res)
}

# doxy_init: setup
doxy_init()

test_that("after the run of doxy_init() there's a doxyfile in inst/doxygen", {
  expect_true(file.exists("./inst/doxygen/Doxyfile"))
})

# doxy: create doxygen documentation
doxy()

test_that("after the run of doxy() there's a html documentation in inst/doxygen/html", {
  expect_true(file.exists("./inst/doxygen/html/index.html"))
})

# doxy_edit: edit doxyfile
start <- check_doxyfile()
doxy_edit(options = c("HTML_COLORSTYLE_HUE" = "120"))
stop <- check_doxyfile()

test_that("doxy_edit edits the Doxyfile successfully", {
  expect_false(start)
  expect_true(stop)
})

# run doxygen again
start2 <- check_css()
doxy()
stop2 <- check_css()

test_that("running doxy() again incorporates the changes of doxy_edit()", {
  expect_false(start2)
  expect_true(stop2)
})

setwd(wd)