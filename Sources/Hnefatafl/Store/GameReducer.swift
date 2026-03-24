import LINKER

func gameReducer(state: GameState, action: any Action) -> GameState {
    guard let action = action as? GameAction else { return state }

    switch action {
    case .newGame:
        return reduceNewGame(state: state)

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

    case .toggleMute:
        return reduceToggleMute(state: state)

    case .cycleDifficulty:
        return reduceCycleDifficulty(state: state)

    case .flipBoard:
        return reduceFlipBoard(state: state)

    case .toggleRules:
        return reduceToggleRules(state: state)

    case .enterReplay:
        return reduceEnterReplay(state: state)

    case .exitReplay:
        return reduceExitReplay(state: state)

    case .replayForward:
        return reduceReplayForward(state: state)

    case .replayBack:
        return reduceReplayBack(state: state)
    }
}

private func reduceNewGame(state: GameState) -> GameState {
    GameState(
        game: Game(),
        selectedSquare: nil,
        legalMovesForSelected: [],
        muted: state.muted,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
    )
}

private func reduceToggleMute(state: GameState) -> GameState {
    GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: !state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
    )
}

private func reduceCycleDifficulty(state: GameState) -> GameState {
    GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty.next,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
    )
}

private func reduceFlipBoard(state: GameState) -> GameState {
    GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: !state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
    )
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
            aiMode: state.aiMode,
            muted: state.muted,
            captureHistory: state.captureHistory,
            aiDifficulty: state.aiDifficulty,
            boardFlipped: state.boardFlipped,
            showRules: state.showRules,
            replayStep: state.replayStep
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
        aiMode: state.aiMode,
        pendingSoundEffect: .select,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
    )
}

private func reduceMakeMove(state: GameState, move: Move) -> GameState {
    let newGame = state.game.makeMove(move)
    let (capturedAttackers, capturedDefenders) = countCaptures(
        before: state.game.position, after: newGame.position
    )
    let captured = Position.capturedSquares(
        before: state.game.position,
        after: newGame.position,
        movedFrom: (row: move.fromRow, col: move.fromCol)
    )

    var newUndoStack = state.undoStack
    newUndoStack.append((game: state.game, attackersCaptured: state.attackersCaptured, defendersCaptured: state.defendersCaptured))

    let humanSound = soundForMove(captured: captured, gameStatus: newGame.status)

    var newCaptureHistory = state.captureHistory
    newCaptureHistory.append(!captured.isEmpty)

    let humanAnnouncement = moveAnnouncement(
        player: state.game.currentPlayer,
        move: move,
        captured: captured,
        gameStatus: newGame.status
    )

    var result = GameState(
        game: newGame,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: state.attackersCaptured + capturedAttackers,
        defendersCaptured: state.defendersCaptured + capturedDefenders,
        undoStack: newUndoStack,
        aiMode: state.aiMode,
        lastMove: move,
        capturedSquares: captured,
        pendingSoundEffect: humanSound,
        muted: state.muted,
        captureHistory: newCaptureHistory,
        aiDifficulty: state.aiDifficulty,
        announcement: humanAnnouncement,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
    )

    if let aiMove = AIGameLoop.aiMove(game: result.game, mode: result.aiMode, difficulty: result.aiDifficulty) {
        let aiGame = result.game.makeMove(aiMove)
        let (aiCapturedAttackers, aiCapturedDefenders) = countCaptures(
            before: result.game.position, after: aiGame.position
        )
        let aiCaptured = Position.capturedSquares(
            before: result.game.position,
            after: aiGame.position,
            movedFrom: (row: aiMove.fromRow, col: aiMove.fromCol)
        )
        var aiUndoStack = result.undoStack
        aiUndoStack.append((game: result.game, attackersCaptured: result.attackersCaptured, defendersCaptured: result.defendersCaptured))
        let aiSound = soundForMove(captured: aiCaptured, gameStatus: aiGame.status)
        var aiCaptureHistory = result.captureHistory
        aiCaptureHistory.append(!aiCaptured.isEmpty)
        let aiAnnouncement = moveAnnouncement(
            player: result.game.currentPlayer,
            move: aiMove,
            captured: aiCaptured,
            gameStatus: aiGame.status
        )
        result = GameState(
            game: aiGame,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: result.attackersCaptured + aiCapturedAttackers,
            defendersCaptured: result.defendersCaptured + aiCapturedDefenders,
            undoStack: aiUndoStack,
            aiMode: result.aiMode,
            lastMove: aiMove,
            capturedSquares: aiCaptured,
            pendingSoundEffect: prioritySound(humanSound, aiSound),
            muted: state.muted,
            captureHistory: aiCaptureHistory,
            aiDifficulty: state.aiDifficulty,
            announcement: aiAnnouncement,
            boardFlipped: state.boardFlipped,
            showRules: state.showRules,
            replayStep: state.replayStep
        )
    }

    return result
}

