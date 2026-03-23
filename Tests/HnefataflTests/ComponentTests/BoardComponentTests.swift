import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("BoardComponent Tests")
struct BoardComponentTests {

    @Test("renders 11x11 grid with 121 cells")
    func render_has121Cells() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let cells = rendered.findAll(tag: "div").filter { $0.className?.contains("square") == true }

        #expect(cells.count == 121)
    }

    @Test("renders 11 rows")
    func render_has11Rows() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let rows = rendered.findAll(tag: "div").filter { $0.className?.contains("board-row") == true }

        #expect(rows.count == 11)
    }

    @Test("attacker piece has attacker class")
    func render_attackerPiece_hasAttackerClass() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let attackerSquare = rendered.find(attribute: "data-row", value: "0")
        let attackerCells = rendered.findAll(tag: "div").filter {
            $0.className?.contains("piece-attacker") == true
        }

        #expect(!attackerCells.isEmpty)
    }

    @Test("king piece has king class")
    func render_kingPiece_hasKingClass() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let kingCells = rendered.findAll(tag: "div").filter {
            $0.className?.contains("piece-king") == true
        }

        #expect(kingCells.count == 1)
    }

    @Test("corner squares have corner class")
    func render_cornerSquares_haveCornerClass() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let cornerCells = rendered.findAll(tag: "div").filter {
            $0.className?.contains("square-corner") == true
        }

        #expect(cornerCells.count == 4)
    }

    @Test("throne square has throne class")
    func render_throneSquare_hasThroneClass() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let throneCells = rendered.findAll(tag: "div").filter {
            $0.className?.contains("square-throne") == true
        }

        #expect(throneCells.count == 1)
    }

    @Test("selected square has selected class")
    func render_selectedSquare_hasSelectedClass() {
        let state = GameState(
            game: Game(),
            selectedSquare: (row: 0, col: 3),
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let selectedCells = rendered.findAll(tag: "div").filter {
            $0.className?.contains("selected") == true
        }

        #expect(selectedCells.count == 1)
    }

    @Test("legal move squares have legal-move class")
    func render_legalMoves_haveLegalMoveClass() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2),
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 1)
        ]
        let state = GameState(
            game: Game(),
            selectedSquare: (row: 0, col: 3),
            legalMovesForSelected: moves,
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let legalMoveCells = rendered.findAll(tag: "div").filter {
            $0.className?.contains("legal-move") == true
        }

        #expect(legalMoveCells.count == 2)
    }
}
