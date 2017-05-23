## Submission

This is a first submission. 

## Test environments

* Manjaro Linux 64-bit, R 3.4.0
* Win7 64-bit, R 3.4.0
* win-builder (devel and release)

### Travis CI matrix:

* os: linux
    * dist: trusty
    * sudo: required
    * env: R_CODECOV=true
    * r_check_args: '--use-valgrind'
* os: osx
    * osx_image: xcode8.2

## R CMD check results in my test environments

There were no ERRORs or WARNINGs, but one NOTE:

checking CRAN incoming feasibility ... NOTE

Possibly mis-spelled words in DESCRIPTION:
  Doxygen (2:15)
  RStudio (9:14)
  addin (9:22)
  doxygen (8:21)
  doxygenize (9:56)

## Comments

* Parts of the code depend on doxygen and can't be properly tested automatically. I added some tests in tests/manual_tests to check them in a local setup.  