struct FeatureVector: Equatable {
    let features: [Double]
    var count: Int { features.count }
    subscript(index: Int) -> Double { features[index] }
}

enum PositionFeatures {
    static func extract(position: Position) -> FeatureVector {
        let atkCount = Double(position.attackerCount)
        let defCount = Double(position.defenderCount)
        let totalPieces = atkCount + defCount
        let materialRatio = totalPieces > 0 ? atkCount / totalPieces : 0
        let atkMobility = Double(position.allLegalMoves(for: .attacker).count)
        let defMobility = Double(position.allLegalMoves(for: .defender).count)
        let totalMobility = atkMobility + defMobility
        let mobilityRatio = totalMobility > 0 ? atkMobility / totalMobility : 0

        return FeatureVector(features: [
            atkCount, defCount, materialRatio, atkMobility, defMobility, mobilityRatio
        ])
    }
}