private func soundForMove(captured: [(row: Int, col: Int)], gameStatus: GameStatus) -> SoundEffect {
    if gameStatus != .inProgress { return .gameOver }
    if !captured.isEmpty { return .capture }
    return .move
}

private func prioritySound(_ a: SoundEffect, _ b: SoundEffect) -> SoundEffect {
    let order: [SoundEffect] = [.gameOver, .capture, .move, .select]
    let aIdx = order.firstIndex(of: a) ?? order.count
    let bIdx = order.firstIndex(of: b) ?? order.count
    return aIdx <= bIdx ? a : b
}

private func countCaptures(before: Position, after: Position) -> (attackers: Int, defenders: Int) {
    let oldAttackers = before.cells.filter { $0 == .attacker }.count
    let newAttackers = after.cells.filter { $0 == .attacker }.count
    let oldDefenders = before.cells.filter { $0 == .defender || $0 == .king }.count
    let newDefenders = after.cells.filter { $0 == .defender || $0 == .king }.count
    return (oldAttackers - newAttackers, oldDefenders - newDefenders)
}

private func moveAnnouncement(
    player: Player,
    move: Move,
    captured: [(row: Int, col: Int)],
    gameStatus: GameStatus
) -> String {
    let side = player == .attacker ? "Attacker" : "Defender"
    let from = "\(Position.columnLetter(move.fromCol))\(move.fromRow + 1)"
    let to = "\(Position.columnLetter(move.toCol))\(move.toRow + 1)"
    var text = "\(side) moved \(from) to \(to)"
    if !captured.isEmpty {
        let captureCoords = captured.map { "\(Position.columnLetter($0.col))\($0.row + 1)" }
        text += ". Capture at \(captureCoords.joined(separator: ", "))"
    }
    if gameStatus != .inProgress {
        switch gameStatus {
        case .defenderWins: text += ". Defenders win!"
        case .attackerWins: text += ". Attackers win!"
        case .draw: text += ". Draw!"
        default: break
        }
    }
    return text
}

private func reduceUndo(state: GameState) -> GameState {
    guard let previous = state.undoStack.last else { return state }
    var newUndoStack = state.undoStack
    newUndoStack.removeLast()

    if case .humanVsAI = state.aiMode, let humanPrevious = newUndoStack.last {
        newUndoStack.removeLast()
        var newCaptureHistory = state.captureHistory
        if !newCaptureHistory.isEmpty { newCaptureHistory.removeLast() }
        if !newCaptureHistory.isEmpty { newCaptureHistory.removeLast() }
        return GameState(
            game: humanPrevious.game,
            selectedSquare: nil,
            legalMovesForSelected: [],
            attackersCaptured: humanPrevious.attackersCaptured,
            defendersCaptured: humanPrevious.defendersCaptured,
            undoStack: newUndoStack,
            aiMode: state.aiMode,
            muted: state.muted,
            captureHistory: newCaptureHistory,
            aiDifficulty: state.aiDifficulty,
            boardFlipped: state.boardFlipped,
            showRules: state.showRules,
            replayStep: state.replayStep
        )
    }

    var newCaptureHistory = state.captureHistory
    if !newCaptureHistory.isEmpty { newCaptureHistory.removeLast() }
    return GameState(
        game: previous.game,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: previous.attackersCaptured,
        defendersCaptured: previous.defendersCaptured,
        undoStack: newUndoStack,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: newCaptureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
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
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
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
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
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
        aiMode: newMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: state.replayStep
    )
}

private func reduceToggleRules(state: GameState) -> GameState {
    GameState(
        game: state.game,
        selectedSquare: state.selectedSquare,
        legalMovesForSelected: state.legalMovesForSelected,
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        focusedSquare: state.focusedSquare,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: !state.showRules,
        replayStep: state.replayStep
    )
}

private func reduceEnterReplay(state: GameState) -> GameState {
    let lastStep = state.game.positionHistory.count - 1
    return GameState(
        game: state.game,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: max(0, lastStep)
    )
}

private func reduceExitReplay(state: GameState) -> GameState {
    GameState(
        game: state.game,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: nil
    )
}

private func reduceReplayForward(state: GameState) -> GameState {
    guard let current = state.replayStep else { return state }
    let maxStep = state.game.positionHistory.count - 1
    let next = min(current + 1, maxStep)
    return GameState(
        game: state.game,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: next
    )
}

private func reduceReplayBack(state: GameState) -> GameState {
    guard let current = state.replayStep else { return state }
    let prev = max(current - 1, 0)
    return GameState(
        game: state.game,
        selectedSquare: nil,
        legalMovesForSelected: [],
        attackersCaptured: state.attackersCaptured,
        defendersCaptured: state.defendersCaptured,
        undoStack: state.undoStack,
        aiMode: state.aiMode,
        muted: state.muted,
        captureHistory: state.captureHistory,
        aiDifficulty: state.aiDifficulty,
        boardFlipped: state.boardFlipped,
        showRules: state.showRules,
        replayStep: prev
    )
}
