[![Travis-CI Build Status](https://travis-ci.org/nevrome/rdoxygen.svg?branch=master)](https://travis-ci.org/nevrome/rdoxygen) [![Coverage Status](https://img.shields.io/codecov/c/github/nevrome/rdoxygen/master.svg)](https://codecov.io/github/nevrome/rdoxygen?branch=master)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/rdoxygen)](https://cran.r-project.org/package=rdoxygen)
[![license](https://img.shields.io/badge/license-GPL%202-B50B82.svg)](https://www.r-project.org/Licenses/GPL-2)

# rdoxygen: Create doxygen documentation for R package C++ code

*[Clemens Schmid](https://nevrome.de/), Martin Lysy*

---

### Description

Create [**doxygen**](http://www.doxygen.nl/) documentation for source C++ code in R packages, and optionally make it accessible as an R vignette.  Includes an [**RStudio** Addin](https://rstudio.github.io/rstudioaddins/) to easily trigger the doxygenize process.

### Installation

To use **rdoxygen** you need to first install doxygen, for which detailed instructions are provided [here](http://www.doxygen.nl/manual/install.html).  Next, install **rdoxygen** either from [CRAN](https://CRAN.R-project.org/package=rdoxygen), or obtain the latest development version from GitHub by first installing the R package [**devtools**](https://CRAN.R-project.org/package=devtools), then run
```r
devtools::install_github("mlysy/rdoxygen")
```

### Usage

The following is a C++ code snippet taken from [Rcpp Modules](https://CRAN.R-project.org/package=Rcpp/vignettes/Rcpp-modules.pdf), with added doxygen-style comments to be parsed into source code documentation.  For simplicity only a few doxygen features are illustrated here; the complete set is extensively documented on the [doxygen website](http://www.doxygen.nl/manual/index.html).

<a id="doxygen_example"></a>
```c
/// A class for uniform random number generation.
///
/// Provides an example of doxygen class documentation.
class Uniform {
public:
  /// Construct a uniform random number generator.
  Uniform(double min_, double max_) : min(min_), max(max_) {}

  /// Obtain iid draws from a uniform distribution.
  NumericVector draw(int n);

  double min; ///< Minimum value of the uniform.
  double max; ///< Maximum value of the uniform.
};

/// Creates an object to sample from \f$U \sim \mathrm{Uniform}(a, b)\f$.
///
/// @param[in] min_ The minimum value \f$a\f$ of the uniform.
/// @param[in] max_ The maximum value \f$b\f$ of the uniform.
Uniform::Uniform(double min_, double max_) : min(min_), max(max_) {}

/// Returns a sample \f$U_1,\ldots,U_n \stackrel{\mathrm{iid}}{\sim} \mathrm{Uniform}(a, b)\f$.
///
/// @param[in] n Number of iid draws to produce.
/// @return Vector of `n` draws from the uniform distribution.
NumericVector Uniform::draw(int n) {
  RNGScope scope;
  return runif( n, min, max );
}
```

#### Processing with **rdoxygen**

Suppose that the [code snippet](#doxygen_example) above is in a file called `rdoxygenExample.cpp`.  Then a typical doxygen documentation (doxydoc) processing workflow is as follows:

1.  Create a default `Doxyfile` containing a list of options to render the documentation in `rdoxygenExample.cpp`.
2.  Edit the `Doxyfile` to customize rendering options as desired.  The relevant settings are extensively documented on the [doxygen website](http://www.doxygen.nl/manual/config.html) and within the default `Doxyfile` itself.
3.  Run doxygen on the `Doxyfile` to create the doxydoc HTML.

The rdoxygen package provides several convenience files to do all of this from within an R session during the package development process.  That is, suppose `rdoxygenExample.cpp` is located in the `src` folder of the R package **DoxygenExample**.  From an R session with working directory anywhere within the folder structure of **DoxygenExample**, the package developer can parse the doxydoc with the following R code:
```r
require(rdoxygen)

# create doxydoc with default options, wrap it as an R vignette
doxy(vignette = TRUE)

# --- separate the steps above ---

# 1. Create just the Doxyfile for the package documentation.
#    In particular, this looks for any doxygen markup in
#    the src and inst/include subdirectories.
doxy_init()

# 2. Optionally, edit the package Doxyfile
doxy_edit(options = c(SHOW_INCLUDE_FILES = "NO"))

# 3. Create the doxygen HTML documentation
doxy(vignette = FALSE)

# 4. Wrap the HTML documentation into an R vignette
doxy_vignette()
```
The HTML output of these calls can be viewed [here](http://htmlpreview.github.io/?https://github.com/mlysy/rdoxygen/blob/master/inst/doxygen/html/index.html).

