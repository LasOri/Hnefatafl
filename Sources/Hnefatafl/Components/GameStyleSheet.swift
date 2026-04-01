import LINKER

struct GameStyleSheet {
    /// Full Viking design system CSS — replaces old inline styles
    static let css = VikingStyleSheet.css

    static func render() -> [AnyNode] {
        VikingStyleSheet.render()
    }
}
