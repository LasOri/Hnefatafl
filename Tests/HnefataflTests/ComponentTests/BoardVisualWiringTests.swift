import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("Board Visual Wiring Tests")
struct BoardVisualWiringTests {

    @Test("no move-trail SVG when lastMove is nil")
    func noMoveTrailWhenNil() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let trails = rendered.findAll(tag: "svg").filter { $0.className?.contains("move-trail") == true }
        #expect(trails.isEmpty)
    }

    @Test("renders move-trail SVG when lastMove exists")
    func moveTrailWhenLastMoveSet() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            lastMove: move
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let trails = rendered.findAll(tag: "svg").filter { $0.className?.contains("move-trail") == true }
        #expect(trails.count == 1)
    }

    @Test("move-trail SVG contains line element")
    func moveTrailContainsLine() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            lastMove: move
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let trails = rendered.findAll(tag: "svg").filter { $0.className?.contains("move-trail") == true }
        let trail = trails.first
        #expect(trail != nil)
        let line = trail?.find(tag: "line")
        #expect(line != nil)
    }

    @Test("no capture-effect when capturedSquares is empty")
    func noCaptureEffectWhenEmpty() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let effects = rendered.findAll(tag: "div").filter { $0.className?.contains("capture-effect") == true }
        #expect(effects.isEmpty)
    }

    @Test("renders capture-effect for each captured square")
    func captureEffectPerSquare() {
        let game = Game()
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            capturedSquares: [(row: 3, col: 4), (row: 5, col: 6)]
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let effects = rendered.findAll(tag: "div").filter { $0.className?.contains("capture-effect") == true }
        #expect(effects.count == 2)
    }

    @Test("capture-effect has correct data-row and data-col")
    func captureEffectCorrectAttributes() {
        let game = Game()
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            capturedSquares: [(row: 3, col: 7)]
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let effects = rendered.findAll(tag: "div").filter { $0.className?.contains("capture-effect") == true }
        #expect(effects.first?.attr("data-row") == "3")
        #expect(effects.first?.attr("data-col") == "7")
    }

    @Test("both move-trail and capture-effects render together")
    func bothRenderTogether() {
        let game = Game()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            lastMove: move,
            capturedSquares: [(row: 1, col: 3)]
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let trails = rendered.findAll(tag: "svg").filter { $0.className?.contains("move-trail") == true }
        let effects = rendered.findAll(tag: "div").filter { $0.className?.contains("capture-effect") == true }
        #expect(trails.count == 1)
        #expect(effects.count == 1)
    }

    @Test("capture-effect particles are rendered")
    func captureEffectHasParticles() {
        let game = Game()
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            capturedSquares: [(row: 2, col: 4)]
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)
        let particles = rendered.findAll(tag: "div").filter { $0.className?.contains("particle") == true }
        #expect(!particles.isEmpty)
    }
}
