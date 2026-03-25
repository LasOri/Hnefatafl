import Testing
@testable import Hnefatafl

@Suite("Confinement Score Tests")
struct ConfinementScoreTests {

    @Test("king only with no blockers has lower confinement than start")
    func kingAloneLowerThanStart() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let alonePos = Position(cells: cells)
        let aloneLevel = ConfinementScore.confinementLevel(position: alonePos)
        let startLevel = ConfinementScore.confinementLevel(position: Position.copenhagenStart())
        #expect(aloneLevel < startLevel)
    }

    @Test("reachable squares positive for king with moves")
    func reachablePositive() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let pos = Position(cells: cells)
        let reachable = ConfinementScore.reachableSquares(position: pos)
        #expect(reachable > 1)
    }

    @Test("no king returns zero reachable")
    func noKingZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(ConfinementScore.reachableSquares(position: pos) == 0)
    }

    @Test("no king gives maximum confinement")
    func noKingMaxConfinement() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(ConfinementScore.confinementLevel(position: pos) == 100)
    }

    @Test("confinement level clamped between 0 and 100")
    func clampedRange() {
        let pos = Position.copenhagenStart()
        let level = ConfinementScore.confinementLevel(position: pos)
        #expect(level >= 0)
        #expect(level <= 100)
    }

    @Test("start position king has some reachable squares")
    func startPositionReachable() {
        let pos = Position.copenhagenStart()
        let reachable = ConfinementScore.reachableSquares(position: pos)
        #expect(reachable >= 1)
    }
}
