# direct parsing with xml2

# let's say for now:
# - the point is to extract namespaces, classes, and functions.
# - none of the undocumented items will appear.
# - functions and methods will be parsed the same way.

require(xml2)

# read the index file
index <- read_xml(file.path("xml", "index.xml"))

xml_attr(xml_children(index), attr = "kind")
xml_attr(xml_children(index), attr = "refid")

# inspect one of the index compounds
## icomp <- 1 # hiernormal class
## icomp <- 4 # triutils header (nothing relevant)
icomp <- 8 # mniw namespace
compound <- xml_attr(xml_child(index, icomp), attr = "refid")
compound <- read_xml(file.path("xml", paste0(compound, ".xml")))
compound <- xml_child(compound)
compound

# check if doc exists
has_doc <- function(x) {
  ans <- paste0(xml_extract(x, "briefdescription"),
                xml_extract(x, "detaileddescription"),
                xml_extract(x, "inbodydescription"))
  length(ans) > 0 && ans != ""
}

# extract text from node
xml_extract <- function(x, xpath) {
  xml_text(xml_find_all(x, xpath), trim = TRUE)
}

# parse para node (i.e., text with possible computer output)
parse_para <- function(x) {
  y <- unlist(as_list(x), recursive = FALSE)
  for(ii in 1:length(y)) {
    if(isTRUE(names(y)[ii] == "computeroutput")) {
      y[[ii]] <- paste0("`", y[[ii]], "`")
    }
  }
  do.call(paste0, y)
}

# parse detaileddescription node
parse_descr <- function(x) {
  descr <- xml_children(x)
  list(title = xml_text(descr[1]),
       descr = parse_para(descr[2]))
}

# ok now pick out one of the functions (i.e., methods)
members <- xml_find_all(compound, "sectiondef/memberdef")
ifun <- which(xml_attr(members, attr = "kind") %in% "function")
fun <- members[sample(ifun, 1)]
# name
fname <- xml_extract(fun, "name")
# full name (definition)
fdef <- xml_extract(fun, "definition")
# template parameter list
ftemp <- xml_text(xml_children(xml_find_all(fun, "templateparamlist")),
                  trim = TRUE)
# return type
ftype <- xml_extract(fun, "type")
# argument list
fargs <- xml_extract(fun, "argsstring")
list(name = fname, def = fdef, template = ftemp, rtype = ftype, args = fargs)

# parameter documentation
fpar <- xml_find_all(fun, "detaileddescription")
fpar <- xml_children(xml_find_all(fpar, ".//parameterlist"))
list(names = xml_extract(fpar, ".//parametername"),

fdoc <- list(brief = xml_extract(fun, "briefdescription"),
             detailed = xml_extract(fun, "detaileddescription"))
