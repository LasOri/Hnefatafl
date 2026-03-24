import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("Notation Panel Tests")
struct NotationPanelTests {

    @Test("renders empty state with no moves")
    func emptyState() {
        let nodes = NotationPanel.render(moves: [], currentStep: nil)
        let rendered = render(nodes)
        let panel = rendered.findAll(tag: "div").first(where: { $0.className?.contains("notation-panel") == true })
        #expect(panel != nil)
    }

    @Test("renders move entries")
    func rendersMoves() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3),
            Move(fromRow: 5, fromCol: 3, toRow: 2, toCol: 3),
        ]
        let nodes = NotationPanel.render(moves: moves, currentStep: nil)
        let rendered = render(nodes)
        let items = rendered.findAll(tag: "span").filter { $0.className?.contains("notation-move") == true }
        #expect(items.count == 2)
    }

    @Test("numbers move pairs")
    func numbersPairs() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3),
            Move(fromRow: 5, fromCol: 3, toRow: 2, toCol: 3),
        ]
        let nodes = NotationPanel.render(moves: moves, currentStep: nil)
        let rendered = render(nodes)
        let number = rendered.findByText("1.")
        #expect(number != nil)
    }

    @Test("highlights current step")
    func highlightsCurrent() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3),
            Move(fromRow: 5, fromCol: 3, toRow: 2, toCol: 3),
        ]
        let nodes = NotationPanel.render(moves: moves, currentStep: 0)
        let rendered = render(nodes)
        let active = rendered.findAll(tag: "span").first(where: { $0.className?.contains("notation-active") == true })
        #expect(active != nil)
    }

    @Test("no highlight when currentStep is nil")
    func noHighlight() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3)]
        let nodes = NotationPanel.render(moves: moves, currentStep: nil)
        let rendered = render(nodes)
        let active = rendered.findAll(tag: "span").first(where: { $0.className?.contains("notation-active") == true })
        #expect(active == nil)
    }

    @Test("move entries have data-step attribute")
    func dataStepAttribute() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3)]
        let nodes = NotationPanel.render(moves: moves, currentStep: nil)
        let rendered = render(nodes)
        let entry = rendered.findAll(tag: "span").first(where: { $0.className?.contains("notation-move") == true })
        #expect(entry?.attr("data-step") == "0")
    }

    @Test("uses algebraic notation format")
    func algebraicFormat() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 3, toCol: 3)]
        let nodes = NotationPanel.render(moves: moves, currentStep: nil)
        let rendered = render(nodes)
        let text = rendered.findByText("D1-D4")
        #expect(text != nil)
    }

    @Test("panel has scrollable container")
    func scrollable() {
        let nodes = NotationPanel.render(moves: [], currentStep: nil)
        let rendered = render(nodes)
        let panel = rendered.findAll(tag: "div").first(where: { $0.className?.contains("notation-panel") == true })
        #expect(panel != nil)
    }
}
