enum PersonalityDrivenEval {
    static func evaluate(position: Position, player: Player, personality: AIPersonality) -> Int {
        let material = MaterialAggregator.compute(position: position, player: player)
        let mobility = MobilityAggregator.compute(position: position, player: player)
        let kingSafety = KingSafetyAggregator.compute(position: position, player: player)
        let territory = TerritoryAggregator.compute(position: position, player: player)
        let positionScore = PositionAggregator.compute(position: position, player: player)

        // Adjust weights based on game phase
        let phase = EndgameDetector.phase(position: position)
        let adjustedWeights = personality.weights.adjustedForPhase(phase)

        let base = adjustedWeights.apply(
            material: material,
            mobility: mobility,
            kingSafety: kingSafety,
            territory: territory,
            position: positionScore
        )

        // Formation bonus from perspective of current player
        let formationMe = FormationAnalyzer.score(position: position, player: player)
        let opponent: Player = player == .attacker ? .defender : .attacker
        let formationOpp = FormationAnalyzer.score(position: position, player: opponent)
        let formationBonus = formationMe - formationOpp

        // Shield wall: threats against defenders penalize defender
        let shieldWall = ShieldWallEval.shieldWallThreats(position: position) * 3
        let shieldWallAdjusted = player == .defender ? -shieldWall : shieldWall

        // Tactical aggregator bonus
        let tactical = TacticalAggregator.compute(position: position, player: player)

        return base + formationBonus + shieldWallAdjusted + tactical
    }
}
