import LINKER

#if canImport(JavaScriptKit) && arch(wasm32)
import JavaScriptKit

struct DOMEventBridge {
    static func setup(runtime: LinkerRuntime<GameState>) {
        setupClickHandler(runtime: runtime)
        setupKeyboardHandler(runtime: runtime)
    }

    private static func setupClickHandler(runtime: LinkerRuntime<GameState>) {
        runtime.dom.addEventListener(elementId: "app", event: "click") { event in
            guard let target = event.target.object else { return }
            let element = findActionElement(from: target)
            guard let actionAttr = element?.getAttribute?("data-action").string else { return }

            let state = runtime.getState()

            switch actionAttr {
            case "square-click":
                let row = element?.getAttribute?("data-row").string
                let col = element?.getAttribute?("data-col").string
                if let coords = EventParser.parseSquareClick(row: row, col: col) {
                    let action = EventWiring.actionForSquareClick(
                        row: coords.row, col: coords.col, state: state
                    )
                    runtime.dispatch(action)
                }
            default:
                if let buttonAction = EventParser.parseButtonAction(actionAttr) {
                    if let action = EventWiring.actionForButton(buttonAction) {
                        runtime.dispatch(action)
                    } else {
                        let inputValues = readInputValues()
                        if let p2pAction = EventWiring.p2pActionForButton(buttonAction, state: state, inputValues: inputValues) {
                            runtime.dispatch(p2pAction)
                        }
                    }
                }
            }
        }
    }

    private static func setupKeyboardHandler(runtime: LinkerRuntime<GameState>) {
        runtime.dom.addEventListener(elementId: "app", event: "keydown") { event in
            guard let key = event.key.string else { return }

            if key == "Enter" || key == " " {
                let state = runtime.getState()
                if let action = EventWiring.actionForEnter(state: state) {
                    runtime.dispatch(action)
                }
                return
            }

            if let action = EventWiring.actionForKey(key) {
                runtime.dispatch(action)
            }
        }
    }

    private static func findActionElement(from target: JSObject) -> JSObject? {
        var current: JSObject? = target
        for _ in 0..<5 {
            guard let el = current else { return nil }
            if el.getAttribute?("data-action").string != nil {
                return el
            }
            current = el.parentElement.object
        }
        return nil
    }

    private static func readInputValues() -> [String: String] {
        var values: [String: String] = [:]
        let document = JSObject.global.document
        let inputs = document.querySelectorAll("[data-input]")
        let count = Int(inputs.length.number ?? 0)
        for i in 0..<count {
            if let el = inputs.item(i).object,
               let key = el.getAttribute?("data-input").string,
               let val = el.value.string {
                values[key] = val
            }
        }
        return values
    }
}

#else

struct DOMEventBridge {
    static func setup(runtime: Any) {}
}

#endif
