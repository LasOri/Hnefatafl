struct OpeningSuggestion: Equatable {
    let name: String
    let previewMoves: [Move]
}

struct OpeningExplorer {
    static func suggest(moveHistory: [Move]) -> [OpeningSuggestion] {
        if moveHistory.isEmpty {
            return OpeningBook.allOpenings.map {
                OpeningSuggestion(name: $0.name, previewMoves: $0.moves)
            }
        }

        return OpeningBook.allOpenings.compactMap { opening in
            guard opening.moves.count >= moveHistory.count else { return nil }
            let prefix = Array(opening.moves.prefix(moveHistory.count))
            guard prefix == moveHistory else { return nil }
            let remaining = Array(opening.moves.suffix(from: moveHistory.count))
            return OpeningSuggestion(name: opening.name, previewMoves: remaining)
        }
    }
}
