#--- setup ---------------------------------------------------------------------

context("Tests of doxy, doxy_init and doxy_edit functions")

source("rdoxygen-test_functions.R")

# create a dummy package in a temporary directory
pkgName <- "doxyTest"
destPath <- tempfile(pattern = "rdoxygen_")
pkgRoot <- file.path(destPath, pkgName)
dir.create(destPath, recursive = TRUE)
# makes sure this gets deleted at the end of the test
teardown(unlink(destPath, recursive = TRUE))
package.skeleton(name = pkgName,
                 path = destPath,
                 ## code_files = system.file("sys", "foo.R", package = "rdoxygen"))
                 code_files = "foo.R")
# add source code to run doxygen on
srcPath <- file.path(pkgRoot, "src")
dir.create(srcPath, recursive = TRUE)
file.copy(from = "foo.cpp",
          ## from = system.file("sys", "foo.cpp", package = "rdoxygen"),
          to = file.path(srcPath, "foo.cpp"))
# path to doxygen
doxyPath <- file.path(pkgRoot, "inst", "doxygen")

#--- tests ---------------------------------------------------------------------

# doxy_init: setup
test_that("after the run of doxy_init() there's a doxyfile in inst/doxygen", {
  skip_on_cran()
  doxy_init(file.path(pkgRoot, "man"), verbose = FALSE)
  expect_true(file.exists(file.path(doxyPath, "Doxyfile")))
})

# doxy: create doxygen documentation
test_that("after the run of doxy() there's a html documentation in inst/doxygen/html", {
  skip_on_cran()
  doxy(file.path(pkgRoot, "inst"), verbose = FALSE)
  expect_true(file.exists(file.path(doxyPath, "html", "index.html")))
})

# doxy_edit: edit doxyfile
test_that("doxy_edit edits the Doxyfile successfully", {
  skip_on_cran()
  start <- check_doxyfile(doxyPath)
  doxy_edit(pkg = pkgRoot,
            options = c("HTML_COLORSTYLE_HUE" = "120"))
  stop <- check_doxyfile(doxyPath)
  expect_false(start)
  expect_true(stop)
})

# run doxygen again
test_that("running doxy() again incorporates the changes of doxy_edit()", {
  skip_on_cran()
  start2 <- check_css(doxyPath)
  doxy(pkgRoot, verbose = FALSE)
  stop2 <- check_css(doxyPath)
  expect_false(start2)
  expect_true(stop2)
})
