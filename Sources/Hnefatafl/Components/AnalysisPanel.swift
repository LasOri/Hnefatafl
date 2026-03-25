struct AnalysisData: Equatable {
    let evaluation: Int
    let bestMove: String?
    let depth: Int
    let phase: String
}

enum AnalysisPanel {
    static func data(evaluation: Int, bestMove: Move?, depth: Int, position: Position) -> AnalysisData {
        let phase = EndgameDetector.phase(position: position)
        let phaseStr: String
        switch phase {
        case .opening: phaseStr = "Opening"
        case .midgame: phaseStr = "Midgame"
        case .endgame: phaseStr = "Endgame"
        }
        let moveStr: String?
        if let m = bestMove {
            let fc = String(UnicodeScalar(97 + m.fromCol)!)
            let tc = String(UnicodeScalar(97 + m.toCol)!)
            moveStr = "\(fc)\(Position.boardSize - m.fromRow)-\(tc)\(Position.boardSize - m.toRow)"
        } else {
            moveStr = nil
        }
        return AnalysisData(evaluation: evaluation, bestMove: moveStr, depth: depth, phase: phaseStr)
    }
}
