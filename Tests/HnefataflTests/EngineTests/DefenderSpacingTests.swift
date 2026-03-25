import Testing
@testable import Hnefatafl

@Suite("DefenderSpacing Tests")
struct DefenderSpacingTests {

    @Test("empty board has zero spacing score")
    func emptyBoardZero() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let score = DefenderSpacing.spacingScore(position: pos)
        #expect(score == 0)
    }

    @Test("no king gives zero spacing score")
    func noKingZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[3 * 11 + 3] = .defender
        cells[7 * 11 + 7] = .defender
        let pos = Position(cells: cells)
        let score = DefenderSpacing.spacingScore(position: pos)
        #expect(score == 0)
    }

    @Test("max gap with no king is 360")
    func noKingMaxGap360() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let gap = DefenderSpacing.maxGap(position: pos)
        #expect(gap == 360)
    }

    @Test("evenly spaced defenders have high score")
    func evenlySpacedHighScore() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[3 * 11 + 5] = .defender
        cells[7 * 11 + 5] = .defender
        cells[5 * 11 + 3] = .defender
        cells[5 * 11 + 7] = .defender
        let pos = Position(cells: cells)
        let score = DefenderSpacing.spacingScore(position: pos)
        #expect(score > 50)
    }

    @Test("clustered defenders have lower score than spread")
    func clusteredLowerThanSpread() {
        var spreadCells: [Piece?] = Array(repeating: nil, count: 121)
        spreadCells[5 * 11 + 5] = .king
        spreadCells[3 * 11 + 5] = .defender
        spreadCells[7 * 11 + 5] = .defender
        spreadCells[5 * 11 + 3] = .defender
        spreadCells[5 * 11 + 7] = .defender
        let spreadPos = Position(cells: spreadCells)

        var clusterCells: [Piece?] = Array(repeating: nil, count: 121)
        clusterCells[5 * 11 + 5] = .king
        clusterCells[4 * 11 + 5] = .defender
        clusterCells[3 * 11 + 5] = .defender
        clusterCells[4 * 11 + 6] = .defender
        clusterCells[3 * 11 + 6] = .defender
        let clusterPos = Position(cells: clusterCells)

        #expect(DefenderSpacing.spacingScore(position: spreadPos) > DefenderSpacing.spacingScore(position: clusterPos))
    }

    @Test("single defender gives zero score")
    func singleDefenderZero() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[4 * 11 + 5] = .defender
        let pos = Position(cells: cells)
        let score = DefenderSpacing.spacingScore(position: pos)
        #expect(score == 0)
    }

    @Test("start position has nonzero spacing score")
    func startPositionNonzero() {
        let pos = Position.copenhagenStart()
        let score = DefenderSpacing.spacingScore(position: pos)
        #expect(score > 0)
    }
}
