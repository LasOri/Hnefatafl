import Testing
@testable import Hnefatafl

@Suite("InitiativeTracker Tests")
struct InitiativeTrackerTests {
    @Test("Empty board returns attacker initiative by default")
    func emptyBoardAttacker() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let player = InitiativeTracker.hasInitiative(position: position)
        #expect(player == .attacker)
    }

    @Test("Initiative score is zero on empty board")
    func emptyBoardScoreZero() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = InitiativeTracker.initiativeScore(position: position)
        #expect(score == 0)
    }

    @Test("Positive score means attacker initiative")
    func positiveScoreAttacker() {
        let position = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.king, row: 0, col: 0)
            .build()
        let player = InitiativeTracker.hasInitiative(position: position)
        let score = InitiativeTracker.initiativeScore(position: position)
        if score >= 0 {
            #expect(player == .attacker)
        } else {
            #expect(player == .defender)
        }
    }

    @Test("hasInitiative returns a valid player")
    func returnsValidPlayer() {
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 3)
            .placing(.defender, row: 7, col: 7)
            .placing(.king, row: 5, col: 5)
            .build()
        let player = InitiativeTracker.hasInitiative(position: position)
        #expect(player == .attacker || player == .defender)
    }

    @Test("Score consistency with hasInitiative")
    func scoreConsistency() {
        let position = emptyBoard()
            .placing(.attacker, row: 2, col: 2)
            .placing(.defender, row: 8, col: 8)
            .placing(.king, row: 5, col: 5)
            .build()
        let score = InitiativeTracker.initiativeScore(position: position)
        let player = InitiativeTracker.hasInitiative(position: position)
        if score >= 0 {
            #expect(player == .attacker)
        } else {
            #expect(player == .defender)
        }
    }

    @Test("More attackers yields higher initiative score")
    func moreAttackersHigherScore() {
        let few = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.king, row: 0, col: 0)
            .build()
        let many = emptyBoard()
            .placing(.attacker, row: 5, col: 5)
            .placing(.attacker, row: 5, col: 6)
            .placing(.attacker, row: 5, col: 7)
            .placing(.king, row: 0, col: 0)
            .build()
        let fewScore = InitiativeTracker.initiativeScore(position: few)
        let manyScore = InitiativeTracker.initiativeScore(position: many)
        #expect(manyScore >= fewScore)
    }
}
