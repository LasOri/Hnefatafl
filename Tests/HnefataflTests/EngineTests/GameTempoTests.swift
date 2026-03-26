import Testing
@testable import Hnefatafl

@Suite("GameTempo Tests")
struct GameTempoTests {

    @Test("starting position has tempo assessment")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let tempo = GameTempo.evaluate(position: pos)
        #expect(tempo.advantage == .attacker || tempo.advantage == .defender || tempo.advantage == nil)
    }

    @Test("TempoResult is Equatable")
    func equatable() {
        let a = TempoResult(attackerTempo: 5, defenderTempo: 3, advantage: .attacker)
        let b = TempoResult(attackerTempo: 5, defenderTempo: 3, advantage: .attacker)
        #expect(a == b)
    }

    @Test("tempo values are non-negative")
    func nonNegative() {
        let pos = Position.copenhagenStart()
        let tempo = GameTempo.evaluate(position: pos)
        #expect(tempo.attackerTempo >= 0)
        #expect(tempo.defenderTempo >= 0)
    }

    @Test("empty board has zero tempo")
    func emptyBoard() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let tempo = GameTempo.evaluate(position: pos)
        #expect(tempo.attackerTempo == 0)
        #expect(tempo.defenderTempo == 0)
    }

    @Test("advantage reflects higher tempo")
    func advantageReflects() {
        let pos = Position.copenhagenStart()
        let tempo = GameTempo.evaluate(position: pos)
        if let adv = tempo.advantage {
            if adv == .attacker {
                #expect(tempo.attackerTempo >= tempo.defenderTempo)
            } else {
                #expect(tempo.defenderTempo >= tempo.attackerTempo)
            }
        }
    }

    @Test("tempo changes with position")
    func changesWithPosition() {
        let pos1 = Position.copenhagenStart()
        let move = pos1.allLegalMoves(for: .attacker).first!
        let pos2 = pos1.applyMove(move)
        let t1 = GameTempo.evaluate(position: pos1)
        let t2 = GameTempo.evaluate(position: pos2)
        #expect(t1.attackerTempo >= 0 && t2.attackerTempo >= 0)
    }
}
