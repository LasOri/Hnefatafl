import Testing
@testable import Hnefatafl

@Suite("AudioSubscriber Tests")
struct AudioSubscriberTests {

    @Test("initial bridge is unmuted")
    func initialBridgeUnmuted() {
        let subscriber = AudioSubscriber()
        #expect(subscriber.bridge.muted == false)
    }

    @Test("handleStateChange syncs muted to bridge")
    func syncsMutedTrue() {
        let subscriber = AudioSubscriber()
        let state = gameReducer(state: GameState(), action: GameAction.toggleMute)
        subscriber.handleStateChange(state)
        #expect(subscriber.bridge.muted == true)
    }

    @Test("handleStateChange syncs muted back to false")
    func syncsMutedFalse() {
        let subscriber = AudioSubscriber()
        let muted = gameReducer(state: GameState(), action: GameAction.toggleMute)
        subscriber.handleStateChange(muted)
        let unmuted = gameReducer(state: muted, action: GameAction.toggleMute)
        subscriber.handleStateChange(unmuted)
        #expect(subscriber.bridge.muted == false)
    }

    @Test("processState called on select produces select sound")
    func selectSound() {
        let subscriber = AudioSubscriber()
        let state = gameReducer(state: GameState(), action: GameAction.selectSquare(row: 0, col: 3))
        subscriber.handleStateChange(state)
        #expect(subscriber.bridge.lastPlayed == .select)
    }

    @Test("no sound when muted")
    func noSoundWhenMuted() {
        let subscriber = AudioSubscriber()
        let muted = gameReducer(state: GameState(), action: GameAction.toggleMute)
        let selected = gameReducer(state: muted, action: GameAction.selectSquare(row: 0, col: 3))
        subscriber.handleStateChange(selected)
        #expect(subscriber.bridge.lastPlayed == nil)
    }

    @Test("move sound on makeMove")
    func moveSound() {
        let subscriber = AudioSubscriber()
        let state = GameState()
        let move = state.game.position.allLegalMoves(for: .attacker).first!
        let afterMove = gameReducer(state: state, action: GameAction.makeMove(move))
        subscriber.handleStateChange(afterMove)
        #expect(subscriber.bridge.lastPlayed == .move)
    }

    @Test("capture sound on capture move")
    func captureSound() {
        let subscriber = AudioSubscriber()
        let position = emptyBoard()
            .placing(.attacker, row: 3, col: 0)
            .placing(.defender, row: 3, col: 1)
            .placing(.attacker, row: 3, col: 3)
            .placing(.king, row: 8, col: 8)
            .build()
        let game = Game(position: position, currentPlayer: .attacker, moveHistory: [])
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let captureMove = Move(fromRow: 3, fromCol: 3, toRow: 3, toCol: 2)
        let afterCapture = gameReducer(state: state, action: GameAction.makeMove(captureMove))
        subscriber.handleStateChange(afterCapture)
        #expect(subscriber.bridge.lastPlayed == .capture)
    }

    @Test("gameOver sound on winning move")
    func gameOverSound() {
        let subscriber = AudioSubscriber()
        let position = emptyBoard()
            .placing(.king, row: 0, col: 1)
            .placing(.attacker, row: 5, col: 5)
            .build()
        let game = Game(position: position, currentPlayer: .defender, moveHistory: [])
        let state = GameState(game: game, selectedSquare: nil, legalMovesForSelected: [])
        let winMove = Move(fromRow: 0, fromCol: 1, toRow: 0, toCol: 0)
        let afterWin = gameReducer(state: state, action: GameAction.makeMove(winMove))
        subscriber.handleStateChange(afterWin)
        #expect(subscriber.bridge.lastPlayed == .gameOver)
    }

    @Test("newGame produces no sound")
    func newGameNoSound() {
        let subscriber = AudioSubscriber()
        let afterNew = gameReducer(state: GameState(), action: GameAction.newGame)
        subscriber.handleStateChange(afterNew)
        #expect(subscriber.bridge.lastPlayed == nil)
    }
}
