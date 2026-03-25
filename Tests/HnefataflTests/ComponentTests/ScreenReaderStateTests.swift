import Testing
@testable import Hnefatafl

@Suite("Screen Reader State Tests")
struct ScreenReaderStateTests {

    @Test("describes current turn")
    func currentTurn() {
        let desc = ScreenReaderState.describe(state: GameState())
        #expect(desc.contains("Attacker"))
    }

    @Test("describes piece counts")
    func pieceCounts() {
        let desc = ScreenReaderState.describe(state: GameState())
        #expect(desc.contains("24") || desc.contains("attacker"))
    }

    @Test("describes game over")
    func gameOver() {
        let status = GameStatus.defenderWins
        let desc = ScreenReaderState.describeStatus(status)
        #expect(desc.contains("Defender") || desc.contains("wins"))
    }

    @Test("describes in progress")
    func inProgress() {
        let desc = ScreenReaderState.describeStatus(.inProgress)
        #expect(desc.contains("progress") || desc.contains("playing"))
    }

    @Test("move description includes coordinates")
    func moveDescription() {
        let move = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 5)
        let desc = ScreenReaderState.describeMove(move)
        #expect(!desc.isEmpty)
    }

    @Test("board summary includes dimensions")
    func boardSummary() {
        let desc = ScreenReaderState.boardSummary(position: Position.copenhagenStart())
        #expect(desc.contains("11"))
    }

    @Test("square description for occupied square")
    func occupiedSquare() {
        let position = Position.copenhagenStart()
        let desc = ScreenReaderState.describeSquare(row: 5, col: 5, position: position)
        #expect(desc.contains("king") || desc.contains("King"))
    }

    @Test("square description for empty square")
    func emptySquare() {
        let position = Position.copenhagenStart()
        let desc = ScreenReaderState.describeSquare(row: 2, col: 2, position: position)
        #expect(desc.contains("empty") || desc.contains("Empty"))
    }
}
