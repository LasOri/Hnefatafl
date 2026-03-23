import Testing
@testable import Hnefatafl

@Suite("Sound Effect Processor Tests")
struct SoundEffectProcessorTests {

    @Test("processState with nil pendingSoundEffect does not play")
    func nilDoesNotPlay() {
        let bridge = AudioBridge()
        let state = GameState()
        bridge.processState(state)
        #expect(bridge.lastPlayed == nil)
    }

    @Test("processState with .move plays move sound")
    func moveSoundPlays() {
        let bridge = AudioBridge()
        let game = Game()
        let move = game.position.allLegalMoves(for: .attacker).first!
        let state = GameState(
            game: game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            pendingSoundEffect: .move
        )
        bridge.processState(state)
        #expect(bridge.lastPlayed == .move)
    }

    @Test("processState with .capture plays capture sound")
    func captureSoundPlays() {
        let bridge = AudioBridge()
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            pendingSoundEffect: .capture
        )
        bridge.processState(state)
        #expect(bridge.lastPlayed == .capture)
    }

    @Test("processState with .gameOver plays gameOver sound")
    func gameOverSoundPlays() {
        let bridge = AudioBridge()
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            pendingSoundEffect: .gameOver
        )
        bridge.processState(state)
        #expect(bridge.lastPlayed == .gameOver)
    }

    @Test("processState with .select plays select sound")
    func selectSoundPlays() {
        let bridge = AudioBridge()
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            pendingSoundEffect: .select
        )
        bridge.processState(state)
        #expect(bridge.lastPlayed == .select)
    }

    @Test("processState when muted does not play")
    func mutedDoesNotPlay() {
        let bridge = AudioBridge()
        bridge.muted = true
        let state = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            pendingSoundEffect: .move
        )
        bridge.processState(state)
        #expect(bridge.lastPlayed == nil)
    }

    @Test("processState updates lastPlayed correctly")
    func updatesLastPlayed() {
        let bridge = AudioBridge()
        let state1 = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            pendingSoundEffect: .move
        )
        bridge.processState(state1)
        #expect(bridge.lastPlayed == .move)

        let state2 = GameState(
            game: Game(),
            selectedSquare: nil,
            legalMovesForSelected: [],
            pendingSoundEffect: .capture
        )
        bridge.processState(state2)
        #expect(bridge.lastPlayed == .capture)
    }
}
