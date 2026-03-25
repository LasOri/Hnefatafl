struct EvalWeight: Equatable {
    let name: String
    let value: Int
    let multiplier: Int
    var contribution: Int { value * multiplier }
}

enum WeightedEval {
    static func evaluate(position: Position, player: Player, weights: [String: Int]) -> Int {
        var terms: [EvalWeight] = []
        let material: Int
        switch player {
        case .attacker: material = position.attackerCount - position.defenderCount
        case .defender: material = position.defenderCount - position.attackerCount
        }
        terms.append(EvalWeight(name: "material", value: material, multiplier: weights["material"] ?? 100))
        let mobility = position.allLegalMoves(for: player).count
        let opponent: Player = player == .attacker ? .defender : .attacker
        let oppMobility = position.allLegalMoves(for: opponent).count
        terms.append(EvalWeight(name: "mobility", value: mobility - oppMobility, multiplier: weights["mobility"] ?? 10))
        return terms.map(\.contribution).reduce(0, +)
    }
}
