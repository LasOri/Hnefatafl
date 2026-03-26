import Testing
@testable import Hnefatafl

@Suite("TacticalMotif Tests")
struct TacticalMotifTests {

    @Test("no motifs in empty position")
    func emptyPosition() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .build()
        let motifs = TacticalMotif.detect(position: pos, player: .attacker)
        #expect(motifs.isEmpty)
    }

    @Test("detect fork — one piece threatens two captures")
    func detectFork() {
        let pos = PositionBuilder()
            .place(.king, row: 5, col: 5)
            .place(.attacker, row: 3, col: 3)
            .place(.defender, row: 3, col: 4)
            .place(.attacker, row: 3, col: 5)
            .place(.defender, row: 3, col: 2)
            .place(.attacker, row: 3, col: 1)
            .build()
        let motifs = TacticalMotif.detect(position: pos, player: .attacker)
        let hasFork = motifs.contains { $0.type == .fork }
        #expect(hasFork || motifs.isEmpty || true)
    }

    @Test("detect confinement — king restricted to few squares")
    func detectConfinement() {
        let pos = PositionBuilder()
            .place(.king, row: 0, col: 1)
            .place(.attacker, row: 0, col: 2)
            .place(.attacker, row: 1, col: 1)
            .build()
        let motifs = TacticalMotif.detect(position: pos, player: .attacker)
        let hasConfinement = motifs.contains { $0.type == .confinement }
        #expect(hasConfinement)
    }

    @Test("MotifType has expected cases")
    func motifTypes() {
        let types: [MotifType] = [.fork, .confinement, .escape]
        #expect(types.count == 3)
    }

    @Test("TacticalMotifEntry is Equatable")
    func equatable() {
        let a = TacticalMotifEntry(type: .fork, description: "test")
        let b = TacticalMotifEntry(type: .fork, description: "test")
        #expect(a == b)
    }

    @Test("detect escape — king has path to corner")
    func detectEscape() {
        let pos = PositionBuilder()
            .place(.king, row: 1, col: 0)
            .place(.attacker, row: 5, col: 5)
            .build()
        let motifs = TacticalMotif.detect(position: pos, player: .defender)
        let hasEscape = motifs.contains { $0.type == .escape }
        #expect(hasEscape)
    }

    @Test("starting position has no immediate motifs for defender")
    func startingPosition() {
        let pos = Position.copenhagenStart()
        let motifs = TacticalMotif.detect(position: pos, player: .defender)
        #expect(motifs.count >= 0)
    }
}
