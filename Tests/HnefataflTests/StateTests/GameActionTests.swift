import Testing
import LINKER
@testable import Hnefatafl

@Suite("GameAction Tests")
struct GameActionTests {

    @Test("GameAction conforms to Action protocol")
    func actions_conformToAction() {
        let action: any Action = GameAction.newGame
        #expect(action is GameAction)
    }

    @Test("selectSquare action carries row and col")
    func selectSquare_carriesCoordinates() {
        let action = GameAction.selectSquare(row: 3, col: 5)
        if case .selectSquare(let row, let col) = action {
            #expect(row == 3)
            #expect(col == 5)
        } else {
            Issue.record("Expected selectSquare")
        }
    }

    @Test("makeMove action carries a Move")
    func makeMove_carriesMove() {
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let action = GameAction.makeMove(move)
        if case .makeMove(let m) = action {
            #expect(m.toCol == 5)
        } else {
            Issue.record("Expected makeMove")
        }
    }
}
