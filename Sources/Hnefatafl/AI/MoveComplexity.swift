enum MoveComplexity {
    static func branchingFactor(position: Position, player: Player) -> Int {
        position.allLegalMoves(for: player).count
    }

    static func positionComplexity(position: Position) -> Int {
        let atkMoves = position.allLegalMoves(for: .attacker).count
        let defMoves = position.allLegalMoves(for: .defender).count
        return atkMoves + defMoves
    }

    static func isSimple(position: Position, threshold: Int = 30) -> Bool {
        positionComplexity(position: position) < threshold
    }
}
