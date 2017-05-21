#include <Rdefines.h>
#include <R_ext/Rdynload.h>
#include <R_ext/Visibility.h>
#include "foo.h"

static R_NativePrimitiveArgType bar_types[2] = {REALSXP, INTSXP};

static R_CMethodDef cMethods[] = {
    {"bar", (DL_FUNC) &bar, 2, bar_types},
    {NULL, NULL, 0, NULL}
};
 
void attribute_visible R_init_rdoxygen(DllInfo *info)
{
    R_registerRoutines(info, cMethods, NULL, NULL, NULL);
    R_useDynamicSymbols(info, FALSE);
    R_forceSymbols(info, TRUE);
}

