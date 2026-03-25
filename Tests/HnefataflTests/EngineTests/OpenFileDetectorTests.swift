import Testing
@testable import Hnefatafl

@Suite("OpenFileDetector Tests")
struct OpenFileDetectorTests {
    @Test("Open files on empty board with king")
    func emptyBoardOpenFiles() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let files = OpenFileDetector.openFiles(position: position)
        #expect(files.count == Position.boardSize)
    }

    @Test("Open file count matches array length")
    func countMatchesArray() {
        let position = Position.copenhagenStart()
        let files = OpenFileDetector.openFiles(position: position)
        let count = OpenFileDetector.openFileCount(position: position)
        #expect(count == files.count)
    }

    @Test("Blocked column not in open files")
    func blockedColumnNotOpen() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .placing(.attacker, row: 10, col: 5)
            .build()
        let files = OpenFileDetector.openFiles(position: position)
        #expect(!files.contains(5))
    }

    @Test("No king returns empty")
    func noKingReturnsEmpty() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .build()
        #expect(OpenFileDetector.openFiles(position: position).isEmpty)
        #expect(OpenFileDetector.openFileCount(position: position) == 0)
    }

    @Test("Half-blocked column still open")
    func halfBlockedStillOpen() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 3, col: 5)
            .build()
        let files = OpenFileDetector.openFiles(position: position)
        #expect(files.contains(5))
    }

    @Test("Copenhagen start has limited open files")
    func copenhagenOpenFiles() {
        let position = Position.copenhagenStart()
        let count = OpenFileDetector.openFileCount(position: position)
        #expect(count >= 0)
        #expect(count <= Position.boardSize)
    }
}
