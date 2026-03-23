import Foundation
import LINKER

#if canImport(JavaScriptKit) && arch(wasm32)
import JavaScriptKit
import JavaScriptEventLoop

JavaScriptEventLoop.installGlobalExecutor()

let store = createGameStore()
let runtime = LinkerRuntime(store: store, rootElementId: "app")
runtime.setNodeRender(PageRenderer.renderForStore())

DOMEventBridge.setup(runtime: runtime)

#else
print("Hnefatafl - Native mode (no WASM)")
print("Run with swift test to execute the test suite.")
#endif
