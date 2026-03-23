import LINKER

struct BoardComponent {
    static func render(state: GameState) -> [AnyNode] {
        var rows: [AnyNode] = []
        for row in 0..<Position.boardSize {
            var cells: [AnyNode] = []
            for col in 0..<Position.boardSize {
                cells.append(AnyNode(squareElement(state: state, row: row, col: col)))
            }
            let rowElement = Element<AnyHTMLContext>(
                tag: "div",
                attributes: [
                    Attribute(name: "class", value: "board-row"),
                    Attribute(name: "role", value: "row")
                ],
                children: cells
            )
            rows.append(AnyNode(rowElement))
        }
        let board = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "board"),
                Attribute(name: "role", value: "grid"),
                Attribute(name: "aria-label", value: "Hnefatafl game board")
            ],
            children: rows
        )
        return [AnyNode(board)]
    }

    private static func squareElement(state: GameState, row: Int, col: Int) -> Element<AnyHTMLContext> {
        let piece = state.game.position.pieceAt(row: row, col: col)
        let squareType = Position.squareType(row: row, col: col)
        let isSelected = state.selectedSquare?.row == row && state.selectedSquare?.col == col
        let isLegalMove = state.legalMovesForSelected.contains { $0.toRow == row && $0.toCol == col }

        var classes = ["square"]

        switch squareType {
        case .corner: classes.append("square-corner")
        case .throne: classes.append("square-throne")
        case .regular: break
        }

        if let piece {
            switch piece {
            case .attacker: classes.append("piece-attacker")
            case .defender: classes.append("piece-defender")
            case .king: classes.append("piece-king")
            }
        }

        if isSelected { classes.append("selected") }
        if isLegalMove { classes.append("legal-move") }

        let ariaLabel = squareAriaLabel(piece: piece, row: row, col: col)

        return Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: classes.joined(separator: " ")),
                Attribute(name: "data-row", value: "\(row)"),
                Attribute(name: "data-col", value: "\(col)"),
                Attribute(name: "data-action", value: "square-click"),
                Attribute(name: "role", value: "gridcell"),
                Attribute(name: "aria-label", value: ariaLabel),
                Attribute(name: "tabindex", value: (row == 0 && col == 0) ? "0" : "-1")
            ],
            children: []
        )
    }

    private static func squareAriaLabel(piece: Piece?, row: Int, col: Int) -> String {
        let colLetter = String(UnicodeScalar(65 + col)!)
        let rowNumber = "\(row + 1)"
        let coord = "\(colLetter)\(rowNumber)"

        if let piece {
            switch piece {
            case .attacker: return "Attacker at \(coord)"
            case .defender: return "Defender at \(coord)"
            case .king: return "King at \(coord)"
            }
        }

        let squareType = Position.squareType(row: row, col: col)
        switch squareType {
        case .corner: return "Corner \(coord)"
        case .throne: return "Throne \(coord)"
        case .regular: return "Empty \(coord)"
        }
    }
}
