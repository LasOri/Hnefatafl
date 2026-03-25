import Testing
@testable import Hnefatafl

@Suite("PieceHarmonyScore Tests")
struct PieceHarmonyScoreTests {
    @Test("Harmony at start is positive for defenders")
    func defenderHarmonyStart() {
        let position = Position.copenhagenStart()
        let score = PieceHarmonyScore.harmony(position: position, player: .defender)
        #expect(score > 0)
    }

    @Test("Discord penalty at start for attackers")
    func attackerDiscordStart() {
        let position = Position.copenhagenStart()
        let penalty = PieceHarmonyScore.discordPenalty(position: position, player: .attacker)
        #expect(penalty >= 0)
    }

    @Test("Empty board has zero harmony")
    func emptyBoardZeroHarmony() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let score = PieceHarmonyScore.harmony(position: position, player: .attacker)
        #expect(score == 0)
    }

    @Test("Empty board has zero discord")
    func emptyBoardZeroDiscord() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let penalty = PieceHarmonyScore.discordPenalty(position: position, player: .attacker)
        #expect(penalty == 0)
    }

    @Test("Two adjacent attackers have harmony")
    func twoAdjacentAttackers() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .attacker
        cells[5 * 11 + 6] = .attacker
        let position = Position(cells: cells)
        let score = PieceHarmonyScore.harmony(position: position, player: .attacker)
        #expect(score > 0)
    }

    @Test("Isolated piece has discord penalty")
    func isolatedPieceDiscord() {
        var cells = Array<Piece?>(repeating: nil, count: 121)
        cells[0] = .attacker
        let position = Position(cells: cells)
        let penalty = PieceHarmonyScore.discordPenalty(position: position, player: .attacker)
        #expect(penalty == 10)
    }
}
