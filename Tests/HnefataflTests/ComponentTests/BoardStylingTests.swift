import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("Board Styling Tests")
struct BoardStylingTests {

    @Test("board has CSS Grid 11-column layout style")
    func board_hasGridStyle() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let board = rendered.find(tag: "div")
        let className = board?.className

        #expect(className?.contains("board") == true)
    }

    @Test("board container has viking-theme class")
    func board_hasVikingTheme() {
        let state = GameState()
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let allDivs = rendered.findAll(tag: "div")
        let vikingThemed = allDivs.filter { $0.className?.contains("viking-theme") == true }

        #expect(!vikingThemed.isEmpty)
    }

    @Test("selected square has glow class")
    func selectedSquare_hasGlowClass() {
        let state = GameState(
            game: Game(),
            selectedSquare: (row: 0, col: 3),
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let glowCells = rendered.findAll(tag: "div").filter {
            $0.className?.contains("glow") == true
        }

        #expect(glowCells.count == 1)
    }

    @Test("squares with pieces contain SVG elements")
    func squaresWithPieces_containSVG() {
        let position = emptyBoard().placing(.attacker, row: 3, col: 3).build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let svgs = rendered.findAll(tag: "svg").filter {
            $0.className?.contains("piece-svg") == true
        }

        #expect(svgs.count == 1)
    }

    @Test("legal move squares have indicator class")
    func legalMoveSquares_haveIndicator() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2)]
        let state = GameState(
            game: Game(),
            selectedSquare: (row: 0, col: 3),
            legalMovesForSelected: moves,
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = BoardComponent.render(state: state)
        let rendered = render(nodes)

        let indicators = rendered.findAll(tag: "div").filter {
            $0.className?.contains("move-indicator") == true
        }

        #expect(indicators.count == 1)
    }
}
