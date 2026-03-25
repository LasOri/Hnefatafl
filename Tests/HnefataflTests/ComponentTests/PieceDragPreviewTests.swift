import Testing
@testable import Hnefatafl

@Suite("PieceDragPreview Tests")
struct PieceDragPreviewTests {
    @Test("Creates drag preview")
    func createPreview() {
        let preview = DragPreview(piece: .king, x: 100.0, y: 200.0, opacity: 0.8)
        #expect(preview.piece == .king)
        #expect(preview.x == 100.0)
        #expect(preview.y == 200.0)
        #expect(preview.opacity == 0.8)
    }

    @Test("Generates CSS style")
    func cssStyle() {
        let preview = DragPreview(piece: .attacker, x: 50.0, y: 75.0, opacity: 0.7)
        let style = preview.cssStyle
        #expect(style.contains("50.0"))
        #expect(style.contains("75.0"))
        #expect(style.contains("0.7"))
    }

    @Test("Is visible when opacity above zero")
    func isVisibleWhenOpaque() {
        let preview = DragPreview(piece: .defender, x: 0.0, y: 0.0, opacity: 0.5)
        #expect(preview.isVisible == true)
    }

    @Test("Is not visible when opacity is zero")
    func notVisibleWhenTransparent() {
        let preview = DragPreview(piece: .king, x: 0.0, y: 0.0, opacity: 0.0)
        #expect(preview.isVisible == false)
    }

    @Test("Preview with full opacity")
    func fullOpacity() {
        let preview = DragPreview(piece: .attacker, x: 10.0, y: 20.0, opacity: 1.0)
        #expect(preview.isVisible == true)
        #expect(preview.cssStyle.contains("1.0"))
    }

    @Test("Preview equality")
    func previewEquality() {
        let preview1 = DragPreview(piece: .king, x: 100.0, y: 100.0, opacity: 0.9)
        let preview2 = DragPreview(piece: .king, x: 100.0, y: 100.0, opacity: 0.9)
        #expect(preview1 == preview2)
    }
}
