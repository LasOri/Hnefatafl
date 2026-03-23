import LINKER

struct BoardComponent {
    static func render(state: GameState) -> [AnyNode] {
        var rows: [AnyNode] = []

        rows.append(contentsOf: columnLabelRow())

        for row in 0..<Position.boardSize {
            let rowLabel = Element<AnyHTMLContext>(
                tag: "span",
                attributes: [Attribute(name: "class", value: "coord-label")],
                children: [AnyNode(Text("\(row + 1)"))]
            )
            var cells: [AnyNode] = [AnyNode(rowLabel)]
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
                Attribute(name: "class", value: "board viking-theme"),
                Attribute(name: "role", value: "grid"),
                Attribute(name: "aria-label", value: "Hnefatafl game board")
            ],
            children: rows + overlayNodes(state: state)
        )
        return [AnyNode(board)]
    }

    private static func columnLabelRow() -> [AnyNode] {
        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"]
        let spacer = Element<AnyHTMLContext>(
            tag: "span",
            attributes: [Attribute(name: "class", value: "coord-label")],
            children: []
        )
        var nodes: [AnyNode] = [AnyNode(spacer)]
        for letter in letters {
            let label = Element<AnyHTMLContext>(
                tag: "span",
                attributes: [Attribute(name: "class", value: "coord-label")],
                children: [AnyNode(Text(letter))]
            )
            nodes.append(AnyNode(label))
        }
        let headerRow = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "coord-row")],
            children: nodes
        )
        return [AnyNode(headerRow)]
    }

    private static func overlayNodes(state: GameState) -> [AnyNode] {
        var overlays: [AnyNode] = []
        if let lastMove = state.lastMove {
            overlays.append(contentsOf: MoveTrail.render(move: lastMove))
        }
        for square in state.capturedSquares {
            overlays.append(contentsOf: CaptureEffect.render(row: square.row, col: square.col))
        }
        return overlays
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

        if isSelected {
            classes.append("selected")
            classes.append("glow")
        }
        if isLegalMove {
            classes.append("legal-move")
            classes.append("move-indicator")
        }
        if state.focusedSquare?.row == row && state.focusedSquare?.col == col {
            classes.append("focused")
        }

        let ariaLabel = squareAriaLabel(piece: piece, row: row, col: col)
        let children: [AnyNode] = piece.map { PieceView.render(piece: $0) } ?? []

        return Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: classes.joined(separator: " ")),
                Attribute(name: "data-row", value: "\(row)"),
                Attribute(name: "data-col", value: "\(col)"),
                Attribute(name: "data-action", value: "square-click"),
                Attribute(name: "role", value: "gridcell"),
                Attribute(name: "aria-label", value: ariaLabel),
                Attribute(name: "tabindex", value: (state.focusedSquare?.row == row && state.focusedSquare?.col == col) ? "0" : "-1")
            ],
            children: children
        )
    }

    private static func squareAriaLabel(piece: Piece?, row: Int, col: Int) -> String {
        let coord = "\(Position.columnLetter(col))\(row + 1)"

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
