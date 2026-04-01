struct EvalWeights: Equatable {
    let material: Int
    let mobility: Int
    let kingSafety: Int
    let territory: Int
    let position: Int

    init(material: Int = 40, mobility: Int = 20, kingSafety: Int = 20, territory: Int = 10, position: Int = 10) {
        self.material = material
        self.mobility = mobility
        self.kingSafety = kingSafety
        self.territory = territory
        self.position = position
    }

    func apply(material: Int, mobility: Int, kingSafety: Int, territory: Int, position: Int) -> Int {
        material * self.material + mobility * self.mobility + kingSafety * self.kingSafety + territory * self.territory + position * self.position
    }

    static let aggressive = EvalWeights(material: 50, mobility: 20, kingSafety: 10, territory: 10, position: 10)
    static let defensive = EvalWeights(material: 30, mobility: 15, kingSafety: 30, territory: 15, position: 10)

    func adjustedForPhase(_ phase: GamePhase) -> EvalWeights {
        switch phase {
        case .opening:
            // Opening: emphasize mobility and territory control
            return EvalWeights(
                material: material,
                mobility: mobility + 10,
                kingSafety: kingSafety,
                territory: territory + 10,
                position: position
            )
        case .midgame:
            // Midgame: balanced, use base weights as-is
            return self
        case .endgame:
            // Endgame: king safety and position (corner proximity) become critical
            return EvalWeights(
                material: material - 10,
                mobility: mobility,
                kingSafety: kingSafety + 15,
                territory: territory,
                position: position + 15
            )
        }
    }
}
