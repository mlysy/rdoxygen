[![Travis-CI Build Status](https://travis-ci.org/nevrome/rdoxygen.svg?branch=master)](https://travis-ci.org/nevrome/rdoxygen) [![Coverage Status](https://img.shields.io/codecov/c/github/nevrome/rdoxygen/master.svg)](https://codecov.io/github/nevrome/rdoxygen?branch=master)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/rdoxygen)](http://cran.r-project.org/package=rdoxygen)
[![license](https://img.shields.io/badge/license-GPL%202-B50B82.svg)](https://www.r-project.org/Licenses/GPL-2)

rdoxygen
--------

R package for the automatic creation of [doxygen](http://www.doxygen.org) documentation for source code in R packages. 

It's based on [cmbarbus](http://stackoverflow.com/users/1174052/cmbarbu) answer to this [stackoverflow question](http://stackoverflow.com/questions/20713521/using-roxygen2-and-doxygen-on-the-same-package). 


Installation
------------

rdoxygen is currently not on [CRAN](http://cran.r-project.org/), but you can use [devtools](http://cran.r-project.org/web/packages/devtools/index.html) to install the development version. To do so:

    if(!require('devtools')) install.packages('devtools')
    library(devtools)
    install_github('nevrome/rdoxygen')

:exclamation: You also need a working installation of the system programm [doxygen](http://www.stack.nl/~dimitri/doxygen/download.html). 

The package provides a [RStudio Addin](https://rstudio.github.io/rstudioaddins/) named **rdoxygenize** that binds to the function `doxy()`. `doxy()` can therefore be called with a keyboard shortcut (I personally use <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>-</kbd>). This makes the user exerience comparable to [roxygen2](https://github.com/yihui/roxygen2) documentation via `devtools::document()` (usually <kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>D</kbd>). 

Licence
-------

rdoxygen is released under the [GNU General Public Licence, version 2](http://www.r-project.org/Licenses/GPL-2). Comments and feedback are welcome, as are code contributions.