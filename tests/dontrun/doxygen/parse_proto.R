# total hack into moxygen processing :(

indent_args <- function(name, args) {
  nargs <- length(args)
  if(nargs > 1) args[-nargs] <- paste0(args[-nargs], ",")
  args[nargs] <- paste0(args[nargs], ")")
  out <- paste0(name, "(", args[1])
  if(nargs > 1) {
    out <- c(out,
             sapply(args[-1],
                    function(x) paste0(c(rep(" ", nchar(name)+1), x), collapse = "")))
  }
  out
}

parse_proto <- function(proto) {
  is_temp <- grepl("<br/>", proto) # templated function
  pp <- strsplit(proto, "`")[[1]]
  if(is_temp) {
    pp <- list(template = pp[2],
               type = pp[4],
               name = pp[6],
               anchor = gsub("(^\\]\\(|\\)$)", "", pp[7]),
               args = strsplit(gsub("(^\\(|\\)$)", "", pp[8]), ",")[[1]])
    pp <- lapply(pp, trimws)
    pp <- c(pp$template, indent_args(paste0(pp$type, " ", pp$name), pp$args))
  } else {
    pp <- list(type = pp[2],
               name = pp[4],
               anchor = gsub("(^\\]\\(|\\)$)", "", pp[5]),
               args = as.list(trimws(strsplit(gsub("(^\\(|\\)$)", "", pp[6]), ",")[[1]])))
    pp <- lapply(pp, trimws)
    pp <- indent_args(paste0(pp$type, " ", pp$name), pp$args)
  }
  cat("```cpp", pp, "```", sep = "\n")
}

## parse_proto("`public template<>`  <br/>`void `[`triMultLL`](#_tri_utils_8h_1a5daadd239a4be77fe6470cfc9a560353)`(const Eigen::MatrixBase< T1 > & X,const Ref< const MatrixXd > & L1,const Eigen::MatrixBase< T2 > & L2)`")


## indent_args(pp$name, pp$args)

## parse_proto("`public inline  `[`HierNormal`](#classmniw_1_1_hier_normal_1a4adbed64b1b474cbdcd869eda087d9f0)`(const Ref< const MatrixXd > & Y,const Ref< const MatrixXd > & X,const Ref< const MatrixXd > & V,const Ref< const MatrixXd > & Lambda,const Ref< const MatrixXd > & Omega,const Ref< const MatrixXd > & Psi,double nu)`")
