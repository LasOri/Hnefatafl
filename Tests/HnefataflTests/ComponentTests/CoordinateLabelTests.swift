import Testing
@testable import Hnefatafl
import LINKER
import LINKERTesting

@Suite("Coordinate Label Tests")
struct CoordinateLabelTests {

    @Test("board renders column labels A through K")
    func columnLabels() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let labels = rendered.findAll(tag: "span").filter { $0.className?.contains("coord-label") == true }
        let texts = labels.map { $0.text ?? "" }
        for letter in ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"] {
            #expect(texts.contains(letter))
        }
    }

    @Test("board renders row labels 1 through 11")
    func rowLabels() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let labels = rendered.findAll(tag: "span").filter { $0.className?.contains("coord-label") == true }
        let texts = labels.map { $0.text ?? "" }
        for num in 1...11 {
            #expect(texts.contains("\(num)"))
        }
    }

    @Test("labels have coord-label class")
    func labelsHaveClass() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let labels = rendered.findAll(tag: "span").filter { $0.className?.contains("coord-label") == true }
        #expect(labels.count >= 22)
    }

    @Test("CSS contains coord-label rule")
    func cssContainsCoordLabelRule() {
        #expect(GameStyleSheet.css.contains(".coord-label"))
    }
}
