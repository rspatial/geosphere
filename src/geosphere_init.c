#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP _geodesic(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP _inversegeodesic(SEXP, SEXP, SEXP, SEXP, SEXP, SEXP);
extern SEXP _polygonarea(SEXP, SEXP, SEXP, SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_geodesic",        (DL_FUNC) &_geodesic,        6},
    {"_inversegeodesic", (DL_FUNC) &_inversegeodesic, 6},
    {"_polygonarea",     (DL_FUNC) &_polygonarea,     4},
    {NULL, NULL, 0}
};

void R_init_geosphere(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
