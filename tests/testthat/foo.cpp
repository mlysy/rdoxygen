/// @file foo.cpp

/// Add the squares of integers from 1 to `n`.
///
/// @param [in] n Number of integers to square and add.
/// @return The value of \f$\sum_{i=1}^n i^2\f$.
int add_squares(int n) {
  int ans = 0;
  for (int i = 0; i < n; i++) ans += i*i;
  return ans;
}
