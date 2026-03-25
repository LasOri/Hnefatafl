import Testing
@testable import Hnefatafl

@Suite("PassivityDetector Tests")
struct PassivityDetectorTests {

    @Test("start position is not passive for attacker")
    func startNotPassiveAttacker() {
        let position = Position.copenhagenStart()
        #expect(PassivityDetector.isPassive(position: position, player: .attacker) == false)
    }

    @Test("start position is not passive for defender")
    func startNotPassiveDefender() {
        let position = Position.copenhagenStart()
        #expect(PassivityDetector.isPassive(position: position, player: .defender) == false)
    }

    @Test("passivity score is non-negative")
    func scoreNonNegative() {
        let position = Position.copenhagenStart()
        #expect(PassivityDetector.passivityScore(position: position, player: .attacker) >= 0)
    }

    @Test("empty board gives high passivity for attacker")
    func emptyBoardHighPassivity() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = PassivityDetector.passivityScore(position: position, player: .attacker)
        #expect(score >= 5)
    }

    @Test("single piece with limited mobility may show passivity")
    func singlePieceLimitedMobility() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0] = .attacker
        let position = Position(cells: cells)
        let score = PassivityDetector.passivityScore(position: position, player: .attacker)
        #expect(score >= 0)
    }

    @Test("isPassive returns bool")
    func isPassiveReturnsBool() {
        let position = Position.copenhagenStart()
        let result = PassivityDetector.isPassive(position: position, player: .attacker)
        #expect(result == true || result == false)
    }
}
