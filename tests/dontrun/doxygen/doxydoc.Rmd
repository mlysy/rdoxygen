---
title: "mniw documentation"
output: 
  rmarkdown::html_document:
    keep_md: true
    toc: true
    toc_depth: 3
---

# Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`namespace `[`mniw`](#namespacemniw) | 

# namespace `mniw` <a id="namespacemniw"></a>

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
[`triMultLL()`](_tri_utils_8h_1a5daadd239a4be77fe6470cfc9a560353)           | Multiplication of two lower triangular matrices
[`triMultXU()`](_tri_utils_8h_1ad9c65f39981a3e4e609e16ac929bb496)           | Right-multiplication by upper triangular matrix
[`triMultLX()`](_tri_utils_8h_1abc315a2e184858938a30ea0b796a65ea)           | Left-multiplication by a lower triangular matrix
[`triMultLiX()`](_tri_utils_8h_1a7f22604e6c692494f4772837f9b6e0c3)           | In-place solution of a lower triangular system
[`triMultXLi()`](_tri_utils_8h_1adfde552c3f71d142ee6ded89e49f9fb0)           | In-place solution of a reverse lower triangular system
[`triMultUiX()`](_tri_utils_8h_1aa62489bafdc65d2645b57e480ee2572e)           | In-place solution of an upper triangular system
[`crossProdUtU()`](_tri_utils_8h_1a79a58591ed0f4f3bd3c151d6d7f52266)           | Transpose-product of upper triangular matrices
[`CrossProdLLt()`](_tri_utils_8h_1a7ca9facdac5bff93d2db13420c3edf8e)           | Reverse transpose-product of lower triangular matrices
[`CrossProdLtL()`](_tri_utils_8h_1af6693aa50f28ec42c038f8f532741332)           | Transpose-product of lower triangular matrices
[`InverseLLt()`](_tri_utils_8h_1aee6a1777f73c71378680d77c59814479)           | Inverse of reverse transpose-product
[`ReverseCholesky()`](_tri_utils_8h_1a18fc2d655dc265f4c1133403a61034fb)           | Reverse-Cholesky decomposition of a positive-definite matrix
[`logDetCholV()`](_tri_utils_8h_1a3f6653dcf99e9386dde5bd02fbe099b9)           | Logarithm of the determinant of a Cholesky decomposition
[`logDetV()`](_tri_utils_8h_1ad13e348945b0a769632c1dd5c0c96ae2)           | Logarithm of the determinant of a positive-definite matrix
[`logMultiGamma()`](_wishart_8h_1a53aee90f94b4d2aa862f49332ceb68d7)           | Multivariate log-gamma function.
[`mniw::HierNormal()`](classmniw_1_1_hier_normal)| Gibbs sampler for posterior distribution of Hierarchical Normal model with unequal variances.
[`mniw::MatrixNormal()`](classmniw_1_1_matrix_normal)| The Matrix Normal distribution.
[`mniw::MatrixT()`](classmniw_1_1_matrix_t)| The Matrix-t distribution.
[`mniw::MultiNormal()`](classmniw_1_1_multi_normal)| The Multivariate Normal distribution.
[`mniw::RanfxNormal()`](classmniw_1_1_ranfx_normal)| The Multivariate Random-Effects Normal distribution.
[`mniw::Wishart()`](classmniw_1_1_wishart)| The Wishart and Inverse Wishart distributions.

## Members

#### `triMultLL()` <a id="_tri_utils_8h_1a5daadd239a4be77fe6470cfc9a560353"></a>

