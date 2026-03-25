enum PuzzleCategory: Equatable {
    case kingEscape
    case capture
    case fork
    case blockade
    case endgame
}

struct TacticalPuzzle: Equatable {
    let title: String
    let description: String
    let position: Position
    let playerToMove: Player
    let solutionMove: Move?
    let solutionMoves: [Move]
    let category: PuzzleCategory
    let difficulty: Int

    func checkSolution(_ move: Move) -> Bool {
        if let solution = solutionMove {
            return move == solution
        }
        return solutionMoves.contains(move)
    }

    static func puzzles(for category: PuzzleCategory) -> [TacticalPuzzle] {
        allPuzzles.filter { $0.category == category }
    }

    static let allPuzzles: [TacticalPuzzle] = [
        kingEscapePuzzle(),
        capturePuzzle(),
        forkPuzzle(),
        blockadePuzzle(),
        endgamePuzzle(),
    ]

    private static func kingEscapePuzzle() -> TacticalPuzzle {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[1 * 11 + 0] = .king
        cells[2 * 11 + 0] = .attacker
        cells[1 * 11 + 2] = .attacker

        return TacticalPuzzle(
            title: "King to Corner",
            description: "The king can escape to the corner in one move",
            position: Position(cells: cells),
            playerToMove: .defender,
            solutionMove: Move(fromRow: 1, fromCol: 0, toRow: 0, toCol: 0),
            solutionMoves: [],
            category: .kingEscape,
            difficulty: 1
        )
    }

    private static func capturePuzzle() -> TacticalPuzzle {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 2] = .attacker
        cells[5 * 11 + 4] = .defender
        cells[5 * 11 + 6] = .attacker
        cells[5 * 11 + 0] = .king

        return TacticalPuzzle(
            title: "Custodial Capture",
            description: "Move an attacker next to the defender to capture it",
            position: Position(cells: cells),
            playerToMove: .attacker,
            solutionMove: Move(fromRow: 5, fromCol: 2, toRow: 5, toCol: 3),
            solutionMoves: [],
            category: .capture,
            difficulty: 2
        )
    }

    private static func forkPuzzle() -> TacticalPuzzle {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[2 * 11 + 4] = .attacker
        cells[4 * 11 + 2] = .defender
        cells[4 * 11 + 6] = .defender
        cells[6 * 11 + 4] = .attacker
        cells[8 * 11 + 0] = .king

        return TacticalPuzzle(
            title: "Fork Attack",
            description: "Find the move that threatens two defenders at once",
            position: Position(cells: cells),
            playerToMove: .attacker,
            solutionMove: Move(fromRow: 2, fromCol: 4, toRow: 4, toCol: 4),
            solutionMoves: [],
            category: .fork,
            difficulty: 3
        )
    }

    private static func blockadePuzzle() -> TacticalPuzzle {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[0 * 11 + 1] = .king
        cells[1 * 11 + 0] = .attacker
        cells[1 * 11 + 1] = .attacker
        cells[0 * 11 + 3] = .attacker

        return TacticalPuzzle(
            title: "Block the Escape",
            description: "Move to block the king's escape route",
            position: Position(cells: cells),
            playerToMove: .attacker,
            solutionMove: Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 2),
            solutionMoves: [],
            category: .blockade,
            difficulty: 2
        )
    }

    private static func endgamePuzzle() -> TacticalPuzzle {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[8 * 11 + 9] = .king
        cells[9 * 11 + 10] = .attacker
        cells[10 * 11 + 9] = .attacker

        return TacticalPuzzle(
            title: "Endgame Escape",
            description: "King must find a path to a corner with few pieces on the board",
            position: Position(cells: cells),
            playerToMove: .defender,
            solutionMove: Move(fromRow: 8, fromCol: 9, toRow: 0, toCol: 9),
            solutionMoves: [],
            category: .endgame,
            difficulty: 3
        )
    }
}
