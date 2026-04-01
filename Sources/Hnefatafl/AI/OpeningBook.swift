struct Opening: Equatable {
    let name: String
    let moves: [Move]
}

struct OpeningBook {
    static let allOpenings: [Opening] = [
        // === ATTACKER OPENINGS (4-move deep) ===
        Opening(name: "Diamond Attack", moves: [
            Move(fromRow: 0, fromCol: 5, toRow: 2, toCol: 5),  // A: top center forward
            Move(fromRow: 5, fromCol: 3, toRow: 2, toCol: 3),  // D: defender flanks
            Move(fromRow: 10, fromCol: 5, toRow: 8, toCol: 5), // A: bottom center forward
            Move(fromRow: 5, fromCol: 7, toRow: 8, toCol: 7),  // D: defender flanks
        ]),
        Opening(name: "Flank Rush", moves: [
            Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3),  // A: top-left forward
            Move(fromRow: 3, fromCol: 5, toRow: 3, toCol: 2),  // D: defender blocks
            Move(fromRow: 0, fromCol: 7, toRow: 2, toCol: 7),  // A: top-right forward
            Move(fromRow: 7, fromCol: 5, toRow: 7, toCol: 8),  // D: defender responds
        ]),
        Opening(name: "Central Press", moves: [
            Move(fromRow: 0, fromCol: 5, toRow: 3, toCol: 5),  // A: deep center push
            Move(fromRow: 5, fromCol: 4, toRow: 3, toCol: 4),  // D: defender blocks adjacent
            Move(fromRow: 10, fromCol: 5, toRow: 7, toCol: 5), // A: bottom mirror push
            Move(fromRow: 5, fromCol: 6, toRow: 7, toCol: 6),  // D: defender blocks adjacent
        ]),
        Opening(name: "Corner Guard", moves: [
            Move(fromRow: 0, fromCol: 3, toRow: 0, toCol: 1),  // A: guard top-left corner
            Move(fromRow: 4, fromCol: 4, toRow: 2, toCol: 4),  // D: defender advances
            Move(fromRow: 0, fromCol: 7, toRow: 0, toCol: 9),  // A: guard top-right corner
            Move(fromRow: 4, fromCol: 6, toRow: 2, toCol: 6),  // D: defender advances
        ]),
        Opening(name: "Pincer Opening", moves: [
            Move(fromRow: 0, fromCol: 7, toRow: 2, toCol: 7),  // A: right-side push
            Move(fromRow: 5, fromCol: 7, toRow: 2, toCol: 7),  // D: defender intercepts (this may not be legal if occupied)
        ]),

        // === NEW DEEPER LINES ===
        Opening(name: "Anvil Squeeze", moves: [
            Move(fromRow: 3, fromCol: 0, toRow: 3, toCol: 2),  // A: left wall advance
            Move(fromRow: 5, fromCol: 3, toRow: 3, toCol: 3),  // D: defender blocks
            Move(fromRow: 7, fromCol: 0, toRow: 7, toCol: 2),  // A: second left advance
            Move(fromRow: 5, fromCol: 4, toRow: 7, toCol: 4),  // D: defender responds
        ]),
        Opening(name: "Double Edge Press", moves: [
            Move(fromRow: 0, fromCol: 4, toRow: 2, toCol: 4),  // A: top near-center
            Move(fromRow: 4, fromCol: 5, toRow: 2, toCol: 5),  // D: defender blocks
            Move(fromRow: 10, fromCol: 6, toRow: 8, toCol: 6), // A: bottom near-center
            Move(fromRow: 6, fromCol: 5, toRow: 8, toCol: 5),  // D: defender blocks
        ]),
        Opening(name: "King Hunt", moves: [
            Move(fromRow: 1, fromCol: 5, toRow: 3, toCol: 5),  // A: advance toward king
            Move(fromRow: 3, fromCol: 5, toRow: 3, toCol: 8),  // D: defender retreats
            Move(fromRow: 9, fromCol: 5, toRow: 7, toCol: 5),  // A: close from bottom
            Move(fromRow: 7, fromCol: 5, toRow: 7, toCol: 8),  // D: defender retreats
        ]),
        Opening(name: "Wide Spread", moves: [
            Move(fromRow: 0, fromCol: 3, toRow: 2, toCol: 3),  // A: top-left forward
            Move(fromRow: 4, fromCol: 4, toRow: 2, toCol: 4),  // D: defender advances
            Move(fromRow: 5, fromCol: 0, toRow: 5, toCol: 2),  // A: left wall push
            Move(fromRow: 5, fromCol: 3, toRow: 5, toCol: 2),  // D: defender blocks (if legal)
        ]),

        // === DEFENDER RESPONSE LINES ===
        Opening(name: "King's Gambit", moves: [
            Move(fromRow: 0, fromCol: 5, toRow: 2, toCol: 5),  // A: standard top push
            Move(fromRow: 5, fromCol: 6, toRow: 2, toCol: 6),  // D: aggressive defender advance
            Move(fromRow: 10, fromCol: 5, toRow: 8, toCol: 5), // A: bottom push
            Move(fromRow: 5, fromCol: 5, toRow: 5, toCol: 8),  // D: king moves toward escape
        ]),
        Opening(name: "Fortress Defense", moves: [
            Move(fromRow: 0, fromCol: 5, toRow: 2, toCol: 5),  // A: top push
            Move(fromRow: 4, fromCol: 6, toRow: 3, toCol: 6),  // D: tighten formation
            Move(fromRow: 10, fromCol: 5, toRow: 8, toCol: 5), // A: bottom push
            Move(fromRow: 6, fromCol: 4, toRow: 7, toCol: 4),  // D: extend formation
        ]),
    ]

    static func detect(moves: [Move]) -> String? {
        guard !moves.isEmpty else { return nil }
        return allOpenings.first(where: { $0.moves == moves })?.name
    }

    static func detectPartial(moves: [Move]) -> [String] {
        guard !moves.isEmpty else { return [] }
        return allOpenings.filter { opening in
            guard opening.moves.count >= moves.count else { return false }
            return Array(opening.moves.prefix(moves.count)) == moves
        }.map(\.name)
    }
}
