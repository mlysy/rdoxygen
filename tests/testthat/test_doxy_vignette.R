#--- setup ---------------------------------------------------------------------

context("Tests of doxy_vignette")

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
                 code_files = "foo.R")
# delete help files
unlink(file.path(pkgRoot, "man"), recursive = TRUE, force = TRUE)
## # add source code to run doxygen on
## srcPath <- file.path(pkgRoot, "src")
## dir.create(srcPath, recursive = TRUE)
## file.copy(from = "foo.cpp",
##           to = file.path(srcPath, "foo.cpp"))
# add fake index.html
doxyPath <- file.path(pkgRoot, "inst", "doxygen") # path to doxygen
# arbitrary path to index file.  must be a subfolder of inst/doxygen
indexPath <- list("",
                  tempfile("folder_", tmpdir = ""),
                  tempfile("folder_", tmpdir = ""))
indexPath <- norm_path(do.call(file.path, indexPath))
dir.create(file.path(doxyPath, indexPath), recursive = TRUE)
file.copy(from = "index.html",
          to = file.path(doxyPath, indexPath, "index.html"))

#--- tests ---------------------------------------------------------------------

doxyName <- tempfile("Doxygen_", tmpdir = "", fileext = ".Rmd")
doxyName <- gsub("/", "", doxyName)
doxyEntry <- tempfile("IndexEntry_", tmpdir = "")
doxyEntry <- gsub("/", "", doxyEntry)

test_that("doxy_vignette creates Rmd and Makefile", {
  doxy_vignette(pkg = pkgRoot, index = indexPath,
                viname = doxyName, vientry = doxyEntry)
  expect_true(file.exists(file.path(pkgRoot, "vignettes",
                                    doxyName)))
  expect_true(file.exists(file.path(pkgRoot, "vignettes", "Makefile")))
})

test_that("existing Rmd file does not get overwritten", {
  # throws error
  cat('---',
      'title: "dummy vignette"',
      'params:',
      '  doxygenVignette: false',
      '---', sep = "\n", file = file.path(pkgRoot, "vignettes", doxyName))
  expect_error(doxy_vignette(pkg = pkgRoot, index = indexPath,
                             viname = doxyName, vientry = doxyEntry))
  # throws error
  cat('---',
      'title: "dummy vignette"',
      'params:',
      '  whales: 100',
      '---', sep = "\n", file = file.path(pkgRoot, "vignettes", doxyName))
  expect_error(doxy_vignette(pkg = pkgRoot, index = indexPath,
                             viname = doxyName, vientry = doxyEntry))
  # no error
  cat('---',
      'title: "dummy vignette"',
      'params:',
      '  doxygenVignette: true',
      '---', sep = "\n", file = file.path(pkgRoot, "vignettes", doxyName))
  expect_error(doxy_vignette(pkg = pkgRoot, index = indexPath,
                viname = doxyName, vientry = doxyEntry), NA)
})

test_that("existing Makefile does not get overwritten", {
  makeFile <- file.path(pkgRoot, "vignettes", "Makefile")
  # gives message
  cat('bad Makefile',
      sep = "\n", file = makeFile)
  expect_message(doxy_vignette(pkg = pkgRoot, index = indexPath,
                               viname = doxyName, vientry = doxyEntry))
  expect_equal("bad Makefile", readLines(makeFile))
  # does not give message
  file.remove(file = makeFile)
  expect_message(doxy_vignette(pkg = pkgRoot, index = indexPath,
                               viname = doxyName, vientry = doxyEntry), NA)
})

test_that("vignette has correct path in html redirect", {
  redirLine <- norm_path(file.path("doxygen", indexPath, "index.html"))
  redirLine <- paste0('<meta http-equiv="refresh" content="0; URL=',
                      redirLine, '">')
  expect_true(redirLine %in%
              readLines(file.path(pkgRoot, "vignettes", doxyName)))
})

test_that("vignette has correct index entry", {
  expect_true(paste0("  %\\VignetteIndexEntry{", doxyEntry, "}") %in%
              readLines(file.path(pkgRoot, "vignettes", doxyName)))
})

test_that("Makefile puts doxydoc into inst/doc", {
  tarFile <- file.path(destPath, paste0(pkgName, "_1.0.tar.gz"))
  indexFile <- file.path(pkgName, "inst", "doc", "doxygen",
                         indexPath, "index.html")
  indexFile <- norm_path(indexFile)
  pkgbuild::build(path = pkgRoot)
  expect_true(indexFile %in% norm_path(untar(tarfile = tarFile, list = TRUE)))
  file.remove(tarFile)
})


