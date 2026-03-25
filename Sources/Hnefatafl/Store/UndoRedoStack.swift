struct UndoRedoStack<T> {
    private var undoStack: [T] = []
    private var redoStack: [T] = []

    var canUndo: Bool { !undoStack.isEmpty }
    var canRedo: Bool { !redoStack.isEmpty }
    var undoCount: Int { undoStack.count }
    var redoCount: Int { redoStack.count }

    mutating func push(_ value: T) {
        undoStack.append(value)
        redoStack.removeAll()
    }

    mutating func undo() -> T? {
        guard let value = undoStack.popLast() else { return nil }
        redoStack.append(value)
        return value
    }

    mutating func redo() -> T? {
        guard let value = redoStack.popLast() else { return nil }
        undoStack.append(value)
        return value
    }
}
