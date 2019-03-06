# generate doxydoc provided in this package

require(rdoxygen)

doxy_init()
doxy_edit(options = c(INPUT = "vignettes/"))
doxy(vignette = FALSE)
vname <- "create_and_delete_me.Rmd"
doxy_vignette(viname = vname)
# assuming we're in subdirectory of rdoxygen
file.remove(file.path(rdoxygen:::find_root(), "vignettes", vname))

