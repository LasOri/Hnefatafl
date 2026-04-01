enum EvaluationPipeline {
    static func evaluate(position: Position, player: Player, weights: EvalWeights) -> Int {
        // Material: defender piece count minus attacker piece count (defender-biased)
        let material = position.defenderCount - position.attackerCount

        // Mobility: defender moves minus attacker moves (defender-biased)
        let mobility = MobilityScore.compute(position: position)
        let mobilityScore = mobility.defenderMoves - mobility.attackerMoves

        // King safety: escape routes as positive score for defender
        let safety = KingSafety.analyze(position: position)
        let kingSafetyScore = safety.escapeRoutes - safety.adjacentThreats

        // Territory: negate TerritoryBalance since it returns attacker - defender
        let territoryScore = -TerritoryBalance.evaluate(position: position)

        // Position: king corner proximity (good for defender)
        let positionScore = CornerProximity.score(position: position)

        // Combine using weights
        let defenderScore = weights.apply(
            material: material,
            mobility: mobilityScore,
            kingSafety: kingSafetyScore,
            territory: territoryScore,
            position: positionScore
        )

        // Formation bonus: connectivity favors the side with better structure
        let defenderFormation = FormationAnalyzer.score(position: position, player: .defender)
        let attackerFormation = FormationAnalyzer.score(position: position, player: .attacker)
        let formationBonus = defenderFormation - attackerFormation

        // Shield wall penalty: threats against defenders on edges
        let shieldWallPenalty = ShieldWallEval.shieldWallThreats(position: position) * 3

        // Attacker ring pressure penalty for defender
        let ringPressure = AttackerFormation.total(position: position)

        let totalDefenderScore = defenderScore + formationBonus - shieldWallPenalty - ringPressure

        // Return from the requested player's perspective
        switch player {
        case .defender:
            return totalDefenderScore
        case .attacker:
            return -totalDefenderScore
        }
    }
}
