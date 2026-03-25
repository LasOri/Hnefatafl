import Testing
@testable import Hnefatafl

@Suite("EndgameTablebase Tests")
struct EndgameTablebaseTests {

    @Test("lone king wins lookup")
    func loneKingWins() {
        let entry = EndgameTablebase.lookup(attackerCount: 0, defenderCount: 1)
        #expect(entry != nil)
        #expect(entry!.evaluation == 10000)
    }

    @Test("surrounded king loses")
    func surroundedKingLoses() {
        let entry = EndgameTablebase.lookup(attackerCount: 4, defenderCount: 1)
        #expect(entry != nil)
        #expect(entry!.evaluation == -5000)
    }

    @Test("defender material advantage")
    func defenderAdvantage() {
        let entry = EndgameTablebase.lookup(attackerCount: 2, defenderCount: 3)
        #expect(entry != nil)
        #expect(entry!.evaluation == 8000)
    }

    @Test("unknown position returns nil")
    func unknownReturnsNil() {
        let entry = EndgameTablebase.lookup(attackerCount: 10, defenderCount: 8)
        #expect(entry == nil)
    }

    @Test("known endgame threshold")
    func knownEndgameThreshold() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 3, col: 3)
            .placing(.attacker, row: 7, col: 7)
            .build()
        #expect(EndgameTablebase.isKnownEndgame(position: position))
    }

    @Test("starting position not endgame")
    func startingNotEndgame() {
        let position = Position.copenhagenStart()
        #expect(!EndgameTablebase.isKnownEndgame(position: position))
    }
}
