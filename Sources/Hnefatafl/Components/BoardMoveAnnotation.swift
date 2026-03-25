struct BoardMoveAnnotation: Equatable {
    let row: Int
    let col: Int
    let text: String
    let color: String

    static func fromMoveQuality(row: Int, col: Int, quality: String) -> BoardMoveAnnotation {
        let text: String
        let color: String

        switch quality {
        case "brilliant":
            text = "!!"
            color = "#00c853"
        case "good":
            text = "!"
            color = "#2196f3"
        case "interesting":
            text = "!?"
            color = "#9c27b0"
        case "dubious":
            text = "?!"
            color = "#ff9800"
        case "mistake":
            text = "?"
            color = "#f44336"
        case "blunder":
            text = "??"
            color = "#b71c1c"
        default:
            text = quality
            color = "#757575"
        }

        return BoardMoveAnnotation(row: row, col: col, text: text, color: color)
    }
}
