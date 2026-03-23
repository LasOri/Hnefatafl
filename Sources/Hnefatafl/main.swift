import Foundation
import LINKER

#if canImport(JavaScriptKit) && arch(wasm32)
import JavaScriptKit
import JavaScriptEventLoop

JavaScriptEventLoop.installGlobalExecutor()

print("[swift] Hnefatafl - Viking Board Game")
print("[swift] Built with LINKER Framework")

Task {
    await App.main()
}

#else
print("Hnefatafl - Native mode (no WASM)")
#endif
