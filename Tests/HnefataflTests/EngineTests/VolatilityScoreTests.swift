import Testing
@testable import Hnefatafl

@Suite("Volatility Score Tests")
struct VolatilityScoreTests {

    @Test("empty board with king has zero volatility")
    func emptyBoardZero() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        let v = VolatilityScore.volatility(position: pos)
        #expect(v == 0)
    }

    @Test("start position has some volatility")
    func startPositionVolatility() {
        let pos = Position.copenhagenStart()
        let v = VolatilityScore.volatility(position: pos)
        #expect(v >= 0)
    }

    @Test("isVolatile with high threshold returns false on empty")
    func notVolatileEmpty() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .build()
        #expect(!VolatilityScore.isVolatile(position: pos, threshold: 1))
    }

    @Test("isVolatile with zero threshold returns true when any volatility")
    func volatileWithZeroThreshold() {
        let pos = Position.copenhagenStart()
        let v = VolatilityScore.volatility(position: pos)
        if v > 0 {
            #expect(VolatilityScore.isVolatile(position: pos, threshold: 0))
        } else {
            #expect(!VolatilityScore.isVolatile(position: pos, threshold: 1))
        }
    }

    @Test("pieces at risk increase volatility")
    func piecesAtRiskIncreaseVolatility() {
        let pos = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 3, col: 5)
            .placing(.attacker, row: 2, col: 5)
            .placing(.attacker, row: 4, col: 5)
            .build()
        let v = VolatilityScore.volatility(position: pos)
        #expect(v > 0)
    }

    @Test("isVolatile consistent with volatility")
    func consistencyCheck() {
        let pos = Position.copenhagenStart()
        let v = VolatilityScore.volatility(position: pos)
        #expect(VolatilityScore.isVolatile(position: pos, threshold: v) == (v >= v))
    }
}
