/// @file

/// @mainpage Example of doxygen documentation markup
///
/// @author Clemens Schmidt, Martin Lysy
///
/// List of <a href="annotated.html">classes</a> and <a href="globals_func.html">functions</a>.

#include <Rcpp.h>
using namespace Rcpp;

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

/// Calculate the range of a `Uniform` object.
///
/// For a uniform distribution \f$U \sim \mathrm{Uniform}(a, b)\f$, the range is defined as \f$r = b - a\f$.  
///
/// @param[in] w Pointer to a `Uniform` object.
/// @return Range of `w`.
double uniformRange( Uniform* w) {
  return w->max - w->min;
}

/// Euclidean norm of a 2d point.
///
/// For a 2d point \f$(x,y)\f$, returns \f$\sqrt{x^2 + y^2}\f$.  This function is primarily documented to show that `[[Rcpp::export]]` tags do not interfere with doxygen parsing, and vice-versa.
///
/// @param[in] x Scalar coordinate in first dimension.
/// @param[in] y Scalar coordinate in second dimension.
/// @return Scalar value of the Euclidean norm.
///
// [[Rcpp::export("norm2d")]]
double norm( double x, double y) {
  return sqrt(x*x + y*y);
}

// Rcpp Module wrapper code will not be parsed by doxygen
RCPP_MODULE(unif_module) {

  class_<Uniform>("Uniform")
      
  .constructor<double,double>()

  .field("min", &Uniform::min)
  .field("max", &Uniform::max)

  .method("draw", &Uniform::draw)
  .method("range", &uniformRange);
}
