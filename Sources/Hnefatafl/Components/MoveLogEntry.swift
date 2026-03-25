struct MoveLogEntry: Equatable {
    let moveNumber: Int
    let player: Player
    let move: Move
    let isCapture: Bool

    var notation: String {
        let colLetters = "ABCDEFGHIJK"
        let fromColLetter = String(colLetters[colLetters.index(colLetters.startIndex, offsetBy: move.fromCol)])
        let fromRowLabel = "\(move.fromRow + 1)"
        let toColLetter = String(colLetters[colLetters.index(colLetters.startIndex, offsetBy: move.toCol)])
        let toRowLabel = "\(move.toRow + 1)"
        return "\(moveNumber). \(fromColLetter)\(fromRowLabel)-\(toColLetter)\(toRowLabel)"
    }
}
