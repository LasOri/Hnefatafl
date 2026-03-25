struct Heatmap: Equatable {
    let values: [Double]

    var maxValue: Double {
        values.max() ?? 0.0
    }
}

struct BoardHeatmap {
    static func generate(position: Position, for player: Player) -> Heatmap {
        let threatMap = ThreatMap.compute(position: position, for: player)
        let maxThreat = threatMap.max() ?? 0
        guard maxThreat > 0 else {
            return Heatmap(values: Array(repeating: 0.0, count: threatMap.count))
        }
        let normalized = threatMap.map { Double($0) / Double(maxThreat) }
        return Heatmap(values: normalized)
    }

    static func color(for value: Double) -> String {
        let r = Int(value * 255)
        let b = Int((1.0 - value) * 255)
        return "rgba(\(r), 0, \(b), 0.4)"
    }
}
