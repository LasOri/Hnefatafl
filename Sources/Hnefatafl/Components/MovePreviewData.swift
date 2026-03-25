struct MovePreviewData: Equatable {
    let move: Move
    let isCapture: Bool
    let capturedPositions: [(row: Int, col: Int)]

    var captureCount: Int {
        capturedPositions.count
    }

    static func == (lhs: MovePreviewData, rhs: MovePreviewData) -> Bool {
        guard lhs.move == rhs.move &&
              lhs.isCapture == rhs.isCapture &&
              lhs.capturedPositions.count == rhs.capturedPositions.count else {
            return false
        }

        for i in 0..<lhs.capturedPositions.count {
            if lhs.capturedPositions[i].row != rhs.capturedPositions[i].row ||
               lhs.capturedPositions[i].col != rhs.capturedPositions[i].col {
                return false
            }
        }

        return true
    }
}
