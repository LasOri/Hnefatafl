import Testing
@testable import Hnefatafl

@Suite("InterceptionEval Tests")
struct InterceptionEvalTests {
    @Test("Interceptor count at Copenhagen start")
    func interceptorCountStart() {
        let position = Position.copenhagenStart()
        let count = InterceptionEval.interceptorCount(position: position)
        #expect(count >= 0)
    }

    @Test("Interception score at Copenhagen start")
    func interceptionScoreStart() {
        let position = Position.copenhagenStart()
        let score = InterceptionEval.interceptionScore(position: position)
        #expect(score >= 0)
    }

    @Test("Attacker on same row as king counts as interceptor")
    func attackerOnSameRow() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 0)
            .build()
        #expect(InterceptionEval.interceptorCount(position: position) == 1)
    }

    @Test("Attacker on same column as king counts as interceptor")
    func attackerOnSameCol() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 0, col: 5)
            .build()
        #expect(InterceptionEval.interceptorCount(position: position) == 1)
    }

    @Test("No king returns zero")
    func noKing() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .build()
        #expect(InterceptionEval.interceptorCount(position: position) == 0)
        #expect(InterceptionEval.interceptionScore(position: position) == 0)
    }

    @Test("Closer interceptor scores higher")
    func closerScoresHigher() {
        let closePosition = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 4)
            .build()
        let farPosition = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 0)
            .build()
        let closeScore = InterceptionEval.interceptionScore(position: closePosition)
        let farScore = InterceptionEval.interceptionScore(position: farPosition)
        #expect(closeScore > farScore)
    }

    @Test("Diagonal attacker is not an interceptor")
    func diagonalNotInterceptor() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.attacker, row: 3, col: 3)
            .build()
        #expect(InterceptionEval.interceptorCount(position: position) == 0)
    }
}
