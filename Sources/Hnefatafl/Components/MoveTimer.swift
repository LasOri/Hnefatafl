struct MoveTimer: Equatable {
    private var times: [Double] = []
    var elapsed: Double = 0

    var totalTime: Double { times.reduce(0, +) }
    var moveCount: Int { times.count }
    var longestMove: Double { times.max() ?? 0 }

    var averageTime: Double {
        guard !times.isEmpty else { return 0 }
        return totalTime / Double(times.count)
    }

    mutating func record(seconds: Double) {
        times.append(seconds)
    }
}
