import Testing
import LINKERTesting
@testable import Hnefatafl

@Suite("AI Difficulty Tests")
struct AIDifficultyTests {

    @Test("easy has search depth 1")
    func easySearchDepth() {
        #expect(AIDifficulty.easy.searchDepth == 1)
    }

    @Test("medium has search depth 2")
    func mediumSearchDepth() {
        #expect(AIDifficulty.medium.searchDepth == 2)
    }

    @Test("hard has search depth 3")
    func hardSearchDepth() {
        #expect(AIDifficulty.hard.searchDepth == 3)
    }

    @Test("easy has label Easy")
    func easyLabel() {
        #expect(AIDifficulty.easy.label == "Easy")
    }

    @Test("medium has label Medium")
    func mediumLabel() {
        #expect(AIDifficulty.medium.label == "Medium")
    }

    @Test("hard has label Hard")
    func hardLabel() {
        #expect(AIDifficulty.hard.label == "Hard")
    }

    @Test("default difficulty is medium")
    func defaultDifficulty() {
        let state = GameState()
        #expect(state.aiDifficulty == .medium)
    }

    @Test("cycleDifficulty cycles easy to medium")
    func cycleEasyToMedium() {
        let state = gameReducer(
            state: setCycleDifficultyState(.easy),
            action: GameAction.cycleDifficulty
        )
        #expect(state.aiDifficulty == .medium)
    }

    @Test("cycleDifficulty cycles medium to hard")
    func cycleMediumToHard() {
        let state = gameReducer(
            state: setCycleDifficultyState(.medium),
            action: GameAction.cycleDifficulty
        )
        #expect(state.aiDifficulty == .hard)
    }

    @Test("cycleDifficulty cycles hard to easy")
    func cycleHardToEasy() {
        let state = gameReducer(
            state: setCycleDifficultyState(.hard),
            action: GameAction.cycleDifficulty
        )
        #expect(state.aiDifficulty == .easy)
    }

    @Test("difficulty preserved through makeMove")
    func preservedThroughMakeMove() {
        var state = GameState()
        state = gameReducer(state: state, action: GameAction.cycleDifficulty)
        let initial = state.aiDifficulty
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        state = gameReducer(state: state, action: GameAction.makeMove(move))
        #expect(state.aiDifficulty == initial)
    }

    @Test("difficulty preserved through undo")
    func preservedThroughUndo() {
        var state = GameState()
        state = gameReducer(state: state, action: GameAction.cycleDifficulty)
        let initial = state.aiDifficulty
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        state = gameReducer(state: state, action: GameAction.makeMove(move))
        state = gameReducer(state: state, action: GameAction.undo)
        #expect(state.aiDifficulty == initial)
    }

    @Test("difficulty preserved through newGame")
    func preservedThroughNewGame() {
        var state = GameState()
        state = gameReducer(state: state, action: GameAction.cycleDifficulty)
        let initial = state.aiDifficulty
        state = gameReducer(state: state, action: GameAction.newGame)
        #expect(state.aiDifficulty == initial)
    }

    @Test("EventWiring maps cycle-difficulty")
    func eventWiringMaps() {
        let action = EventWiring.actionForButton("cycle-difficulty")
        #expect(action != nil)
        if case .cycleDifficulty = action {} else {
            Issue.record("Expected .cycleDifficulty")
        }
    }

    @Test("AppComponent renders difficulty button")
    func rendersDifficultyButton() {
        let state = GameState()
        let nodes = AppComponent.render(state: state)
        let rendered = render(nodes)
        let btn = rendered.findAll(tag: "button").first(where: { $0.attr("data-action") == "cycle-difficulty" })
        #expect(btn != nil)
        let difficultyText = rendered.findByText("AI: Medium")
        #expect(difficultyText != nil)
    }

    @Test("AIGameLoop uses difficulty depth")
    func aiGameLoopUsesDifficulty() {
        let position = emptyBoard()
            .placing(.king, row: 5, col: 5)
            .placing(.defender, row: 4, col: 5)
            .placing(.attacker, row: 0, col: 3)
            .placing(.attacker, row: 10, col: 7)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let move = AIGameLoop.aiMove(game: game, mode: .humanVsAI(humanSide: .defender), difficulty: .easy)
        #expect(move != nil)
    }
}

private func setCycleDifficultyState(_ difficulty: AIDifficulty) -> GameState {
    var state = GameState()
    switch difficulty {
    case .easy:
        state = gameReducer(state: state, action: GameAction.cycleDifficulty)
        state = gameReducer(state: state, action: GameAction.cycleDifficulty)
    case .medium:
        break
    case .hard:
        state = gameReducer(state: state, action: GameAction.cycleDifficulty)
    }
    return state
}
