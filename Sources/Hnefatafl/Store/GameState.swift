struct GameState: Equatable {
    let game: Game
    let selectedSquare: (row: Int, col: Int)?
    let legalMovesForSelected: [Move]
    let attackersCaptured: Int
    let defendersCaptured: Int
    let undoStack: [(game: Game, attackersCaptured: Int, defendersCaptured: Int)]
    let focusedSquare: (row: Int, col: Int)?
    let aiMode: AIMode
    let lastMove: Move?
    let capturedSquares: [(row: Int, col: Int)]
    let pendingSoundEffect: SoundEffect?

    init() {
        game = Game()
        selectedSquare = nil
        legalMovesForSelected = []
        attackersCaptured = 0
        defendersCaptured = 0
        undoStack = []
        focusedSquare = (row: 0, col: 0)
        aiMode = .humanVsHuman
        lastMove = nil
        capturedSquares = []
        pendingSoundEffect = nil
    }

    init(
        game: Game,
        selectedSquare: (row: Int, col: Int)?,
        legalMovesForSelected: [Move],
        attackersCaptured: Int = 0,
        defendersCaptured: Int = 0,
        undoStack: [(game: Game, attackersCaptured: Int, defendersCaptured: Int)] = [],
        focusedSquare: (row: Int, col: Int)? = (row: 0, col: 0),
        aiMode: AIMode = .humanVsHuman,
        lastMove: Move? = nil,
        capturedSquares: [(row: Int, col: Int)] = [],
        pendingSoundEffect: SoundEffect? = nil
    ) {
        self.game = game
        self.selectedSquare = selectedSquare
        self.legalMovesForSelected = legalMovesForSelected
        self.attackersCaptured = attackersCaptured
        self.defendersCaptured = defendersCaptured
        self.undoStack = undoStack
        self.focusedSquare = focusedSquare
        self.aiMode = aiMode
        self.lastMove = lastMove
        self.capturedSquares = capturedSquares
        self.pendingSoundEffect = pendingSoundEffect
    }

    static func == (lhs: GameState, rhs: GameState) -> Bool {
        lhs.game.position == rhs.game.position &&
        lhs.game.currentPlayer == rhs.game.currentPlayer &&
        lhs.selectedSquare?.row == rhs.selectedSquare?.row &&
        lhs.selectedSquare?.col == rhs.selectedSquare?.col &&
        lhs.attackersCaptured == rhs.attackersCaptured &&
        lhs.defendersCaptured == rhs.defendersCaptured &&
        lhs.focusedSquare?.row == rhs.focusedSquare?.row &&
        lhs.focusedSquare?.col == rhs.focusedSquare?.col &&
        lhs.aiMode == rhs.aiMode &&
        lhs.lastMove == rhs.lastMove &&
        lhs.pendingSoundEffect == rhs.pendingSoundEffect
    }
}
