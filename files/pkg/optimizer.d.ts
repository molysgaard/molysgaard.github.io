/* tslint:disable */
/* eslint-disable */
/**
* @returns {number}
*/
export function n_vars(): number;
/**
* @returns {number}
*/
export function n_eq(): number;
/**
* @returns {number}
*/
export function n_ineq(): number;
/**
* @returns {number}
*/
export function n_params(): number;
/**
* @returns {number}
*/
export function n_lams(): number;
/**
* @param {number} xtol
* @param {number} gtol
* @param {number} maxiter
* @param {Float64Array} params_ptr
* @param {Float64Array} x0_ptr
* @param {Float64Array} x_out_ptr
* @param {Float64Array} lam_out_ptr
* @param {number} alpha
* @param {number} beta
* @param {number} gamma
* @param {number} xi
* @param {number} run_id
* @returns {string}
*/
export function optimize(xtol: number, gtol: number, maxiter: number, params_ptr: Float64Array, x0_ptr: Float64Array, x_out_ptr: Float64Array, lam_out_ptr: Float64Array, alpha: number, beta: number, gamma: number, xi: number, run_id: number): string;
/**
* @param {number} xtol
* @param {number} gtol
* @param {number} maxiter
* @param {Float64Array} params_ptr
* @param {Float64Array} x0_ptr
* @param {Float64Array} x_out_ptr
* @param {Float64Array} lam_out_ptr
* @param {number} alpha
* @param {number} beta
* @param {number} gamma
* @param {number} xi
* @param {number} timeout
* @param {number} run_id
* @returns {string}
*/
export function optimize_with_timeout(xtol: number, gtol: number, maxiter: number, params_ptr: Float64Array, x0_ptr: Float64Array, x_out_ptr: Float64Array, lam_out_ptr: Float64Array, alpha: number, beta: number, gamma: number, xi: number, timeout: number, run_id: number): string;

export type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

export interface InitOutput {
  readonly memory: WebAssembly.Memory;
  readonly n_vars: () => number;
  readonly n_eq: () => number;
  readonly n_ineq: () => number;
  readonly n_params: () => number;
  readonly n_lams: () => number;
  readonly optimize: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number, j: number, k: number, l: number, m: number, n: number, o: number, p: number, q: number) => void;
  readonly optimize_with_timeout: (a: number, b: number, c: number, d: number, e: number, f: number, g: number, h: number, i: number, j: number, k: number, l: number, m: number, n: number, o: number, p: number, q: number, r: number) => void;
  readonly __wbindgen_malloc: (a: number) => number;
  readonly __wbindgen_realloc: (a: number, b: number, c: number) => number;
  readonly __wbindgen_add_to_stack_pointer: (a: number) => number;
  readonly __wbindgen_free: (a: number, b: number) => void;
  readonly __wbindgen_exn_store: (a: number) => void;
}

/**
* Synchronously compiles the given `bytes` and instantiates the WebAssembly module.
*
* @param {BufferSource} bytes
*
* @returns {InitOutput}
*/
export function initSync(bytes: BufferSource): InitOutput;

/**
* If `module_or_path` is {RequestInfo} or {URL}, makes a request and
* for everything else, calls `WebAssembly.instantiate` directly.
*
* @param {InitInput | Promise<InitInput>} module_or_path
*
* @returns {Promise<InitOutput>}
*/
export default function init (module_or_path?: InitInput | Promise<InitInput>): Promise<InitOutput>;
