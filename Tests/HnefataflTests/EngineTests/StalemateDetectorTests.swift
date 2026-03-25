import Testing
@testable import Hnefatafl

@Suite("Stalemate Detector Tests")
struct StalemateDetectorTests {

    @Test("empty board is near stalemate for attacker")
    func emptyBoardNearStalemate() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(StalemateDetector.isNearStalemate(position: pos, player: .attacker) == true)
    }

    @Test("start position is not near stalemate")
    func startPositionNotNear() {
        let pos = Position.copenhagenStart()
        #expect(StalemateDetector.isNearStalemate(position: pos, player: .attacker) == false)
    }

    @Test("empty board has max stalemate risk")
    func emptyBoardMaxRisk() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        #expect(StalemateDetector.stalemateRisk(position: pos) == 100)
    }

    @Test("start position has zero risk")
    func startPositionZeroRisk() {
        let pos = Position.copenhagenStart()
        #expect(StalemateDetector.stalemateRisk(position: pos) == 0)
    }

    @Test("single piece has limited mobility")
    func singlePieceLimited() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let pos = Position(cells: cells)
        let nearStalemate = StalemateDetector.isNearStalemate(position: pos, player: .defender)
        #expect(nearStalemate == true)
    }

    @Test("risk value is in 0-100 range")
    func riskInRange() {
        let pos = Position.copenhagenStart()
        let risk = StalemateDetector.stalemateRisk(position: pos)
        #expect(risk >= 0 && risk <= 100)
    }
}
