# Doxygen Documentation of C++ Libraries in R

## Design Considerations

- *Features.* **rdoxygen** allows R package developers to add [Doxygen](http://www.stack.nl/~dimitri/doxygen/index.html) documentation to their package for C++ source code (typically found in `src` or `inst/include`). Optionally, this documentation can be accessed by users of the package via R [vignettes](http://r-pkgs.had.co.nz/vignettes.html).
    
- *Simplicity.* A typical **rdoxygen** workflow -- heavily influenced by the design of [**devtools**](https://github.com/r-lib/devtools) -- might proceed as follows. Assuming that the package's C/C++/etc. code has been marked up for Doxygen processing, and the R working directory is *any subfolder* of the package root:

    ```r
    # create default Doxyfile, process it with Doxygen, optionally wrap in R vignette
    doxy(vignette = TRUE)
    
    # separate steps above
    doxy_init() # create default Doxyfile
    doxy(vignette = FALSE) # process
    doxy_vignette() # wrap in R vignette
    
    # can also edit an existing Doxyfile
    doxy_edit(options = c(AUTOLINK_SUPPORT = "NO"))
    ```

- *Stability.* The output of **rdoxygen** should function as expected with minimal additional intervention from the user. If using option `vignette = TRUE`, the package should get automatically configured to process [**rmarkdown**](https://rmarkdown.rstudio.com/) vignettes.

- *Dependencies.* Since **rdoxygen** is used for package development, it tries as much as possible to avoid adding unnecessary dependencies to the user's package (i.e., if I want to use **rdoxygen** to add Doxygen documentation to my package, ideally that shouldn't force my package users to install **rdoxygen** itself). Nevertheless helpful packages for achieving the above are:

    * [**rprojroot**](https://CRAN.R-project.org/package=rprojroot), which allows you to find the root of a package directory from any of its subfolders.
    
    * [**desc**](https://CRAN.R-project.org/package=desc), which allows you to easily edit the package `DESCRIPTION` file (e.g., for adding libraries required to process package vignettes).
    
## Arguments to Exported Functions

```r
# do all steps below and trigger doxygen rendering
doxy <- function(
  pkg = ".", # same as devtools::{document/load_all/install} argument, i.e., any subfolder of package root
  doxyfile = "inst/doc/doxygen/Doxyfile", # path to doxyfile relative to package root
  options, # passed to doxy_edit
  vignette = FALSE # add vignette: if TRUE then doxy_vignette is triggered
  name = "DoxygenVignette.Rmd", # passed to doxy_vignette
  index # passed to doxy_vignette
)

# add Doxyfile in package if it does not exist
doxy_init <- function(
  pkg = ".",
  doxyfile = "inst/doc/doxygen/Doxyfile"
)

# edit Doxyfile tags if doxyfile exists
doxy_edit <- function(
  pkg = ".", 
  doxyfile = "inst/doc/doxygen/Doxyfile", 
  options # named vector of key-value pairs to edit Doxyfile tags
)

# wrap Doxygen documentation in R vignette
doxy_vignette <- function(
  pkg = ".",
  name = "DoxygenVignette.Rmd", # name of Doxygen vignette
  index # name of vignette Index Entry. defaults to "C++ library documentation for package PackageName"
  overwrite = FALSE # should an existing vignette file be overwritten
)
```

## Default File Locations

* *Doxygen documentation.* Installed R vignettes can only display HTML files stored in a subfolder of `inst/doc` (as documented [here](https://github.com/nevrome/rdoxygen/issues/2#issuecomment-412536748)). Therefore, the suggested location for Doxygen documentation is `inst/doc/doxygen`.

* *Doxyfile.* As a package developer, I feel like whatever is required to create the package exactly as it should be installed on disk should be part of the package itself. In this sense, the `Doxyfile` needed to format the Doxygen documentation exactly as I want it should be part of the package as well. An obvious location for this file is `inst/doc/doxygen`. However, `inst/doc` is typically `.gitignore`d (e.g., by `devtools::use_vignette()` and `usethis::use_vignettes()`). So we'd have to manually exclude `inst/doc/doxygen/Doxyfile`, via appending an existing `.gitignore` with something like [this](https://stackoverflow.com/questions/5533050/gitignore-exclude-folder-but-include-specific-subfolder):
    
    ```
    # paste the following to the bottom of existing .gitignore
    
    !inst/doc # unignores inst/doc
    inst/doc/* # ignore everything inside inst/doc but not inst/doc itself
    !inst/doc/doxygen/Doxyfile # unignore Doxyfile
    ```
   
## Default Doxyfile Tags

First, it should be noted that the `INPUT` tag cannot handle relative directories outside of where it's run, i.e.:

```bash
# in Doxyfile
INPUT = src/ # works fine
INPUT = ../src/ # does not work
```

Thus, **rdoxygen** runs Doxygen *from the package root folder*. That being said, here are the default tags rdoxygen sets in the Doxyfile:

```bash
INPUT = src/ inst/include/ # the two locations in which you expect to find C++ code
OUTPUT_DIRECTORY = inst/doc/doxygen
PROJECT_NAME = "C++ Library Documentation for Package PackageName"
```

Also note that another useful option might be `USE_MATHJAX = YES`, which makes formulas look much nicer than when this option is set to `NO`.
