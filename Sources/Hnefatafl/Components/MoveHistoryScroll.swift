struct MoveHistoryScroll: Equatable {
    let moves: [Move]
    let visibleStart: Int
    let visibleCount: Int

    var visibleMoves: [Move] {
        let end = min(visibleStart + visibleCount, moves.count)
        guard visibleStart < moves.count else { return [] }
        return Array(moves[visibleStart..<end])
    }

    var canScrollDown: Bool {
        visibleStart + visibleCount < moves.count
    }
}
