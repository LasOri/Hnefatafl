import LINKER

func gameReducer(state: GameState, action: any Action) -> GameState {
    guard let action = action as? GameAction else { return state }

    switch action {
    case .newGame:
        return GameState()

    case .selectSquare(let row, let col):
        return reduceSelectSquare(state: state, row: row, col: col)

    case .makeMove(let move):
        return reduceMakeMove(state: state, move: move)

    case .undo:
        return reduceUndo(state: state)

    case .moveFocus(let direction):
        return reduceMoveFocus(state: state, direction: direction)

    case .escape:
        return reduceEscape(state: state)

    case .toggleAI:
        return reduceToggleAI(state: state)
    }
}

private func reduceSelectSquare(state: GameState, row: Int, col: Int) -> GameState {
    guard let piece = state.game.position.pieceAt(row: row, col: col) else {
        return GameState(
            game: state.game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: state.attackersCaptured,
            defendersCaptured: state.defendersCaptured,
            undoStack: state.undoStack,
            aiMode: state.aiMode
        )
    }

    let belongsToCurrentPlayer: Bool
    switch state.game.currentPlayer {
    case .attacker: belongsToCurrentPlayer = piece.isAttackerSide
    case .defender: belongsToCurrentPlayer = piece.isDefenderSide
    }

    guard belongsToCurrentPlayer else { return state }

    let moves = state.game.position.legalMoves(forPieceAtRow: row, col: col)
    return GameState(
        game: state.game,
        selectedSquare: (row: row, col: col),
        legalMovesForSelected: moves,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        aiMode: state.aiMode
    )
}

private func reduceMakeMove(state: GameState, move: Move) -> GameState {
    let newGame = state.game.makeMove(move)
    let (capturedAttackers, capturedDefenders) = countCaptures(
        before: state.game.position, after: newGame.position
    )

    var newUndoStack = state.undoStack
    newUndoStack.append((game: state.game, attackersCaptured: state.attackersCaptured, defendersCaptured: state.defendersCaptured))

    var result = GameState(
        game: newGame,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: state.attackersCaptured + capturedAttackers,
        defendersCaptured: state.defendersCaptured + capturedDefenders,
        undoStack: newUndoStack,
        aiMode: state.aiMode
    )

    if let aiMove = AIGameLoop.aiMove(game: result.game, mode: result.aiMode) {
        let aiGame = result.game.makeMove(aiMove)
        let (aiCapturedAttackers, aiCapturedDefenders) = countCaptures(
            before: result.game.position, after: aiGame.position
        )
        var aiUndoStack = result.undoStack
        aiUndoStack.append((game: result.game, attackersCaptured: result.attackersCaptured, defendersCaptured: result.defendersCaptured))
        result = GameState(
            game: aiGame,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: result.attackersCaptured + aiCapturedAttackers,
            defendersCaptured: result.defendersCaptured + aiCapturedDefenders,
            undoStack: aiUndoStack,
            aiMode: result.aiMode
        )
    }

    return result
}

private func countCaptures(before: Position, after: Position) -> (attackers: Int, defenders: Int) {
    let oldAttackers = before.cells.filter { $0 == .attacker }.count
    let newAttackers = after.cells.filter { $0 == .attacker }.count
    let oldDefenders = before.cells.filter { $0 == .defender || $0 == .king }.count
    let newDefenders = after.cells.filter { $0 == .defender || $0 == .king }.count
    return (oldAttackers - newAttackers, oldDefenders - newDefenders)
}

private func reduceUndo(state: GameState) -> GameState {
    guard let previous = state.undoStack.last else { return state }
    var newUndoStack = state.undoStack
    newUndoStack.removeLast()

    if case .humanVsAI = state.aiMode, let humanPrevious = newUndoStack.last {
        newUndoStack.removeLast()
        return GameState(
            game: humanPrevious.game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: humanPrevious.attackersCaptured,
            defendersCaptured: humanPrevious.defendersCaptured,
            undoStack: newUndoStack,
            aiMode: state.aiMode
        )
    }

    return GameState(
        game: previous.game,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: previous.attackersCaptured,
        defendersCaptured: previous.defendersCaptured,
        undoStack: newUndoStack,
        aiMode: state.aiMode
    )
}

private func reduceMoveFocus(state: GameState, direction: FocusDirection) -> GameState {
    let current = state.focusedSquare ?? (row: 0, col: 0)
    let size = Position.boardSize
    var newRow = current.row
    var newCol = current.col

    switch direction {
    case .up: newRow = (current.row - 1 + size) % size
    case .down: newRow = (current.row + 1) % size
    case .left: newCol = (current.col - 1 + size) % size
    case .right: newCol = (current.col + 1) % size
    }

    return GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: (row: newRow, col: newCol),
        aiMode: state.aiMode
    )
}

private func reduceEscape(state: GameState) -> GameState {
    GameState(
        game: state.game,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode
    )
}

private func reduceToggleAI(state: GameState) -> GameState {
    let newMode: AIMode
    switch state.aiMode {
    case .humanVsHuman:
        newMode = .humanVsAI(humanSide: .defender)
    case .humanVsAI:
        newMode = .humanVsHuman
    }
    return GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: newMode
    )
}
