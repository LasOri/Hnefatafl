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
}
