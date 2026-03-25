import Testing
@testable import Hnefatafl

@Suite("TurnHistory Tests")
struct TurnHistoryTests {

    @Test("empty history has no turns")
    func empty() {
        let history = TurnHistory()
        #expect(history.turns.isEmpty)
        #expect(history.turnCount == 0)
    }

    @Test("add turn record")
    func addTurn() {
        var history = TurnHistory()
        let move = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        history.addTurn(TurnRecord(move: move, player: .attacker, captureCount: 0, timeSpent: 5.0, evaluation: 10))
        #expect(history.turnCount == 1)
    }

    @Test("turns maintain order")
    func ordering() {
        var history = TurnHistory()
        let m1 = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4)
        history.addTurn(TurnRecord(move: m1, player: .attacker, captureCount: 0, timeSpent: 3.0, evaluation: 0))
        history.addTurn(TurnRecord(move: m2, player: .defender, captureCount: 1, timeSpent: 7.0, evaluation: -5))
        #expect(history.turns[0].player == .attacker)
        #expect(history.turns[1].player == .defender)
    }

    @Test("total captures computed")
    func totalCaptures() {
        var history = TurnHistory()
        let m1 = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4)
        history.addTurn(TurnRecord(move: m1, player: .attacker, captureCount: 2, timeSpent: 1.0, evaluation: 0))
        history.addTurn(TurnRecord(move: m2, player: .defender, captureCount: 1, timeSpent: 1.0, evaluation: 0))
        #expect(history.totalCaptures == 3)
    }

    @Test("total time spent")
    func totalTime() {
        var history = TurnHistory()
        let m = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        history.addTurn(TurnRecord(move: m, player: .attacker, captureCount: 0, timeSpent: 5.5, evaluation: 0))
        history.addTurn(TurnRecord(move: m, player: .defender, captureCount: 0, timeSpent: 3.5, evaluation: 0))
        #expect(history.totalTimeSpent == 9.0)
    }

    @Test("turns for player")
    func turnsForPlayer() {
        var history = TurnHistory()
        let m = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        history.addTurn(TurnRecord(move: m, player: .attacker, captureCount: 0, timeSpent: 1.0, evaluation: 0))
        history.addTurn(TurnRecord(move: m, player: .defender, captureCount: 0, timeSpent: 1.0, evaluation: 0))
        history.addTurn(TurnRecord(move: m, player: .attacker, captureCount: 0, timeSpent: 1.0, evaluation: 0))
        #expect(history.turns(for: .attacker).count == 2)
        #expect(history.turns(for: .defender).count == 1)
    }

    @Test("TurnRecord is Equatable")
    func equatable() {
        let m = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        let a = TurnRecord(move: m, player: .attacker, captureCount: 0, timeSpent: 1.0, evaluation: 5)
        let b = TurnRecord(move: m, player: .attacker, captureCount: 0, timeSpent: 1.0, evaluation: 5)
        #expect(a == b)
    }

    @Test("lastTurn returns most recent")
    func lastTurn() {
        var history = TurnHistory()
        let m1 = Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 5)
        let m2 = Move(fromRow: 1, fromCol: 0, toRow: 1, toCol: 5)
        history.addTurn(TurnRecord(move: m1, player: .attacker, captureCount: 0, timeSpent: 1.0, evaluation: 0))
        history.addTurn(TurnRecord(move: m2, player: .defender, captureCount: 0, timeSpent: 2.0, evaluation: 0))
        #expect(history.lastTurn?.move == m2)
    }
}
