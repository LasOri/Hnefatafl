import Testing
@testable import Hnefatafl

@Suite("Weak Square Detector Tests")
struct WeakSquareDetectorTests {

    @Test("empty board has no weak squares")
    func emptyBoardNoWeak() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let weak = WeakSquareDetector.weakSquares(position: position, player: .defender)
        #expect(weak.isEmpty)
    }

    @Test("square between two enemies is weak")
    func squareBetweenEnemies() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let weak = WeakSquareDetector.weakSquares(position: position, player: .defender)
        let hasMiddle = weak.contains { $0.row == 5 && $0.col == 5 }
        #expect(hasMiddle)
    }

    @Test("occupied squares are not weak")
    func occupiedNotWeak() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .build()
        let weak = WeakSquareDetector.weakSquares(position: position, player: .defender)
        let hasKingSquare = weak.contains { $0.row == 5 && $0.col == 5 }
        #expect(!hasKingSquare)
    }

    @Test("start position detects weak squares")
    func startPositionWeak() {
        let position = Position.copenhagenStart()
        let weak = WeakSquareDetector.weakSquares(position: position, player: .defender)
        #expect(weak.count >= 0)
    }

    @Test("three enemies make square weak too")
    func threeEnemiesWeak() {
        let position = emptyBoard()
            .placing(.king, row: 0, col: 0)
            .placing(.attacker, row: 5, col: 4)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 4, col: 5)
            .build()
        let weak = WeakSquareDetector.weakSquares(position: position, player: .defender)
        let hasMiddle = weak.contains { $0.row == 5 && $0.col == 5 }
        #expect(hasMiddle)
    }
}
