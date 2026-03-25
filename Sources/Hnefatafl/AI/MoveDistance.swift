enum MoveDistance {
    static func manhattan(_ move: Move) -> Int {
        abs(move.toRow - move.fromRow) + abs(move.toCol - move.fromCol)
    }

    static func averageMoveDistance(moves: [Move]) -> Double {
        guard !moves.isEmpty else { return 0 }
        return Double(moves.map { manhattan($0) }.reduce(0, +)) / Double(moves.count)
    }

    static func maxDistance(moves: [Move]) -> Int {
        moves.map { manhattan($0) }.max() ?? 0
    }
}
