struct IncrementalState: Equatable {
    var materialScore: Int
    var mobilityEstimate: Int
    var total: Int { materialScore + mobilityEstimate }
}

enum IncrementalEval {
    static func initial(position: Position, player: Player) -> IncrementalState {
        let mat: Int
        switch player {
        case .attacker: mat = position.attackerCount - position.defenderCount
        case .defender: mat = position.defenderCount - position.attackerCount
        }
        return IncrementalState(materialScore: mat * 100, mobilityEstimate: 0)
    }

    static func update(state: IncrementalState, captures: Int, mobilityDelta: Int) -> IncrementalState {
        IncrementalState(
            materialScore: state.materialScore + captures * 100,
            mobilityEstimate: state.mobilityEstimate + mobilityDelta
        )
    }
}
