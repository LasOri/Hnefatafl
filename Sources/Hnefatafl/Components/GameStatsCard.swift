import LINKER

struct GameStatsCard: Equatable {
    var totalMoves: Int
    var captureCount: Int
    var averageMoveTime: Double

    var moveRateText: String {
        if averageMoveTime <= 0 {
            return "N/A"
        }
        let rate = 60.0 / averageMoveTime
        return "\(formatDecimal(rate, decimals: 1)) moves/min"
    }
}
