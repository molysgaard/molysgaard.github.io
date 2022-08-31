#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

/**
 * `factorize_general` factorizes a sparse, square, MxM, symmetric matrix into a {L D L^T} format.
 *
 * # Arguments
 *
 * * `m`: the size of the input matrix: `m` x `m`
 * * `n_el`: the number of non-zero elements in the matrix.
 * * `is`: A pointer to a contigous memory buffer of row positions for each matrix element. The pointer must point to a memory area that contains `n_el` elements.
 * * `js`: A pointer to a contigous memory buffer of column positions for each matrix element. The pointer must point to a memory area that contains `n_el` elements.
 * * `xs`: A pointer to a contigous memory buffer of values for each matrix element. The pointer must point to a memory area that contains `n_el` elements.
 *
 * # Returns
 * `*void` to an abstract LDLt factorization struct.
 * The caller must take ownership of this pointer.
 * The pointer is used in the `solve` function.
 * When a factorization no longer will be used, the memory associated with it should be released. To release it, the pointer needs to be given to the `deallocate` function.
 */
const void *factorize_general(uintptr_t m,
                              uintptr_t n_el,
                              const uintptr_t *is,
                              const uintptr_t *js,
                              const double *xs);

/**
 * # Arguments
 * * `ptr` `void*` to LDLt-factorization. This pointer can only be created by calling `factorize`. It is the return value of `factorize`.
 * * `b` a pointer to a memory area containing the values for the right hand side in the equation `Ax=b`
 * * `x` output pointer. Must point to an (potentially unallocated) area of memory of length `sizeof(double)*M`, where `M` is the size of the original square matrix `MxM`.
 */
void solve(const void *ptr,
           const double *b,
           double *x);

/**
 * The `LDL^T` factorization created by `factorize` allocates memory to store the `LDL^T` factors.
 * When there is no more use for a factorization, the allocated memory should be freed.
 * If the memory is not freed, the calling program will leak memory.
 *
 * # Arguments
 * * `ptr` `void*` to LDLt-factorization. This pointer can only be created by calling `factorize`. It is the return value of `factorize`.
 */
void deallocate(void *ptr);
