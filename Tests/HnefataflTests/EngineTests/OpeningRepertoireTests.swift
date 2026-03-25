import Testing
@testable import Hnefatafl

@Suite("Opening Repertoire Tests")
struct OpeningRepertoireTests {

    @Test("attacker has suggested move at move 1")
    func attackerMove1() {
        let move = OpeningRepertoire.suggestedMove(for: .attacker, moveNumber: 1)
        #expect(move != nil)
    }

    @Test("defender has suggested move at move 2")
    func defenderMove2() {
        let move = OpeningRepertoire.suggestedMove(for: .defender, moveNumber: 2)
        #expect(move != nil)
    }

    @Test("no suggestion for unknown move number")
    func unknownMoveNumber() {
        let move = OpeningRepertoire.suggestedMove(for: .attacker, moveNumber: 999)
        #expect(move == nil)
    }

    @Test("book move is recognized")
    func bookMoveRecognized() {
        let move = OpeningRepertoire.suggestedMove(for: .attacker, moveNumber: 1)!
        #expect(OpeningRepertoire.isBookMove(move: move, player: .attacker) == true)
    }

    @Test("non-book move is not recognized")
    func nonBookMove() {
        let move = Move(fromRow: 9, fromCol: 9, toRow: 8, toCol: 9)
        #expect(OpeningRepertoire.isBookMove(move: move, player: .attacker) == false)
    }

    @Test("defender book move not in attacker book")
    func defenderNotInAttacker() {
        let move = OpeningRepertoire.suggestedMove(for: .defender, moveNumber: 2)!
        #expect(OpeningRepertoire.isBookMove(move: move, player: .attacker) == false)
    }
}
