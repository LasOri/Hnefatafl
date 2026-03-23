struct GameState: Equatable {
    let game: Game
    let selectedSquare: (row: Int, col: Int)?
    let legalMovesForSelected: [Move]
    let attackersCaptured: Int
    let defendersCaptured: Int
    let undoStack: [(game: Game, attackersCaptured: Int, defendersCaptured: Int)]
    let focusedSquare: (row: Int, col: Int)?

    init() {
        game = Game()
        selectedSquare = nil
        legalMovesForSelected = []
        attackersCaptured = 0
        defendersCaptured = 0
        undoStack = []
        focusedSquare = (row: 0, col: 0)
    }

    init(
        game: Game,
        selectedSquare: (row: Int, col: Int)?,
        legalMovesForSelected: [Move],
        attackersCaptured: Int,
        defendersCaptured: Int,
        undoStack: [(game: Game, attackersCaptured: Int, defendersCaptured: Int)] = [],
        focusedSquare: (row: Int, col: Int)? = (row: 0, col: 0)
    ) {
        self.game = game
        self.selectedSquare = selectedSquare
        self.legalMovesForSelected = legalMovesForSelected
        self.attackersCaptured = attackersCaptured
        self.defendersCaptured = defendersCaptured
        self.undoStack = undoStack
        self.focusedSquare = focusedSquare
    }

    static func == (lhs: GameState, rhs: GameState) -> Bool {
        lhs.game.position == rhs.game.position &&
        lhs.game.currentPlayer == rhs.game.currentPlayer &&
        lhs.selectedSquare?.row == rhs.selectedSquare?.row &&
        lhs.selectedSquare?.col == rhs.selectedSquare?.col &&
        lhs.attackersCaptured == rhs.attackersCaptured &&
        lhs.defendersCaptured == rhs.defendersCaptured &&
        lhs.focusedSquare?.row == rhs.focusedSquare?.row &&
        lhs.focusedSquare?.col == rhs.focusedSquare?.col
    }
}
