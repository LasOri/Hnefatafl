import Testing
@testable import Hnefatafl

@Suite("Share Game Tests")
struct ShareGameTests {

    @Test("title is Hnefatafl Game")
    func titleIsCorrect() {
        let data = ShareGame.shareData(moves: [], status: .inProgress)
        #expect(data.title == "Hnefatafl Game")
    }

    @Test("attacker win text")
    func attackerWinText() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)]
        let data = ShareGame.shareData(moves: moves, status: .attackerWins)
        #expect(data.text.contains("Attackers won"))
    }

    @Test("defender win text")
    func defenderWinText() {
        let moves = [Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3)]
        let data = ShareGame.shareData(moves: moves, status: .defenderWins)
        #expect(data.text.contains("Defenders won"))
    }

    @Test("move count is preserved")
    func moveCountPreserved() {
        let moves = [
            Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3),
            Move(fromRow: 3, fromCol: 5, toRow: 3, toCol: 8)
        ]
        let data = ShareGame.shareData(moves: moves, status: .inProgress)
        #expect(data.moveCount == 2)
    }

    @Test("in progress text")
    func inProgressText() {
        let data = ShareGame.shareData(moves: [], status: .inProgress)
        #expect(data.text.contains("In progress"))
    }
}
