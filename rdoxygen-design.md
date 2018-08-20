# Doxygen Documentation of C++ Libraries in R

## Design Considerations

- *Features.*  

    * **rdoxygen** allows R package developers to add [Doxygen](http://www.stack.nl/~dimitri/doxygen/index.html) documentation to their package for C++ source code (typically found in `src` or `inst/include`).  
    
    * Optionally (*should it be optional?*), this documentation can be accessed by users of the package via R [vignettes](http://r-pkgs.had.co.nz/vignettes.html).
    
    * Should the package allow more than one Doxygen documentation per package?  It seems like the need for this is rather unlikely.  If it is decied that **rdoxygen** does not support this feature, then its interface could be somewhat simplified (see below).
    
- *Simplicity.*  A typical **rdoxygen** workflow -- heavily influenced by the design of [**devtools**](https://github.com/r-lib/devtools) -- might proceed as follows.  Assuming that the package's C++ code has been marked up for Doxygen processing, and the R working directory is *any subfolder* of the package root:

    ```r
    # create default Doxyfile, process it with Doxygen, optionally (or not?) wrap in R vignette
    doxy(vignette = TRUE)
    
    # separate steps above
    doxy_init() # create default Doxyfile
    doxy(vignette = FALSE) # process
    doxy_vignette() # wrap in R vignette
    
    # non-default Doxyfile
    doxy(options = c(AUTOLINK_SUPPORT = "NO")) # create + process
    # can also edit an existing Doxyfile
    doxy_edit(options = c(AUTOLINK_SUPPORT = "NO"))
    ```

- *Stability.*  The output of **rdoxygen** should function as expected with minimal additional intervention from the user.  For example.  If using option `vignette = TRUE`, the package should get automatically configured to process [**rmarkdown**](https://rmarkdown.rstudio.com/) vignettes.

- *Dependencies.*  

    * Some useful packages for achieving the above could be:

        * [**rprojroot**](https://cran.r-project.org/web/packages/rprojroot/index.html), which allows you to find the root of a package directory from any of its subfolders.
        * [**desc**](https://cran.r-project.org/web/packages/desc/index.html), which allows you to easily edit the package `DESCRIPTION` file (e.g., for adding libraries required to process package vignettes).
    
    * On the other hand, I suggest not to `Import` the **devtools** package itself.  The reason is that **devtools** depends on [**curl**](https://github.com/jeroen/curl), which requires root access to [install](https://github.com/jeroen/curl#installation) on Linux (and in my experience, occasionally on other systems as well).  Thus, users without `sudo` access (e.g., server) wouldn't be able to install **devtools** nor any of its hard dependencies (`Imports` or `Depends`).
    
    * Since **rdoxygen** is used for package development, it should try as much as possible to avoid adding unnecessary dependencies to the user's package (i.e., if I want to use **rdoxygen** to add Doxygen documentation to my package, ideally that shouldn't force my package users to install **rdoxygen** itself -- I'll expand on this momentarily).


## Arguments to Exported Functions

Note that if **rdoxygen** does not support multiple Doxygen docs, then the `doxyfile` argument below can be omitted.  Similarly, the `vignette` argument to `doxy` can be omitted if Doxygen vignettes are always created.

```r
# edit Doxyfile tags
doxy_edit <- function(pkg = ".", # same as devtools::{document/load_all/install} argument, i.e., any subfolder of package root
                      doxyfile = "inst/doc/doxygen/Doxyfile", # path to doxyfile relative to package root
                      options # named vector of key-value pairs to edit Doxyfile tags
                      )

# add Doxyfile in package
doxy_init <- function(pkg = ".", # any subfolder of package root
                      doxyfile = "inst/doc/doxygen/Doxyfile", # path to doxyfile relative to package root
                      options # passed to doxy_edit
                      )

# wrap Doxygen documentation in R vignette
doxy_vignette <- function(pkg = ".", # any subfolder of package root
                          doxyfile = "inst/doc/doxygen/Doxyfile", # path to doxyfile relative to package root
                          vignetteName = "DoxygenVignette.Rmd", # name of Doxygen vignette
                          indexEntry # name of vignette Index Entry.  defaults to "C++ library documentation for package PackageName"
                          )

# do all steps above simultaneously
doxy <- function(pkg = ".", # any subfolder of package root
                 doxyfile = "inst/doc/doxygen/Doxyfile", # path to doxyfile relative to package root
                 options, # passed to doxy_edit
                 vignette = TRUE # add vignette
                 vignetteName = "DoxygenVignette.Rmd", # passed to doxy_vignette
                 indexEntry # passed to doxy_vignette
                 )
```

## Default File Locations

* *Doxygen documentation.*  Installed R vignettes can only display HTML files stored in a subfolder of `inst/doc` (as documented [here](https://github.com/nevrome/rdoxygen/issues/2#issuecomment-412536748)).  Therefore, the suggested location for Doxygen documentation is `inst/doc/doxygen`.

* *Doxyfile.*  As a package developer, I feel like whatever is required to create the package exactly as it should be installed on disk should be part of the package itself.  In this sense, the `Doxyfile` needed to format the Doxygen documentation exactly as I want it should be part of the package as well.  

    An obvious location for this file is `inst/doc/doxygen`.  However, `inst/doc` is typically `.gitignore`d (e.g., by `devtools::use_vignette()` and `usethis::use_vignettes()`).  So we'd have to manually exclude `inst/doc/doxygen/Doxyfile`, via appending an existing `.gitignore` with something like [this](https://stackoverflow.com/questions/5533050/gitignore-exclude-folder-but-include-specific-subfolder):
    
    ```
    # paste the following to the bottom of existing .gitignore
    
    !inst/doc # unignores inst/doc
    inst/doc/* # ignore everything inside inst/doc but not inst/doc itself
    !inst/doc/doxygen/Doxyfile # unignore Doxyfile
    ```
    
    Another option is to have `Doxyfile` live in `vignettes`.  If creating Doxgygen vignettes is always enabled (i.e., not optional), then this folder already exists, so easier to put `Doxyfile` here than to edit the `.gitignore` as above.  However, if the folder doesn't exist, then perhaps it's confusing to create the folder just to store the `Doxyfile`.
    
    Yet another option is to ship a list of key-value pairs for Doxygen tags instead of the `Doxyfile` itself, e.g., something like
    
    ```r
    # put this in any file in R/ subfolder
    .doxy_opts <- c(AUTOLINK_SUPPORT = "NO")
    ```
    
    As a package developer, this seems like an easier way to view package-dependent options (rather than scrolling through the `Doxyfile`).  However, the **rdoxygen** package is then needed to parse these options, and I would rather a package I'm authoring which provides Doxygen documentation not require all users to install **rdoxygen** as well.  Perhaps the `.R` file containing the lines above could be `.Rbuildignore`d but not `.gitignore`d?
   
## Default Doxyfile Tags

First, it should be noted that the `INPUT` tag cannot handle relative directories outside of where it's run, i.e.:

```bash
# in Doxyfile
INPUT = src/ # works fine
INPUT = ../src/ # does not work
```

Thus, **rdoxygen** should run Doxygen *from the package root folder*.  That being said, here are the default Tags I'm suggesting:

```bash
INPUT = src/ inst/include/ # the two locations in which you expect to find C++ code
OUTPUT_DIRECTORY = inst/doc/doxygen
PROJECT_NAME = "C++ Library Documentation for Package PackageName"
GENERATE_LATEX = NO # probably not needed in most cases?
```

Note that I did not suggest `EXTRACT_ALL = YES`, because I wonder whether inexperienced Doxygen users might think they need to document every single function for their Doxygen output to work properly...

Also note that another useful option might be `USE_MATHJAX = YES`, which makes formulas look much nicer than when this option is set to `NO`...
