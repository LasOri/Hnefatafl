enum MobilityAggregator {
    static func compute(position: Position, player: Player) -> Int {
        // Base mobility from MobilityScore
        let mobility = MobilityScore.compute(position: position)
        let baseRatio: Int
        switch player {
        case .attacker:
            baseRatio = mobility.ratio
        case .defender:
            baseRatio = -mobility.ratio
        }

        // Sub-modules
        let mobDiff = MobilityDifference.compute(position: position)
        let activity = PieceActivityScore.compute(position: position, player: player)
        let oppActivity = PieceActivityScore.compute(
            position: position,
            player: player == .attacker ? .defender : .attacker
        )
        let atkMob = AttackerMobility.totalMobility(position: position)
        let defMob = DefenderMobility.totalMobility(position: position)
        let space = SpaceAdvantage.reachableSquares(position: position, player: player)
        let oppSpace = SpaceAdvantage.reachableSquares(
            position: position,
            player: player == .attacker ? .defender : .attacker
        )
        let pressure = SpacePressure.spaceControl(position: position, player: player)
        let flex = FlexibilityScore.score(position: position, player: player)
        let reach = DefenderReach.totalReach(position: position)

        // Normalize mobility difference (attacker-positive)
        let mobDiffAdj: Int
        switch player {
        case .attacker:
            mobDiffAdj = mobDiff
        case .defender:
            mobDiffAdj = -mobDiff
        }

        // Combine attacker/defender mobility
        let rawMobAdj: Int
        switch player {
        case .attacker:
            rawMobAdj = atkMob - defMob
        case .defender:
            rawMobAdj = defMob - atkMob + reach / 3
        }

        let activityDiff = activity - oppActivity
        let spaceDiff = space - oppSpace

        let subSignal = (mobDiffAdj + rawMobAdj / 3 + activityDiff / 2 + spaceDiff / 3 + pressure / 3 + flex / 3) / 6

        return baseRatio + subSignal / 4
    }
}