`public template<>`  <br/>`void `[`triMultLL`](#_tri_utils_8h_1a5daadd239a4be77fe6470cfc9a560353)`(const Eigen::MatrixBase< T1 > & X,const Ref< const MatrixXd > & L1,const Eigen::MatrixBase< T2 > & L2)`

Multiplication of two lower triangular matrices

Performs the matrix multiplication `X = L1 * L2`, where `L1` and `L2` are lower triangular matrices.

#### Parameters
* `L1` First `n x n` lower triangular matrix. 

* `L2` Second `n x n` lower triangular matrix. 

* `X` Matrix of size `n x n` containing the product of `L1` and `L2`.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `triMultXU()` <a id="_tri_utils_8h_1ad9c65f39981a3e4e609e16ac929bb496"></a>

`public template<>`  <br/>`void `[`triMultXU`](#_tri_utils_8h_1ad9c65f39981a3e4e609e16ac929bb496)`(Ref< MatrixXd > Y,const Ref< const MatrixXd > & X,const Eigen::MatrixBase< T1 > & U)`

Right-multiplication by upper triangular matrix

Performs the matrix multiplication `Y = X * U`, where `U` is an upper triangular matrix.

#### Parameters
* `X` Matrix of size `n x p` to be multiplied. 

* `U` Lower triangular matrix of size `n x n` right-multiplying `X`. 

* `Y` Matrix of size `n x p` containing the product of `X` and `U`.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `triMultLX()` <a id="_tri_utils_8h_1abc315a2e184858938a30ea0b796a65ea"></a>

`public template<>`  <br/>`void `[`triMultLX`](#_tri_utils_8h_1abc315a2e184858938a30ea0b796a65ea)`(Ref< MatrixXd > Y,const Eigen::MatrixBase< T1 > & L,const Ref< const MatrixXd > & X)`

Left-multiplication by a lower triangular matrix

Performs the matrix multiplication `Y = L * X`, where `L` is a lower triangular matrix.

#### Parameters
* `X` Matrix of size `n x p` to be multiplied. 

* `L` Lower triangular matrix of size `n x n` left-multiplying `X`. 

* `Y` Matrix of size `n x p` containing the product of `L` and `X`.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `triMultLiX()` <a id="_tri_utils_8h_1a7f22604e6c692494f4772837f9b6e0c3"></a>

`public template<>`  <br/>`void `[`triMultLiX`](#_tri_utils_8h_1a7f22604e6c692494f4772837f9b6e0c3)`(Ref< MatrixXd > X,const Eigen::MatrixBase< T1 > & L)`

In-place solution of a lower triangular system

Performs the matrix multiplication `X = L^{-1} * X`, where `L` is a lower triangular matrix.

#### Parameters
* `X` Matrix of size `n x p` on RHS of linear system. This is also where solution will be returned, i.e., in-place. 

* `L` Lower triangular matrix of size `n x n` on LHS of linear system.

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `triMultXLi()` <a id="_tri_utils_8h_1adfde552c3f71d142ee6ded89e49f9fb0"></a>

`public template<>`  <br/>`void `[`triMultXLi`](#_tri_utils_8h_1adfde552c3f71d142ee6ded89e49f9fb0)`(Ref< MatrixXd > X,const Eigen::MatrixBase< T1 > & L)`

In-place solution of a reverse lower triangular system

Performs the multiplication `X = X * L^{-1}`, where `L` is a lower triangular matrix.

#### Parameters
* `X` Matrix of size `n x p` on RHS of linear system. This is also where solution will be returned, i.e., in-place. 

* `L` Lower triangular matrix of size `n x n` on LHS of linear system.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `triMultUiX()` <a id="_tri_utils_8h_1aa62489bafdc65d2645b57e480ee2572e"></a>

`public template<>`  <br/>`void `[`triMultUiX`](#_tri_utils_8h_1aa62489bafdc65d2645b57e480ee2572e)`(const Eigen::MatrixBase< T1 > & U,Ref< MatrixXd > X)`

In-place solution of an upper triangular system

Performs the multiplication `X = U^{-1} * X`, where `U` is an upper triangular matrix.

#### Parameters
* `X` Matrix of size `n x p` on RHS of linear system. This is also where solution will be returned, i.e., in-place. 

* `U` Upper triangular matrix of size `n x n` on LHS of linear system.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `crossProdUtU()` <a id="_tri_utils_8h_1a79a58591ed0f4f3bd3c151d6d7f52266"></a>

`public template<>`  <br/>`void `[`crossProdUtU`](#_tri_utils_8h_1a79a58591ed0f4f3bd3c151d6d7f52266)`(const Eigen::MatrixBase< T1 > & X,const Ref< const MatrixXd > & U,const Eigen::MatrixBase< T2 > & L)`

Transpose-product of upper triangular matrices

Performs the multiplication X = U * U`, where`U` is an upper triangular matrix.

#### Parameters
* `X` Matrix of size `n x n` containing the transpose-product of `U`. 

* `U` Upper triangular matrix of size `n x n`. 

* `L` Lower triangular matrix of size `n x n` used for intermediate calculations.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `CrossProdLLt()` <a id="_tri_utils_8h_1a7ca9facdac5bff93d2db13420c3edf8e"></a>

`public template<>`  <br/>`void `[`CrossProdLLt`](#_tri_utils_8h_1a7ca9facdac5bff93d2db13420c3edf8e)`(const Eigen::MatrixBase< T1 > & X,const Ref< const MatrixXd > & L,const Eigen::MatrixBase< T2 > & U)`

Reverse transpose-product of lower triangular matrices

Performs the multiplication X = L * L`, where`L` is a lower triangular matrix.

#### Parameters
* `X` Matrix of size `n x n` containing the reverse transpose-product of `L`. 

* `L` Lower triangular matrix of size `n x n`. 

* `U` Upper triangular matrix of size `n x n` used for intermediate calculations.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `CrossProdLtL()` <a id="_tri_utils_8h_1af6693aa50f28ec42c038f8f532741332"></a>

`public template<>`  <br/>`void `[`CrossProdLtL`](#_tri_utils_8h_1af6693aa50f28ec42c038f8f532741332)`(const Eigen::MatrixBase< T1 > & X,const Ref< const MatrixXd > & L,const Eigen::MatrixBase< T2 > & U)`

Transpose-product of lower triangular matrices

Performs the multiplication X = L * L`, where`L` is a lower triangular matrix.

#### Parameters
* `X` Matrix of size `n x n` containing the transpose-product of `L`. 

* `L` Lower triangular matrix of size `n x n`. 

* `U` Upper triangular matrix of size `n x n` used for intermediate calculations.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `InverseLLt()` <a id="_tri_utils_8h_1aee6a1777f73c71378680d77c59814479"></a>

`public template<>`  <br/>`void `[`InverseLLt`](#_tri_utils_8h_1aee6a1777f73c71378680d77c59814479)`(Ref< MatrixXd > X,const Eigen::MatrixBase< T1 > & L,Ref< MatrixXd > L2,Ref< MatrixXd > U,const Ref< const MatrixXd > & I)`

Inverse of reverse transpose-product

Performs the calculation X = (L * L)^{-1}`, where`L` is a lower triangular matrix.

#### Parameters
* `X` Matrix of size `n x n` containing the inverse of the reverse transpose-product of `L`. 

* `L` Lower triangular matrix of size `n x n`. 

* `U` Upper triangular matrix of size `n x n` used for intermediate calculations.

* `L2` Lower triangular matrix of size `n x n` used for intermediate calculations. 

* `I` Identity matrix of size `n x n` used for intermediate calculations.

Does not work properly if any of the inputs arguments are also outputs. 

For safest results, all "off-triangular" elements of triangular arguments should be set to zero.

#### `ReverseCholesky()` <a id="_tri_utils_8h_1a18fc2d655dc265f4c1133403a61034fb"></a>

`public inline void `[`ReverseCholesky`](#_tri_utils_8h_1a18fc2d655dc265f4c1133403a61034fb)`(Ref< MatrixXd > L,const Ref< const MatrixXd > & V,LLT< MatrixXd > & llt)`

Reverse-Cholesky decomposition of a positive-definite matrix

Calculates the lower triangular matrix `L` satisfying `V = L'L`, where `V` is a positive-definite matrix.

#### Parameters
* `L` Lower triangular matrix of size `n x n`. 

* `V` Positive-definite matrix of size `n x n`. 

* `llt` Cholesky solver via reference to `Eigen::LLT` object used for intermediate calculations.

These calculations leave the upper triangular half of `L` unchanged, such that the output is truly triangular only if the upper triangular half of `L` was initialized to zero.

#### `logDetCholV()` <a id="_tri_utils_8h_1a3f6653dcf99e9386dde5bd02fbe099b9"></a>

`public inline double `[`logDetCholV`](#_tri_utils_8h_1a3f6653dcf99e9386dde5bd02fbe099b9)`(LLT< MatrixXd > & cholV)`

Logarithm of the determinant of a Cholesky decomposition

Calculates `log|L|`, where `L` is the lower triangular factor of a Cholesky decomposition.

#### Parameters
* `cholV` Cholesky factor of size `n x n`. This is represented by an object of class `Eigen::LLT`, such that the triangular factor is given by `L = cholV.matrixL()`. 

#### Returns
The logarithm of the determinant of `L`.

#### `logDetV()` <a id="_tri_utils_8h_1ad13e348945b0a769632c1dd5c0c96ae2"></a>

`public inline double `[`logDetV`](#_tri_utils_8h_1ad13e348945b0a769632c1dd5c0c96ae2)`(MatrixXd V,LLT< MatrixXd > cholV)`

Logarithm of the determinant of a positive-definite matrix

Calculates `log|V|`, where `V` is a positive-definite matrix.

#### Parameters
* `V` Positive-definite matrix of size `n x n`. 

* `cholV` Cholesky solver of size `n x n` required for intermediate calculations. 

#### Returns
The logarithm of the determinant of `V`.

#### `logMultiGamma()` <a id="_wishart_8h_1a53aee90f94b4d2aa862f49332ceb68d7"></a>

`public inline double `[`logMultiGamma`](#_wishart_8h_1a53aee90f94b4d2aa862f49332ceb68d7)`(double alpha,int q)`

Multivariate log-gamma function.

Computes the multivariate log-gamma function, which for real $\alpha$ and integer $q$ is defined as the logarithm of

$$
\Gamma_q(\alpha) = \pi^{q(q-1)/4} \prod_{j=1}^q \Gamma(\alpha + (1-j)/2).
$$

#### Parameters
* `alpha` Real scalar. 

* `q` Integer scalar. 

#### Returns
The multivariate log-gamma function $\log \Gamma_q(\alpha)$.

# class `mniw::HierNormal` <a id="classmniw_1_1_hier_normal"></a>

Gibbs sampler for posterior distribution of Hierarchical Normal model with unequal variances.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
[`HierNormal()`](classmniw_1_1_hier_normal_1a4adbed64b1b474cbdcd869eda087d9f0) | Constructor.
[`~HierNormal()`](classmniw_1_1_hier_normal_1a7cdd4ca1137d61b7987da1bfde3417f7) | Destructor.
[`setMu()`](classmniw_1_1_hier_normal_1a0b982b25a9c108f589a66fae346099ef) | Set random effects.
[`setISigmaL()`](classmniw_1_1_hier_normal_1a1191fec3e77190fbdc15bc440371a2b3) | Set lower Cholesky factor of random effects precision matrix.
[`setISigma()`](classmniw_1_1_hier_normal_1aa9209e19f30a24a856ca5c05acf10bc4) | Set random effects precision matrix.
[`setBeta()`](classmniw_1_1_hier_normal_1a683a17a5b1b34a44c563a656c7783d26) | Set random effects regression coefficients.
[`getMu()`](classmniw_1_1_hier_normal_1ab3434867e28a9f411c5cd9242258ed94) | Get random-effects matrix.
[`getMut()`](classmniw_1_1_hier_normal_1aab4999c72fcaf724af0f258698994c3e) | Get transpose of random-effects matrix.
[`getISigmaL()`](classmniw_1_1_hier_normal_1ade02a76b6f590cc568589ec6842424c1) | Get lower Cholesky factor of random effects precision matrix.
[`getSigma()`](classmniw_1_1_hier_normal_1a9b3c2f1a3fc2aaf58698f49332a8f1ea) | Get random effects variance matrix.
[`getBeta()`](classmniw_1_1_hier_normal_1a2e60f51963dcd0a7d7fa5d274d69d91b) | Get random effects regression coefficients.
[`UpdateBetaSigma()`](classmniw_1_1_hier_normal_1a349f4d3f8d9a1c2cdf85884a5e632fdc) | Update `Beta` and `Sigma`.
[`UpdateMu()`](classmniw_1_1_hier_normal_1afa4af9e8e1d5a01c30d0345db6e1e5d2) | Update `Mu`.

## Members

#### `HierNormal()` <a id="classmniw_1_1_hier_normal_1a4adbed64b1b474cbdcd869eda087d9f0"></a>

`public inline  `[`HierNormal`](#classmniw_1_1_hier_normal_1a4adbed64b1b474cbdcd869eda087d9f0)`(const Ref< const MatrixXd > & Y,const Ref< const MatrixXd > & X,const Ref< const MatrixXd > & V,const Ref< const MatrixXd > & Lambda,const Ref< const MatrixXd > & Omega,const Ref< const MatrixXd > & Psi,double nu)`

Constructor.

#### Parameters
* `Y` Response matrix of size `N x q`, each row is an observation. 

* `X` Covariate matrix of size `N x q`, each row is an observation. 

* `V` Matrix of size `q x (Nq)` containing the variance of each response about its mean. 

* `Lambda` Prior mean matrix of size `p x q`. 

* `Omega` Prior between-row precision matrix of size `p x p`. 

* `Psi` Prior between-column scale matrix of size `q x q`. 

* `nu` Shape parameter.

#### `~HierNormal()` <a id="classmniw_1_1_hier_normal_1a7cdd4ca1137d61b7987da1bfde3417f7"></a>

`public inline  `[`~HierNormal`](#classmniw_1_1_hier_normal_1a7cdd4ca1137d61b7987da1bfde3417f7)`()`

Destructor.

#### `setMu()` <a id="classmniw_1_1_hier_normal_1a0b982b25a9c108f589a66fae346099ef"></a>

`public void `[`setMu`](#classmniw_1_1_hier_normal_1a0b982b25a9c108f589a66fae346099ef)`(const Ref< const MatrixXd > & Mu)`

Set random effects.

#### Parameters
* `Mu` Random-effects matrix of size `N x q`.

#### `setISigmaL()` <a id="classmniw_1_1_hier_normal_1a1191fec3e77190fbdc15bc440371a2b3"></a>

`public inline void `[`setISigmaL`](#classmniw_1_1_hier_normal_1a1191fec3e77190fbdc15bc440371a2b3)`(const Ref< const MatrixXd > & iSigmaL)`

Set lower Cholesky factor of random effects precision matrix.

#### Parameters
* `iSigmaL` Lower Cholesky factor of the random-effects precision matrix of size `q x q`.

#### `setISigma()` <a id="classmniw_1_1_hier_normal_1aa9209e19f30a24a856ca5c05acf10bc4"></a>

`public inline void `[`setISigma`](#classmniw_1_1_hier_normal_1aa9209e19f30a24a856ca5c05acf10bc4)`(const Ref< const MatrixXd > & iSigma)`

Set random effects precision matrix.

#### Parameters
* `iSigma` Random-effects precision matrix of size `q x q`.

#### `setBeta()` <a id="classmniw_1_1_hier_normal_1a683a17a5b1b34a44c563a656c7783d26"></a>

`public inline void `[`setBeta`](#classmniw_1_1_hier_normal_1a683a17a5b1b34a44c563a656c7783d26)`(const Ref< const MatrixXd > & Beta)`

Set random effects regression coefficients.

#### Parameters
* `Beta` Random-effects coefficient matrix of size `p x q`.

#### `getMu()` <a id="classmniw_1_1_hier_normal_1ab3434867e28a9f411c5cd9242258ed94"></a>

`public inline void `[`getMu`](#classmniw_1_1_hier_normal_1ab3434867e28a9f411c5cd9242258ed94)`(Ref< MatrixXd > Mu)`

Get random-effects matrix.

#### Parameters
* `Mu` [out] Matrix of size `N x q` in which to output current value of random effects.

#### `getMut()` <a id="classmniw_1_1_hier_normal_1aab4999c72fcaf724af0f258698994c3e"></a>

`public inline void `[`getMut`](#classmniw_1_1_hier_normal_1aab4999c72fcaf724af0f258698994c3e)`(Ref< MatrixXd > Mut)`

Get transpose of random-effects matrix.

#### Parameters
* `Mut` [out] Matrix of size `q x N` in which to output the transpose of the current value of random effects.

#### `getISigmaL()` <a id="classmniw_1_1_hier_normal_1ade02a76b6f590cc568589ec6842424c1"></a>

`public inline void `[`getISigmaL`](#classmniw_1_1_hier_normal_1ade02a76b6f590cc568589ec6842424c1)`(Ref< MatrixXd > iSigmaL)`

Get lower Cholesky factor of random effects precision matrix.

#### Parameters
* `iSigmaL` [out] Matrix of size `q x q` in which to output current value of the lower Cholesky factor of the random effects precision matrix.

#### `getSigma()` <a id="classmniw_1_1_hier_normal_1a9b3c2f1a3fc2aaf58698f49332a8f1ea"></a>

`public inline void `[`getSigma`](#classmniw_1_1_hier_normal_1a9b3c2f1a3fc2aaf58698f49332a8f1ea)`(Ref< MatrixXd > Sigma)`

Get random effects variance matrix.

#### Parameters
* `Sigma` [out] Matrix of size `q x q` in which to output current value of the random-effects variance matrix.

#### `getBeta()` <a id="classmniw_1_1_hier_normal_1a2e60f51963dcd0a7d7fa5d274d69d91b"></a>

`public inline void `[`getBeta`](#classmniw_1_1_hier_normal_1a2e60f51963dcd0a7d7fa5d274d69d91b)`(Ref< MatrixXd > Beta)`

Get random effects regression coefficients.

#### Parameters
* `Beta` [out] Matrix of size `p x q` in which to output current value of the random-effects regression coefficients.

#### `UpdateBetaSigma()` <a id="classmniw_1_1_hier_normal_1a349f4d3f8d9a1c2cdf85884a5e632fdc"></a>

`public inline void `[`UpdateBetaSigma`](#classmniw_1_1_hier_normal_1a349f4d3f8d9a1c2cdf85884a5e632fdc)`()`

Update `Beta` and `Sigma`.

Performs one draw of $(\boldsymbol{\beta}, \boldsymbol{\Sigma}) \sim p(\boldsymbol{\beta}, \boldsymbol{\Sigma} \mid \boldsymbol{\mu}, \boldsymbol{Y}, \boldsymbol{X})$ and assigns it to the internal values of `Beta` and `Sigma`.

#### `UpdateMu()` <a id="classmniw_1_1_hier_normal_1afa4af9e8e1d5a01c30d0345db6e1e5d2"></a>

`public inline void `[`UpdateMu`](#classmniw_1_1_hier_normal_1afa4af9e8e1d5a01c30d0345db6e1e5d2)`()`

Update `Mu`.

Performs one draw of $\boldsymbol{\mu} \sim p(\boldsymbol{\mu} \mid \boldsymbol{\beta}, \boldsymbol{\Sigma}, \boldsymbol{Y}, \boldsymbol{X})$ and assigns it to the interval value of `Mu`.

# class `mniw::MatrixNormal` <a id="classmniw_1_1_matrix_normal"></a>

The Matrix Normal distribution.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
[`MatrixNormal()`](classmniw_1_1_matrix_normal_1a033d7bb7ce43323157697c42e59db975) | Constructor.
[`LogDens()`](classmniw_1_1_matrix_normal_1a6b5cd49b51f7ee90822bed404e3d630a) | Log-density evaluation.
[`LogDens()`](classmniw_1_1_matrix_normal_1ab38b401fdf3f08d7e60a22215c84b993) | Log-density evaluation with precomputations.
[`GenerateRowSColS()`](classmniw_1_1_matrix_normal_1a4eafd57c4a23562faca523fa1bceb6a2) | Random draw with RowV/ColV on the variance/variance scale.
[`GenerateRowSColO()`](classmniw_1_1_matrix_normal_1a1c76fef69a647250464e6a3fc0c2f4f3) | Random number generation with RowV/ColV on the variance/precision scale.
[`GenerateRowOColO()`](classmniw_1_1_matrix_normal_1a447f4e7fe19375f691d96cbb809625bd) | Random number generation with RowV/ColV on the precision/precision scale.

## Members

#### `MatrixNormal()` <a id="classmniw_1_1_matrix_normal_1a033d7bb7ce43323157697c42e59db975"></a>

`public inline  `[`MatrixNormal`](#classmniw_1_1_matrix_normal_1a033d7bb7ce43323157697c42e59db975)`(int p,int q)`

Constructor.

#### Parameters
* `p` Number of rows of Matrix Normal distribution. 

* `q` Number of columns of Matrix Normal distribution.

#### `LogDens()` <a id="classmniw_1_1_matrix_normal_1a6b5cd49b51f7ee90822bed404e3d630a"></a>

`public inline double `[`LogDens`](#classmniw_1_1_matrix_normal_1a6b5cd49b51f7ee90822bed404e3d630a)`(const Ref< const MatrixXd > & X,const Ref< const MatrixXd > & Lambda,const Ref< const MatrixXd > & SigmaR,const Ref< const MatrixXd > & SigmaC)`

Log-density evaluation.

#### Parameters
* `X` Observation matrix of size `p x q`. 

* `Lambda` Mean matrix of size `p x q`. 

* `SigmaR` Row-variance matrix of size `p x p`. 

* `SigmaC` Column-variance matrix of size `q x q`.

#### Returns
The log-density evaluated at `X`.

#### `LogDens()` <a id="classmniw_1_1_matrix_normal_1ab38b401fdf3f08d7e60a22215c84b993"></a>

`public inline double `[`LogDens`](#classmniw_1_1_matrix_normal_1ab38b401fdf3f08d7e60a22215c84b993)`(const Ref< const MatrixXd > & X,const Ref< const MatrixXd > & Lambda,LLT< MatrixXd > & cholSigmaR,double ldSigmaR,LLT< MatrixXd > & cholSigmaC,double ldSigmaC)`

Log-density evaluation with precomputations.

Identical to the shorter `LogDens`, except with pre-computed Cholesky factors and log-determinants for `SigmaR` and `SigmaC` (faster in a for-loop where one of these is held fixed).

#### Parameters
* `X` Observation matrix of size `p x q`. 

* `Lambda` Mean matrix of size `p x q`. 

* `cholSigmaR` Lower Cholesky factor of row-variance matrix, as an `Eigen::LLT` object. 

* `ldSigmaR` Log-determinant of `cholSigmaR`. 

* `cholSigmaC` Lower Cholesky factor of column-variance matrix, as an `Eigen::LLT` object.

* `ldSigmaC` Log-determinant of `cholSigmaC`.

#### Returns
The log-density evaluated as `X`.

#### `GenerateRowSColS()` <a id="classmniw_1_1_matrix_normal_1a4eafd57c4a23562faca523fa1bceb6a2"></a>

`public inline void `[`GenerateRowSColS`](#classmniw_1_1_matrix_normal_1a4eafd57c4a23562faca523fa1bceb6a2)`(Ref< MatrixXd > X,const Ref< const MatrixXd > & Lambda,const Ref< const MatrixXd > & SigmaRL,const Ref< const MatrixXd > & SigmaCU)`

Random draw with RowV/ColV on the variance/variance scale.

#### Parameters
* `X` Matrix of size `p x q` in which to store the random draw. 

* `Lambda` Mean matrix of size `p x q`. 

* `SigmaRL` Lower Cholesky factor of the row-variance matrix `SigmaR` (a matrix of size `p x p`). 

* `SigmaCU` Upper Cholesky factor of the column-variance matrix `SigmaC` (a matrix of size `q x q`).

#### `GenerateRowSColO()` <a id="classmniw_1_1_matrix_normal_1a1c76fef69a647250464e6a3fc0c2f4f3"></a>

`public inline void `[`GenerateRowSColO`](#classmniw_1_1_matrix_normal_1a1c76fef69a647250464e6a3fc0c2f4f3)`(Ref< MatrixXd > X,const Ref< const MatrixXd > & Lambda,const Ref< const MatrixXd > & SigmaRL,const Ref< const MatrixXd > & OmegaCL)`

Random number generation with RowV/ColV on the variance/precision scale.

#### Parameters
* `X` Matrix of size `p x q` in which to store the random draw. 

* `Lambda` Mean matrix of size `p x q`. 

* `SigmaRL` Lower Cholesky factor of the row-variance matrix `SigmaR` (a matrix of size `p x p`). 

* `OmegaCL` Lower Cholesky factor of the column-precision matrix `SigmaC^{-1}` (a matrix of size `q x q`).

#### `GenerateRowOColO()` <a id="classmniw_1_1_matrix_normal_1a447f4e7fe19375f691d96cbb809625bd"></a>

`public inline void `[`GenerateRowOColO`](#classmniw_1_1_matrix_normal_1a447f4e7fe19375f691d96cbb809625bd)`(Ref< MatrixXd > X,const Ref< const MatrixXd > & Lambda,const Ref< const MatrixXd > & OmegaRU,const Ref< const MatrixXd > & OmegaCL)`

Random number generation with RowV/ColV on the precision/precision scale.

#### Parameters
* `X` Matrix of size `p x q` in which to store the random draw. 

* `Lambda` Mean matrix of size `p x q`. 

* `OmegaRU` Upper Cholesky factor of the row-precision matrix `SigmaR^{-1}` (a matrix of size `p x p`). 

* `OmegaCL` Lower Cholesky factor of the column-precision matrix `SigmaC^{-1}` (a matrix of size `q x q`).

# class `mniw::MatrixT` <a id="classmniw_1_1_matrix_t"></a>

The Matrix-t distribution.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
[`MatrixT()`](classmniw_1_1_matrix_t_1a329612cbfc19c924e38c4eea02c7e892) | Constructor.
[`~MatrixT()`](classmniw_1_1_matrix_t_1a73b4733f5320f96efbc05851a3ca9e97) | Destructor.
[`LogDens()`](classmniw_1_1_matrix_t_1a9100e03eec1852d1b344c316e4715253) | Log-density evaluation.
[`LogDens()`](classmniw_1_1_matrix_t_1a411e948daebd9167a8c8977fab16d710) | Log-density evaluation with precomputations.
[`GenerateRowSColO()`](classmniw_1_1_matrix_t_1aeb87b7148aae159e618a72ecfa604dd2) | Random draw with RowV/ColV on the variance/precision scale.
[`GenerateRowOColO()`](classmniw_1_1_matrix_t_1a4aaaf2387d4a7fb8c1fe3ef420671f66) | Random draw with RowV/ColV on the precision/precision scale.

## Members

#### `MatrixT()` <a id="classmniw_1_1_matrix_t_1a329612cbfc19c924e38c4eea02c7e892"></a>

`public inline  `[`MatrixT`](#classmniw_1_1_matrix_t_1a329612cbfc19c924e38c4eea02c7e892)`(int p,int q)`

Constructor.

#### Parameters
* `p` Number of rows of Matrix-t distribution. 

* `q` Number of columns of Matrix-t distribution.

#### `~MatrixT()` <a id="classmniw_1_1_matrix_t_1a73b4733f5320f96efbc05851a3ca9e97"></a>

`public inline  `[`~MatrixT`](#classmniw_1_1_matrix_t_1a73b4733f5320f96efbc05851a3ca9e97)`()`

Destructor.

#### `LogDens()` <a id="classmniw_1_1_matrix_t_1a9100e03eec1852d1b344c316e4715253"></a>

`public inline double `[`LogDens`](#classmniw_1_1_matrix_t_1a9100e03eec1852d1b344c316e4715253)`(const Ref< const MatrixXd > & X,const Ref< const MatrixXd > & Mu,const Ref< const MatrixXd > & SigmaR,const Ref< const MatrixXd > & SigmaC,double nu)`

Log-density evaluation.

#### Parameters
* `X` Observation matrix of size `p x q`. 

* `Mu` Mean matrix of size `p x q`. 

* `SigmaR` Row-variance matrix of size `p x p`. 

* `SigmaC` Column-variance matrix of size `q x q`. 

* `nu` Shape parameter.

#### Returns
The log-density evaluated at `X`.

#### `LogDens()` <a id="classmniw_1_1_matrix_t_1a411e948daebd9167a8c8977fab16d710"></a>

`public inline double `[`LogDens`](#classmniw_1_1_matrix_t_1a411e948daebd9167a8c8977fab16d710)`(const Ref< const MatrixXd > & X,const Ref< const MatrixXd > & Mu,const Ref< const MatrixXd > & SigmaR,LLT< MatrixXd > & cholSigmaR,double ldSigmaR,const Ref< const MatrixXd > & SigmaC,LLT< MatrixXd > & cholSigmaC,double ldSigmaC,double nu)`

Log-density evaluation with precomputations.

Identical to the shorter `LogDens`, except with pre-computed Cholesky factor and log-determinants for `SigmaR` and `SigmaC` (faster in a for-loop where one of these is held fixed).

#### Parameters
* `X` Observation matrix of size `p x q`. 

* `Mu` Mean matrix of size `p x q`. 

* `SigmaR` Row-variance matrix of size `p x p`. 

* `cholSigmaR` Lower Cholesky factor of row-variance matrix, as an `Eigen::LLT` object. 

* `ldSigmaR` Log-determinant of `cholSigmaR`. 

* `SigmaC` Column-variance matrix of size `q x q`. 

* `cholSigmaC` Lower Cholesky factor of column-variance matrix, as an `Eigen::LLT` object. 

* `ldSigmaC` Log-determinant of `cholSigmaC`. 

* `nu` Shape parameter.

#### Returns
The log-density evaluated at `X`.

#### `GenerateRowSColO()` <a id="classmniw_1_1_matrix_t_1aeb87b7148aae159e618a72ecfa604dd2"></a>

`public inline void `[`GenerateRowSColO`](#classmniw_1_1_matrix_t_1aeb87b7148aae159e618a72ecfa604dd2)`(Ref< MatrixXd > X,const Ref< const MatrixXd > & Mu,const Ref< const MatrixXd > & SigmaRL,const Ref< const MatrixXd > & OmegaCL,double nu)`

Random draw with RowV/ColV on the variance/precision scale.

#### Parameters
* `X` Matrix of size `p x q` in which to store the random draw. 

* `Mu` Mean matrix of size `p x q`. 

* `SigmaRL` Lower Cholesky factor of the row-variance matrix `SigmaR` (a matrix of size `p x p`). 

* `OmegaCL` Lower Cholesky factor of the column-precision matrix: `SigmaC^{-1} = OmegaCL * t(OmegaCL)` (a matrix of size `q x q`). 

* `nu` Shape parameter.

#### `GenerateRowOColO()` <a id="classmniw_1_1_matrix_t_1a4aaaf2387d4a7fb8c1fe3ef420671f66"></a>

`public inline void `[`GenerateRowOColO`](#classmniw_1_1_matrix_t_1a4aaaf2387d4a7fb8c1fe3ef420671f66)`(Ref< MatrixXd > X,const Ref< const MatrixXd > & Mu,const Ref< const MatrixXd > & OmegaRU,const Ref< const MatrixXd > & OmegaCL,double nu)`

Random draw with RowV/ColV on the precision/precision scale.

#### Parameters
* `X` Matrix of size `p x q` in which to store the random draw. 

* `Mu` Mean matrix of size `p x q`. 

* `OmegaRU` Upper Cholesky factor of the row-precision matrix: `SigmaR^{-1} = t(OmegaRU) * OmegaRU` (a matrix of size `p x p`). 

* `OmegaCL` Lower Cholesky factor of the column-precision matrix: `SigmaC^{-1} = OmegaCL * t(OmegaCL)` (a matrix of size `q x q`). 

* `nu` Shape parameter.

# class `mniw::MultiNormal` <a id="classmniw_1_1_multi_normal"></a>

The Multivariate Normal distribution.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
[`MultiNormal()`](classmniw_1_1_multi_normal_1a2ed4c6ad5819a215986173695a7c65bf) | Constructor.
[`LogDens()`](classmniw_1_1_multi_normal_1a729cdde2d7a2b1f7fe01808aff857618) | Log-density with precomputations.
[`LogDens()`](classmniw_1_1_multi_normal_1a5855e0c97ab0ba0058a8655971a03f5c) | Log-density.
[`Generate()`](classmniw_1_1_multi_normal_1ad1f32eefd016026d35409d05027b7efd) | Random number generation with pre-computations.
[`Generate()`](classmniw_1_1_multi_normal_1a06b212c5fc2e3798732629c7a5d7c848) | Random number generation.

## Members

#### `MultiNormal()` <a id="classmniw_1_1_multi_normal_1a2ed4c6ad5819a215986173695a7c65bf"></a>

`public inline  `[`MultiNormal`](#classmniw_1_1_multi_normal_1a2ed4c6ad5819a215986173695a7c65bf)`(int q)`

Constructor.

#### Parameters
* `q` Number of dimensions of the Multivariate Normal.

#### `LogDens()` <a id="classmniw_1_1_multi_normal_1a729cdde2d7a2b1f7fe01808aff857618"></a>

`public inline double `[`LogDens`](#classmniw_1_1_multi_normal_1a729cdde2d7a2b1f7fe01808aff857618)`(const Ref< const VectorXd > & x,const Ref< const VectorXd > & mu,LLT< MatrixXd > & cholSigma,double ldSigma)`

Log-density with precomputations.

Identical to the shorter version of `LogDens`, but with the Cholesky decomposition and its log-determinant pre-computed.

#### Parameters
* `x` Vector of observations. 

* `mu` Mean vector. 

* `cholSigma` Cholesky decomposition of the variance matrix, supplied as an `Eigen::LLT` object. 

* `ldSigma` Log-determinant of the Cholesky factor of the variance.

#### Returns
The log-density evaluated at `x`.

#### `LogDens()` <a id="classmniw_1_1_multi_normal_1a5855e0c97ab0ba0058a8655971a03f5c"></a>

`public inline double `[`LogDens`](#classmniw_1_1_multi_normal_1a5855e0c97ab0ba0058a8655971a03f5c)`(const Ref< const VectorXd > & x,const Ref< const VectorXd > & mu,const Ref< const MatrixXd > & Sigma)`

Log-density.

#### Parameters
* `x` Vector of observations. 

* `mu` Mean vector. 

* `Sigma` Variance matrix.

#### Returns
The log-density evaluated at `x`.

#### `Generate()` <a id="classmniw_1_1_multi_normal_1ad1f32eefd016026d35409d05027b7efd"></a>

`public inline void `[`Generate`](#classmniw_1_1_multi_normal_1ad1f32eefd016026d35409d05027b7efd)`(Ref< VectorXd > x,const Ref< const VectorXd > & mu,LLT< MatrixXd > & cholSigma,Ref< MatrixXd > SigmaL)`

Random number generation with pre-computations.

#### Parameters
* `x` Vector to which random draw is assigned. 

* `mu` Mean vector. 

* `cholSigma` Cholesky decomposition of the variance, supplied as an `Eigen::LLT` object. 

* `SigmaL` Dense representation of this object. This is because `TriMultLX` does not accept `Eigen::TriangularView` objects and hopefully can be removed in the future...

#### `Generate()` <a id="classmniw_1_1_multi_normal_1a06b212c5fc2e3798732629c7a5d7c848"></a>

`public inline void `[`Generate`](#classmniw_1_1_multi_normal_1a06b212c5fc2e3798732629c7a5d7c848)`(Ref< VectorXd > x,const Ref< const VectorXd > & mu,const Ref< const MatrixXd > & Sigma)`

Random number generation.

#### Parameters
* `x` Vector to which random draw is assigned. 

* `mu` Mean vector. 

* `Sigma` Variance matrix.

# class `mniw::RanfxNormal` <a id="classmniw_1_1_ranfx_normal"></a>

The Multivariate Random-Effects Normal distribution.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
[`RanfxNormal()`](classmniw_1_1_ranfx_normal_1ade1dc31fcdea4b65ff535dae696160ba) | Constructor.
[`GenerateOL()`](classmniw_1_1_ranfx_normal_1a210fbf6ebb0352948ece63614a720dfe) | Random number generation with prior precision matrix on the Cholesky scale.
[`GenerateO()`](classmniw_1_1_ranfx_normal_1aa27b8e328fd4d30eed11bd9986c7afec) | Random number generation with prior precision matrix on the regular scale.

## Members

#### `RanfxNormal()` <a id="classmniw_1_1_ranfx_normal_1ade1dc31fcdea4b65ff535dae696160ba"></a>

`public inline  `[`RanfxNormal`](#classmniw_1_1_ranfx_normal_1ade1dc31fcdea4b65ff535dae696160ba)`(int q)`

Constructor.

#### Parameters
* `q` Number of dimensions of the Multivariate Normal.

#### `GenerateOL()` <a id="classmniw_1_1_ranfx_normal_1a210fbf6ebb0352948ece63614a720dfe"></a>

`public inline void `[`GenerateOL`](#classmniw_1_1_ranfx_normal_1a210fbf6ebb0352948ece63614a720dfe)`(Ref< VectorXd > mu,const Ref< const VectorXd > & x,const Ref< const MatrixXd > & C,const Ref< const MatrixXd > & OmegaL)`

Random number generation with prior precision matrix on the Cholesky scale.

#### Parameters
* `mu` Vector in which to assign the random draw. 

* `x` Vector of observed data. 

* `C` Precision matrix of the observed data, `C = V^{-1}`. 

* `OmegaL` Cholesky factor of the prior precision matrix, `Sigma^{-1} = OmegaL * t(OmegaL)`.

#### `GenerateO()` <a id="classmniw_1_1_ranfx_normal_1aa27b8e328fd4d30eed11bd9986c7afec"></a>

`public inline void `[`GenerateO`](#classmniw_1_1_ranfx_normal_1aa27b8e328fd4d30eed11bd9986c7afec)`(Ref< VectorXd > mu,const Ref< const VectorXd > & x,const Ref< const MatrixXd > & C,const Ref< const MatrixXd > & Omega)`

Random number generation with prior precision matrix on the regular scale.

#### Parameters
* `mu` Vector in which to assign the random draw. 

* `x` Vector of observed data. 

* `C` Precision matrix of the observed data, `C = V^{-1}`. 

* `Omega` Prior precision matrix, `Omega = Sigma^{-1}`.

# class `mniw::Wishart` <a id="classmniw_1_1_wishart"></a>

The Wishart and Inverse Wishart distributions.

The Wishart distribution is on a random positive-definite matrix $\bm{X}_{q\times q}$ is is denoted $X \sim \mathrm{Wish}(\Psi, \nu)$, and defined as $X = (L Z)(L Z)'$, where

* $\Psi_{q\times q} = LL'$ is the positive-definite matrix scale parameter,

* $\nu > $ is the shape parameter,

and $Z_{q\times q}$ is a random lower-triangular matrix with elements 
$$
Z_{ij} \begin{cases} \stackrel{\mathrm{iid}}{\sim} \mathcal N(0,1) & i < j \\ \stackrel{\mathrm{ind}}{\sim} \chi^2_{(\nu-i+1)} & i = j \\ = 0 & i > j. \end{cases}
$$

The log-density of the Wishart distribution is 
$$
\log p(X \mid \Psi, \nu) = -\tfrac{1}{2} \left[\mathrm{tr}(\Psi^{-1} X) + (q+1-\nu)\log |X| + \nu \log |\Psi| + \nu q \log(2) + 2 \log \Gamma_q(\tfrac \nu 2)\right],
$$
 where $\Gamma_n(x)$ is the multivariate Gamma function defined as 
$$
\Gamma_n(x) = \pi^{n(n-1)/4} \prod_{j=1}^n \Gamma\big(x + \tfrac 1 2 (1-j)\big).
$$

The Inverse-Wishart distribution $X \sim \mathrm{InvWish}(\Psi, \nu)$ is defined as $X^{-1} \sim \mathrm{Wish}(\Psi^{-1}, \nu)$. Its log-density is given by 
$$
\log p(X \mid \Psi, \nu) = -\tfrac 1 2 \left[\mathrm{tr}(\Psi X^{-1}) + (\nu+q+1) \log |X| - \nu \log |\Psi| + \nu q \log(2) + 2 \log \Gamma_q(\tfrac \nu 2)\right].
$$

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
[`Wishart()`](classmniw_1_1_wishart_1a45f260ee7fc79c85497a7449a2220200) | Constructor.
[`LogDens()`](classmniw_1_1_wishart_1ad0402256f527189c57765da8307dd413) | Log-density.
[`LogDens()`](classmniw_1_1_wishart_1a5f9c66bba21d482bb20760809c531f90) | Log-density with pre-computations.
[`GenerateLowerTri()`](classmniw_1_1_wishart_1a091d1a4ae2eaf983bbce2ffdb205d5e3) | Random draw with scale matrix input.
[`GenerateLowerTriXi()`](classmniw_1_1_wishart_1aa0409c4d479a1228b591e6ab9351bb9b) | Random draw with precision matrix input.

## Members

#### `Wishart()` <a id="classmniw_1_1_wishart_1a45f260ee7fc79c85497a7449a2220200"></a>

`public inline  `[`Wishart`](#classmniw_1_1_wishart_1a45f260ee7fc79c85497a7449a2220200)`(int q)`

Constructor.

#### Parameters
* `q` Size of the Wishart/Inverse-Wishart distribution.

#### `LogDens()` <a id="classmniw_1_1_wishart_1ad0402256f527189c57765da8307dd413"></a>

`public inline double `[`LogDens`](#classmniw_1_1_wishart_1ad0402256f527189c57765da8307dd413)`(const Ref< const MatrixXd > & X,const Ref< const MatrixXd > & Psi,double nu,bool inv)`

Log-density.

#### Parameters
* `X` Observation matrix of size `q x q`. 

* `Psi` Scale matrix parameter of size `q x q`. 

* `nu` Shape parameter. 

* `inv` Whether or not the Inverse-Wishart distribution is desired.

#### Returns
The log-density of the distribution.

#### `LogDens()` <a id="classmniw_1_1_wishart_1a5f9c66bba21d482bb20760809c531f90"></a>

`public inline double `[`LogDens`](#classmniw_1_1_wishart_1a5f9c66bba21d482bb20760809c531f90)`(const Ref< const MatrixXd > & X,LLT< MatrixXd > & cholX,double ldX,const Ref< const MatrixXd > & Psi,LLT< MatrixXd > & cholPsi,double ldPsi,double nu,bool inv)`

Log-density with pre-computations.

Identical to [Wishart::LogDens(const Ref<const MatrixXd>&,const Ref<const MatrixXd>&,double,bool)](#classmniw_1_1_wishart_1ad0402256f527189c57765da8307dd413), except with pre-computed Cholesky factors and log-determinants for `X` and `Psi` (faster in a for-loop where one of these is held fixed).

#### Parameters
* `X` Observation matrix of size `q x q`. 

* `cholX` Cholesky decomposition of a variance matrix `X`. This is represented by an `Eigen::LLT` object, for which `cholX.compute()` has already been applied. 

* `ldX` Log-determinant of `cholX`. 

* `Psi` Scale matrix parameter of size `q x q`. 

* `cholPsi` Cholesky decomposition of the scale matrix parameter `Psi`. 

* `ldPsi` Log-determinant of `cholPsi`. 

* `nu` Shape parameter. 

* `inv` Whether or not the Inverse-Wishart distribution is desired.

#### Returns
The log-density of the distribution.

#### `GenerateLowerTri()` <a id="classmniw_1_1_wishart_1a091d1a4ae2eaf983bbce2ffdb205d5e3"></a>

`public inline void `[`GenerateLowerTri`](#classmniw_1_1_wishart_1a091d1a4ae2eaf983bbce2ffdb205d5e3)`(Ref< MatrixXd > XL,const Ref< const MatrixXd > & PsiL,double nu)`

Random draw with scale matrix input.

Simulate a random draw from the lower Cholesky factor of a [Wishart](#classmniw_1_1_wishart) distribution with given scale matrix and shape parameters.

#### Parameters
* `XL` Matrix of size `q x q` containing the random draw, which lives only on the lower triangular half of the matrix. 

* `PsiL` Matrix of size `q x q` containing the lower Cholesky factor of the scale matrix parameter `Psi`. 

* `nu` Shape parameter.

#### `GenerateLowerTriXi()` <a id="classmniw_1_1_wishart_1aa0409c4d479a1228b591e6ab9351bb9b"></a>

`public inline void `[`GenerateLowerTriXi`](#classmniw_1_1_wishart_1aa0409c4d479a1228b591e6ab9351bb9b)`(Ref< MatrixXd > XL,const Ref< const MatrixXd > & XiL,double nu)`

Random draw with precision matrix input.

Simulate a random draw from the lower Cholesky factor of a [Wishart](#classmniw_1_1_wishart) distribution with given precision matrix and shape parameters.

#### Parameters
* `XL` Matrix of size `q x q` containing the random draw, which lives only on the lower triangular half of the matrix. 

* `XiL` Matrix containing the inverse of the lower Cholesky factor of the scale matrix parameter `Psi`, namely Psi^{-1} = XiL * XiL`. 

* `nu` Shape parameter.

Generated by [Moxygen](https://sourcey.com/moxygen)
