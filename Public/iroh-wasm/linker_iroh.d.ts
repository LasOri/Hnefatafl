/* tslint:disable */
/* eslint-disable */
/**
 * The `ReadableStreamType` enum.
 *
 * *This API requires the following crate features to be activated: `ReadableStreamType`*
 */

type ReadableStreamType = "bytes";

export class GameNode {
    private constructor();
    free(): void;
    [Symbol.dispose](): void;
    /**
     * Connect to a remote peer by their endpoint ID.
     */
    connect(peer_id: string, _initial_payload: string): Promise<any>;
    /**
     * Get the local endpoint ID
     */
    endpoint_id(): string;
    /**
     * Register an event callback.
     * Events: { type: "connection"|"data"|"closed"|"error", peerId?, data?, reason? }
     */
    onEvent(callback: Function): void;
    /**
     * Send data to a connected peer
     */
    send(connection_id: string, data: string): void;
    /**
     * Shut down the endpoint and close all connections
     */
    shutdown(): Promise<void>;
    /**
     * Spawn a new Iroh endpoint and return a GameNode instance.
     */
    static spawn(): Promise<GameNode>;
}

export class IntoUnderlyingByteSource {
    private constructor();
    free(): void;
    [Symbol.dispose](): void;
    cancel(): void;
    pull(controller: ReadableByteStreamController): Promise<any>;
    start(controller: ReadableByteStreamController): void;
    readonly autoAllocateChunkSize: number;
    readonly type: ReadableStreamType;
}

export class IntoUnderlyingSink {
    private constructor();
    free(): void;
    [Symbol.dispose](): void;
    abort(reason: any): Promise<any>;
    close(): Promise<any>;
    write(chunk: any): Promise<any>;
}

export class IntoUnderlyingSource {
    private constructor();
    free(): void;
    [Symbol.dispose](): void;
    cancel(): void;
    pull(controller: ReadableStreamDefaultController): Promise<any>;
}

export function start(): void;

export type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

export interface InitOutput {
    readonly memory: WebAssembly.Memory;
    readonly __wbg_gamenode_free: (a: number, b: number) => void;
    readonly gamenode_connect: (a: number, b: number, c: number, d: number, e: number) => number;
    readonly gamenode_endpoint_id: (a: number, b: number) => void;
    readonly gamenode_onEvent: (a: number, b: number) => void;
    readonly gamenode_send: (a: number, b: number, c: number, d: number, e: number, f: number) => void;
    readonly gamenode_shutdown: (a: number) => number;
    readonly gamenode_spawn: () => number;
    readonly start: () => void;
    readonly __wbg_intounderlyingbytesource_free: (a: number, b: number) => void;
    readonly __wbg_intounderlyingsink_free: (a: number, b: number) => void;
    readonly __wbg_intounderlyingsource_free: (a: number, b: number) => void;
    readonly intounderlyingbytesource_autoAllocateChunkSize: (a: number) => number;
    readonly intounderlyingbytesource_cancel: (a: number) => void;
    readonly intounderlyingbytesource_pull: (a: number, b: number) => number;
    readonly intounderlyingbytesource_start: (a: number, b: number) => void;
    readonly intounderlyingbytesource_type: (a: number) => number;
    readonly intounderlyingsink_abort: (a: number, b: number) => number;
    readonly intounderlyingsink_close: (a: number) => number;
    readonly intounderlyingsink_write: (a: number, b: number) => number;
    readonly intounderlyingsource_cancel: (a: number) => void;
    readonly intounderlyingsource_pull: (a: number, b: number) => number;
    readonly ring_core_0_17_14__bn_mul_mont: (a: number, b: number, c: number, d: number, e: number, f: number) => void;
    readonly __wasm_bindgen_func_elem_5278: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_5429: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_5795: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_5820: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_6675: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_14448: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_14511: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_1643: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_14640: (a: number, b: number, c: number, d: number) => void;
    readonly __wasm_bindgen_func_elem_14655: (a: number, b: number, c: number, d: number) => void;
    readonly __wasm_bindgen_func_elem_5503: (a: number, b: number, c: number) => void;
    readonly __wasm_bindgen_func_elem_6720: (a: number, b: number, c: number) => void;
    readonly __wasm_bindgen_func_elem_2092: (a: number, b: number, c: number) => void;
    readonly __wasm_bindgen_func_elem_5287: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_5801: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_5840: (a: number, b: number) => void;
    readonly __wasm_bindgen_func_elem_14465: (a: number, b: number) => void;
    readonly __wbindgen_export: (a: number, b: number) => number;
    readonly __wbindgen_export2: (a: number, b: number, c: number, d: number) => number;
    readonly __wbindgen_export3: (a: number) => void;
    readonly __wbindgen_export4: (a: number, b: number, c: number) => void;
    readonly __wbindgen_add_to_stack_pointer: (a: number) => number;
    readonly __wbindgen_start: () => void;
}

export type SyncInitInput = BufferSource | WebAssembly.Module;

/**
 * Instantiates the given `module`, which can either be bytes or
 * a precompiled `WebAssembly.Module`.
 *
 * @param {{ module: SyncInitInput }} module - Passing `SyncInitInput` directly is deprecated.
 *
 * @returns {InitOutput}
 */
export function initSync(module: { module: SyncInitInput } | SyncInitInput): InitOutput;

/**
 * If `module_or_path` is {RequestInfo} or {URL}, makes a request and
 * for everything else, calls `WebAssembly.instantiate` directly.
 *
 * @param {{ module_or_path: InitInput | Promise<InitInput> }} module_or_path - Passing `InitInput` directly is deprecated.
 *
 * @returns {Promise<InitOutput>}
 */
export default function __wbg_init (module_or_path?: { module_or_path: InitInput | Promise<InitInput> } | InitInput | Promise<InitInput>): Promise<InitOutput>;
