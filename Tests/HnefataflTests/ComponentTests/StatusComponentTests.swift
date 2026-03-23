import Testing
import LINKER
import LINKERTesting
@testable import Hnefatafl

@Suite("StatusComponent Tests")
struct StatusComponentTests {

    @Test("shows current player turn")
    func render_showsCurrentPlayer() {
        let state = GameState()
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let turnText = rendered.findByText("Attacker's turn")

        #expect(turnText != nil)
    }

    @Test("shows defender turn after move")
    func render_afterMove_showsDefenderTurn() {
        let game = Game()
        let moves = game.position.allLegalMoves(for: .attacker)
        let moved = game.makeMove(moves[0])
        let state = GameState(
            game: moved,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let turnText = rendered.findByText("Defender's turn")

        #expect(turnText != nil)
    }

    @Test("shows game result on defender win")
    func render_defenderWins_showsResult() {
        let position = emptyBoard().placing(.king, row: 0, col: 0).build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 0,
            defendersCaptured: 0
        )
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let result = rendered.findByText("Defenders win!")

        #expect(result != nil)
    }

    @Test("shows captured piece counts")
    func render_showsCapturedCounts() {
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: 3,
            defendersCaptured: 1
        )
        let nodes = StatusComponent.render(state: state)
        let rendered = render(nodes)

        let attackerCount = rendered.findByText("3")
        let defenderCount = rendered.findByText("1")

        #expect(attackerCount != nil)
        #expect(defenderCount != nil)
    }
}
