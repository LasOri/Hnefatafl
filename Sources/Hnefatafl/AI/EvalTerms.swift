struct EvalTerm: Equatable {
    let name: String
    let value: Int
    let weight: Int
    var weighted: Int { value * weight }
}

struct EvalBreakdown: Equatable {
    let terms: [EvalTerm]
    var total: Int { terms.map(\.weighted).reduce(0, +) }
}

enum EvalTerms {
    static func breakdown(position: Position, player: Player) -> EvalBreakdown {
        let material: Int
        switch player {
        case .attacker: material = position.attackerCount - position.defenderCount
        case .defender: material = position.defenderCount - position.attackerCount
        }

        let mobility = position.allLegalMoves(for: player).count
        let opponent: Player = player == .attacker ? .defender : .attacker
        let opponentMobility = position.allLegalMoves(for: opponent).count
        let mobilityDiff = mobility - opponentMobility

        return EvalBreakdown(terms: [
            EvalTerm(name: "material", value: material, weight: 100),
            EvalTerm(name: "mobility", value: mobilityDiff, weight: 10)
        ])
    }
}
