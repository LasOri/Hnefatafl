import Testing
@testable import Hnefatafl

@Suite("Undo Redo Stack Tests")
struct UndoRedoStackTests {

    @Test("initially empty")
    func initiallyEmpty() {
        let stack = UndoRedoStack<Int>()
        #expect(!stack.canUndo)
        #expect(!stack.canRedo)
    }

    @Test("push enables undo")
    func pushEnablesUndo() {
        var stack = UndoRedoStack<Int>()
        stack.push(1)
        #expect(stack.canUndo)
    }

    @Test("undo returns last pushed")
    func undoReturnsLast() {
        var stack = UndoRedoStack<Int>()
        stack.push(1)
        stack.push(2)
        let value = stack.undo()
        #expect(value == 2)
    }

    @Test("undo enables redo")
    func undoEnablesRedo() {
        var stack = UndoRedoStack<Int>()
        stack.push(1)
        _ = stack.undo()
        #expect(stack.canRedo)
    }

    @Test("redo returns undone value")
    func redoReturnsUndone() {
        var stack = UndoRedoStack<Int>()
        stack.push(1)
        stack.push(2)
        _ = stack.undo()
        let value = stack.redo()
        #expect(value == 2)
    }

    @Test("push clears redo stack")
    func pushClearsRedo() {
        var stack = UndoRedoStack<Int>()
        stack.push(1)
        stack.push(2)
        _ = stack.undo()
        stack.push(3)
        #expect(!stack.canRedo)
    }

    @Test("multiple undo redo cycle")
    func multipleUndoRedo() {
        var stack = UndoRedoStack<Int>()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        #expect(stack.undo() == 3)
        #expect(stack.undo() == 2)
        #expect(stack.redo() == 2)
        #expect(stack.redo() == 3)
    }

    @Test("undo on empty returns nil")
    func undoEmptyReturnsNil() {
        var stack = UndoRedoStack<Int>()
        #expect(stack.undo() == nil)
    }

    @Test("redo on empty returns nil")
    func redoEmptyReturnsNil() {
        var stack = UndoRedoStack<Int>()
        #expect(stack.redo() == nil)
    }

    @Test("count tracks push and undo")
    func count() {
        var stack = UndoRedoStack<Int>()
        stack.push(1)
        stack.push(2)
        #expect(stack.undoCount == 2)
        _ = stack.undo()
        #expect(stack.undoCount == 1)
        #expect(stack.redoCount == 1)
    }
}
