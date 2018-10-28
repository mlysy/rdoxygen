#include "foo.h"

//' Example function: roxygen2 documentation
//' 
//' This is the roxygen documentation of an example function.
//' 
//' @param a A double 
//' @param b A double 
//' 
//' @return A double a + b
//' 
//' @export 
//' 
// [[Rcpp::export]]
double docu_test_function(double a, double b) {
  double c = a + b;
  return c;
}
