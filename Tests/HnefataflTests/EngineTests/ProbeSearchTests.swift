import Testing
@testable import Hnefatafl

@Suite("ProbeSearch Tests")
struct ProbeSearchTests {

    @Test("probe returns nonzero for start position")
    func probeStartPosition() {
        let pos = Position.copenhagenStart()
        let score = ProbeSearch.probe(position: pos, player: .attacker)
        #expect(score != 0)
    }

    @Test("probe is symmetric: opposite signs for each player")
    func probeSymmetric() {
        let pos = Position.copenhagenStart()
        let attackerScore = ProbeSearch.probe(position: pos, player: .attacker)
        let defenderScore = ProbeSearch.probe(position: pos, player: .defender)
        #expect(attackerScore == -defenderScore)
    }

    @Test("probe returns zero for empty board")
    func probeEmptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let score = ProbeSearch.probe(position: pos, player: .attacker)
        #expect(score == 0)
    }

    @Test("probeWithCaptures >= probe for same position")
    func capturesAtLeastAsGood() {
        let pos = Position.copenhagenStart()
        let basic = ProbeSearch.probe(position: pos, player: .attacker)
        let withCaptures = ProbeSearch.probeWithCaptures(position: pos, player: .attacker)
        #expect(withCaptures >= basic)
    }

    @Test("probeWithCaptures equals probe when no captures exist")
    func noCapturesEqual() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        cells[10] = .king
        let pos = Position(cells: cells)
        let basic = ProbeSearch.probe(position: pos, player: .attacker)
        let withCaptures = ProbeSearch.probeWithCaptures(position: pos, player: .attacker)
        #expect(withCaptures == basic)
    }

    @Test("probe favors defender when king is near corner with material advantage")
    func kingNearCorner() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1] = .king
        cells[5 * 11 + 4] = .defender
        cells[5 * 11 + 6] = .defender
        let pos = Position(cells: cells)
        let defScore = ProbeSearch.probe(position: pos, player: .defender)
        #expect(defScore > 0)
    }
}
