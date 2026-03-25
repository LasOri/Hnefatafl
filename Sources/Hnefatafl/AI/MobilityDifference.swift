enum MobilityDifference {
    static func compute(position: Position) -> Int {
        let atkMoves = position.allLegalMoves(for: .attacker).count
        let defMoves = position.allLegalMoves(for: .defender).count
        return atkMoves - defMoves
    }

    static func ratio(position: Position) -> Double {
        let atk = Double(position.allLegalMoves(for: .attacker).count)
        let def = Double(position.allLegalMoves(for: .defender).count)
        guard atk + def > 0 else { return 0 }
        return (atk - def) / (atk + def)
    }

    static func advantage(position: Position) -> Player? {
        let diff = compute(position: position)
        if diff > 10 { return .attacker }
        if diff < -10 { return .defender }
        return nil
    }
}
