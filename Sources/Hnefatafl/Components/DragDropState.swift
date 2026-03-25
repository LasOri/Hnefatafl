struct DragDropState: Equatable {
    var isDragging: Bool
    var sourceRow: Int?
    var sourceCol: Int?
    var currentRow: Int?
    var currentCol: Int?

    var isValidDrag: Bool {
        sourceRow != nil && sourceCol != nil && currentRow != nil && currentCol != nil
    }

    static let idle = DragDropState(
        isDragging: false,
        sourceRow: nil,
        sourceCol: nil,
        currentRow: nil,
        currentCol: nil
    )
}
