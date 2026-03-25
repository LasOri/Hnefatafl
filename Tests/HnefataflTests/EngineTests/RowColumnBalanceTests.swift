import Testing
@testable import Hnefatafl

@Suite("Row Column Balance Tests")
struct RowColumnBalanceTests {

    @Test("row distribution has 11 entries")
    func rowDistHas11() {
        let position = Position.copenhagenStart()
        let dist = RowColumnBalance.rowDistribution(position: position, player: .attacker)
        #expect(dist.count == 11)
    }

    @Test("col distribution has 11 entries")
    func colDistHas11() {
        let position = Position.copenhagenStart()
        let dist = RowColumnBalance.colDistribution(position: position, player: .attacker)
        #expect(dist.count == 11)
    }

    @Test("row sums match attacker piece count")
    func rowSumsMatchCount() {
        let position = Position.copenhagenStart()
        let dist = RowColumnBalance.rowDistribution(position: position, player: .attacker)
        let sum = dist.reduce(0, +)
        #expect(sum == position.attackerCount)
    }

    @Test("empty board all zeros")
    func emptyBoardAllZeros() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let dist = RowColumnBalance.rowDistribution(position: position, player: .attacker)
        #expect(dist.allSatisfy { $0 == 0 })
    }

    @Test("start position has non-zero distributions")
    func startPositionNonZero() {
        let position = Position.copenhagenStart()
        let rowDist = RowColumnBalance.rowDistribution(position: position, player: .attacker)
        let colDist = RowColumnBalance.colDistribution(position: position, player: .attacker)
        #expect(rowDist.reduce(0, +) > 0)
        #expect(colDist.reduce(0, +) > 0)
    }
}
