struct MoveNotationDisplay {
    static func columnLabel(_ col: Int) -> String {
        String(UnicodeScalar(65 + col)!)
    }

    static func rowLabel(_ row: Int) -> String {
        String(row + 1)
    }

    static func algebraic(_ move: Move) -> String {
        "\(columnLabel(move.fromCol))\(rowLabel(move.fromRow))-\(columnLabel(move.toCol))\(rowLabel(move.toRow))"
    }

    static func coordinate(_ move: Move) -> String {
        "\(columnLabel(move.fromCol))\(rowLabel(move.fromRow)) to \(columnLabel(move.toCol))\(rowLabel(move.toRow))"
    }

    static func compact(_ move: Move) -> String {
        "\(columnLabel(move.fromCol))\(rowLabel(move.fromRow))\(columnLabel(move.toCol))\(rowLabel(move.toRow))"
    }

    static func pair(number: Int, attacker: Move, defender: Move?) -> String {
        var result = "\(number). \(algebraic(attacker))"
        if let def = defender {
            result += " \(algebraic(def))"
        }
        return result
    }

    static func gameNotation(moves: [Move]) -> String {
        var lines: [String] = []
        var i = 0
        var moveNum = 1
        while i < moves.count {
            let attacker = moves[i]
            let defender = i + 1 < moves.count ? moves[i + 1] : nil
            lines.append(pair(number: moveNum, attacker: attacker, defender: defender))
            moveNum += 1
            i += 2
        }
        return lines.joined(separator: "\n")
    }
}
