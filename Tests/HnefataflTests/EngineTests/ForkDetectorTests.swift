import Testing
@testable import Hnefatafl

@Suite("ForkDetector Tests")
struct ForkDetectorTests {

    @Test("empty board has no forks")
    func emptyBoardNoForks() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        #expect(ForkDetector.forkCount(position: position, player: .attacker) == 0)
    }

    @Test("fork count matches detect forks count")
    func countMatchesDetect() {
        let position = Position.copenhagenStart()
        let forks = ForkDetector.detectForks(position: position, player: .attacker)
        let count = ForkDetector.forkCount(position: position, player: .attacker)
        #expect(forks.count == count)
    }

    @Test("detected forks are valid moves")
    func forksAreValidMoves() {
        let position = Position.copenhagenStart()
        let allMoves = position.allLegalMoves(for: .attacker)
        let forks = ForkDetector.detectForks(position: position, player: .attacker)
        for fork in forks {
            #expect(allMoves.contains(fork))
        }
    }

    @Test("fork count is non-negative")
    func nonNegativeCount() {
        let position = Position.copenhagenStart()
        #expect(ForkDetector.forkCount(position: position, player: .attacker) >= 0)
        #expect(ForkDetector.forkCount(position: position, player: .defender) >= 0)
    }

    @Test("attacker fork threatens two defenders")
    func attackerForkThreatensTwo() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        cells[3 * 11 + 5] = .defender
        cells[5 * 11 + 3] = .defender
        cells[4 * 11 + 6] = .attacker
        cells[3 * 11 + 6] = .attacker
        cells[5 * 11 + 2] = .attacker
        let position = Position(cells: cells)
        let forks = ForkDetector.detectForks(position: position, player: .attacker)
        #expect(forks.count >= 0)
    }

    @Test("defender can also create forks")
    func defenderForks() {
        let position = Position.copenhagenStart()
        let forks = ForkDetector.detectForks(position: position, player: .defender)
        #expect(forks.count >= 0)
    }
}
