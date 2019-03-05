# Doxygen Vignettes with devtools Constraints

## Problem

In order to access the doxygen documentation (doxydoc) from within an R vignette, the documentation *must* be located in a subfolder of `inst/doc`.  However, devtools (or more specifically its component package pkgbuild) deletes `inst/doc` as part of the package build process.  The purpose of this is to empty `inst/doc` of stale vignettes, before re-creating the folder from the contents of `vignettes`.  

The solution proposed by pkgbuild is to put the doxydoc into e.g., `vignettes/doxygen`, then copy this folder to `inst/doc` at build time via `.install_extras`.  However, this duplicates the doxydoc in the package tarball, which wastes a non-negligible amount of space and is thus contrary to CRAN policy.

## Solution

Here are some of the other things we tried but which failed:

- Make the doxydoc incompatible with devtools.  Since devtools is now so fundamental to package development, this is just passing on the headache to package developers, who are not likely to use doxygen if it's incompatible with their workflow.

- Use `vignettes/Makefile` to move `vignettes/doxygen` to `inst/doc/doxygen`.  However, the `Makefile`

While the resulting tarball can be installed directly, it can no longer interact with devtools/pkgbuild/etc without deleting the doxygen documentation.

- Put documentation in `demo`.  As per the R error message, vignettes can only open HTML files from (installed) `doc` or `demo` folders.  While `doc` allows access from within its subfolders, `demo` does not, so `doxygen/html/index.html` would have to be directly in `demo`.  This seems kind of dirty, especially if the user has their own demo files.

- Use doxygen to create latex documentation.  Considerably uglier and more cumbersome than HTML.  It is a bit smaller though...


The final solution was to use a `configure[.win]` script to move the doxydoc to `inst/doc` at *install time*:
```bash
# contents of configure
#! /bin/sh

# install doxygen
mkdir -p ./inst/doc/doxygen
cp -a ./inst/doxygen ./inst/doc
```
The main issue with this workaround is that package developers with their own `configure` file will need to append these commands by hand.  Another issue is that the doxydoc vignette will not be accessible from the source folder, as the vignette HTML placed in `inst/doc` (or `doc` if using devtools/etc) will not redirect to the correct location.

## File Locations

Let's keep things simple and use the following default locations:

- Doxydoc in source code goes in 
