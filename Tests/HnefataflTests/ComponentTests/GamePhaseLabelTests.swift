import Testing
@testable import Hnefatafl

@Suite("GamePhaseLabel Tests")
struct GamePhaseLabelTests {

    @Test("start position is opening")
    func startPositionIsOpening() {
        let position = Position.copenhagenStart()
        let info = GamePhaseLabel.info(for: position)
        #expect(info.phase == .opening)
    }

    @Test("label matches phase")
    func labelMatchesPhase() {
        let position = Position.copenhagenStart()
        let info = GamePhaseLabel.info(for: position)
        #expect(info.label == "Opening")
    }

    @Test("description is non-empty")
    func descriptionNonEmpty() {
        let position = Position.copenhagenStart()
        let info = GamePhaseLabel.info(for: position)
        #expect(!info.description.isEmpty)
    }

    @Test("all phases have labels")
    func allPhasesHaveLabels() {
        let openingPos = Position.copenhagenStart()
        let openingInfo = GamePhaseLabel.info(for: openingPos)
        #expect(!openingInfo.label.isEmpty)

        var midgameCells: [Piece?] = Array(repeating: nil, count: 121)
        midgameCells[5 * 11 + 5] = .king
        for i in 0..<10 {
            midgameCells[i] = .attacker
        }
        for i in 100..<105 {
            midgameCells[i] = .defender
        }
        let midgamePos = Position(cells: midgameCells)
        let midgameInfo = GamePhaseLabel.info(for: midgamePos)
        #expect(!midgameInfo.label.isEmpty)

        var endgameCells: [Piece?] = Array(repeating: nil, count: 121)
        endgameCells[5 * 11 + 5] = .king
        endgameCells[0] = .attacker
        endgameCells[1] = .attacker
        endgameCells[2] = .defender
        let endgamePos = Position(cells: endgameCells)
        let endgameInfo = GamePhaseLabel.info(for: endgamePos)
        #expect(!endgameInfo.label.isEmpty)
    }

    @Test("phase is consistent with EndgameDetector")
    func phaseConsistentWithEndgameDetector() {
        let position = Position.copenhagenStart()
        let info = GamePhaseLabel.info(for: position)
        let detectedPhase = EndgameDetector.phase(position: position)
        #expect(info.phase == detectedPhase)
    }
}
