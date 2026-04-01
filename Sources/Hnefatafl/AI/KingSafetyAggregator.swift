enum KingSafetyAggregator {
    static func compute(position: Position, player: Player) -> Int {
        // Base king safety
        let result = KingSafety.analyze(position: position)
        let baseSafety = result.escapeRoutes - result.adjacentThreats

        // King mobility and freedom
        let kingMob = KingMobility.moveCount(position: position)
        let freedom = KingFreedomIndex.compute(position: position)
        let distToCorner = KingDistanceToCorner.minDistance(position: position)
        let ringStr = KingProtectionRing.ringStrength(position: position)
        let pathCplx = KingPathComplexity.complexity(position: position)
        let flightCount = KingFlightSquare.flightSquareCount(position: position)
        let corridors = KingCorridorScan.clearCorridors(position: position)
        let shortestPath = KingEscapePath.shortestPathLength(position: position) ?? 20

        // Escape analysis
        let escRoutes = EscapeRouteCounter.count(position: position)
        let laneSc = EscapeLaneEval.laneScore(position: position)
        let coverageSc = EscapeCornerCoverage.coverageScore(position: position)
        let blockers = EscapePathBlocker.blockingPieces(position: position)

        // Corner analysis
        let cornerProx = CornerProximity.score(position: position)
        let cornerProxEval = CornerProximityEval.evaluate(position: position)
        let approach = CornerApproach.approachScore(position: position)
        let cornerCtrl = CornerControl.cornerAttackerPresence(position: position)
        let guardStr = CornerGuardEval.cornerGuardStrength(position: position)

        // Encirclement and confinement
        let encirclement = EncirclementScore.score(position: position)
        let confinement = ConfinementScore.confinementLevel(position: position)

        // Safety zone
        let safetyZone = KingSafetyZone.safetyScore(position: position)

        // Combine: positive = safer king = favors defender
        let escapeFactor = (kingMob + freedom.score / 2 + flightCount + corridors + escRoutes + laneSc / 2) / 6
        let proximityFactor = (cornerProx + cornerProxEval + approach) / 3
        let threatFactor = (cornerCtrl + guardStr + blockers + encirclement + confinement) / 5
        let pathFactor = (20 - shortestPath) + coverageSc / 2 - pathCplx / 3

        // Defender perspective: safe king + high escape = positive
        let defenderSafety = baseSafety + escapeFactor + proximityFactor / 2 + ringStr / 2 + safetyZone / 3 + pathFactor / 3 - threatFactor / 2 - (10 - distToCorner)

        switch player {
        case .attacker:
            return -defenderSafety
        case .defender:
            return defenderSafety
        }
    }
}
