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
    let muted: Bool
    let captureHistory: [Bool]
    let aiDifficulty: AIDifficulty
    let aiPersonality: AIPersonality
    let announcement: String?
    let boardFlipped: Bool
    let showRules: Bool
    let replayStep: Int?
    let hintMove: Move?
    let showCoordinates: Bool
    let selectedVariant: SelectedVariant
    let aiEvalScore: Int?
    let aiSearchDepth: Int?
    let p2pSession: P2PSessionState?

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
        muted = false
        captureHistory = []
        aiDifficulty = .medium
        aiPersonality = .balanced
        announcement = nil
        boardFlipped = false
        showRules = false
        replayStep = nil
        hintMove = nil
        showCoordinates = true
        selectedVariant = .copenhagen
        aiEvalScore = nil
        aiSearchDepth = nil
        p2pSession = nil
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
        pendingSoundEffect: SoundEffect? = nil,
        muted: Bool = false,
        captureHistory: [Bool] = [],
        aiDifficulty: AIDifficulty = .medium,
        aiPersonality: AIPersonality = .balanced,
        announcement: String? = nil,
        boardFlipped: Bool = false,
        showRules: Bool = false,
        replayStep: Int? = nil,
        hintMove: Move? = nil,
        showCoordinates: Bool = true,
        selectedVariant: SelectedVariant = .copenhagen,
        aiEvalScore: Int? = nil,
        aiSearchDepth: Int? = nil,
        p2pSession: P2PSessionState? = nil
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
        self.muted = muted
        self.captureHistory = captureHistory
        self.aiDifficulty = aiDifficulty
        self.aiPersonality = aiPersonality
        self.announcement = announcement
        self.boardFlipped = boardFlipped
        self.showRules = showRules
        self.replayStep = replayStep
        self.hintMove = hintMove
        self.showCoordinates = showCoordinates
        self.selectedVariant = selectedVariant
        self.aiEvalScore = aiEvalScore
        self.aiSearchDepth = aiSearchDepth
        self.p2pSession = p2pSession
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
        lhs.pendingSoundEffect == rhs.pendingSoundEffect &&
        lhs.muted == rhs.muted &&
        lhs.captureHistory == rhs.captureHistory &&
        lhs.aiDifficulty == rhs.aiDifficulty &&
        lhs.aiPersonality == rhs.aiPersonality &&
        lhs.announcement == rhs.announcement &&
        lhs.boardFlipped == rhs.boardFlipped &&
        lhs.showRules == rhs.showRules &&
        lhs.replayStep == rhs.replayStep &&
        lhs.hintMove == rhs.hintMove &&
        lhs.showCoordinates == rhs.showCoordinates &&
        lhs.selectedVariant == rhs.selectedVariant &&
        lhs.aiEvalScore == rhs.aiEvalScore &&
        lhs.aiSearchDepth == rhs.aiSearchDepth &&
        lhs.p2pSession == rhs.p2pSession
    }
}
