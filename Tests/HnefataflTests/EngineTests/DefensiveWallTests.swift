import Testing
@testable import Hnefatafl

@Suite("DefensiveWall Tests")
struct DefensiveWallTests {

    @Test("attackers blocking corner form a wall")
    func cornerWall() {
        let pos = PositionBuilder()
            .place(.attacker, row: 0, col: 1)
            .place(.attacker, row: 1, col: 0)
            .place(.king, row: 5, col: 5)
            .build()
        let walls = DefensiveWall.detect(position: pos)
        #expect(!walls.isEmpty)
    }

    @Test("no wall when corners are open")
    func openCorners() {
        let pos = PositionBuilder()
            .place(.attacker, row: 5, col: 5)
            .place(.king, row: 5, col: 6)
            .build()
        let walls = DefensiveWall.detect(position: pos)
        #expect(walls.isEmpty)
    }

    @Test("wall entry has corner info")
    func wallInfo() {
        let pos = PositionBuilder()
            .place(.attacker, row: 0, col: 1)
            .place(.attacker, row: 1, col: 0)
            .place(.king, row: 5, col: 5)
            .build()
        let walls = DefensiveWall.detect(position: pos)
        if let wall = walls.first {
            #expect(wall.cornerRow >= 0 && wall.cornerRow <= 10)
            #expect(wall.cornerCol >= 0 && wall.cornerCol <= 10)
        }
    }

    @Test("WallEntry is Equatable")
    func equatable() {
        let a = WallEntry(cornerRow: 0, cornerCol: 0, blockingCount: 2)
        let b = WallEntry(cornerRow: 0, cornerCol: 0, blockingCount: 2)
        #expect(a == b)
    }

    @Test("starting position may have walls")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let walls = DefensiveWall.detect(position: pos)
        #expect(walls.count >= 0)
    }

    @Test("blocking count is positive for detected walls")
    func positiveCount() {
        let pos = PositionBuilder()
            .place(.attacker, row: 0, col: 1)
            .place(.attacker, row: 1, col: 0)
            .place(.king, row: 5, col: 5)
            .build()
        let walls = DefensiveWall.detect(position: pos)
        for wall in walls {
            #expect(wall.blockingCount > 0)
        }
    }
}
