struct AIStrengthMeter: Equatable {
    let depth: Int
    let personality: AIPersonality

    var level: Int {
        switch depth {
        case 0...2: return 1
        case 3...5: return 2
        default: return 3
        }
    }

    var label: String {
        let levelName = ["Beginner", "Intermediate", "Advanced"][level - 1]
        return "Level \(level): \(levelName)"
    }

    var percentage: Double {
        Double(level) / 3.0 * 100.0
    }

    var cssWidth: String {
        "\(percentage)%"
    }
}
