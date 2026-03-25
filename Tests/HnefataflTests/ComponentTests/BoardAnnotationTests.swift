import Testing
@testable import Hnefatafl

@Suite("BoardAnnotation Tests")
struct BoardAnnotationTests {
    @Test("Creates annotation")
    func createAnnotation() {
        let annotation = Annotation(row: 3, col: 4, symbol: "X", color: "red")
        #expect(annotation.row == 3)
        #expect(annotation.col == 4)
        #expect(annotation.symbol == "X")
        #expect(annotation.color == "red")
    }

    @Test("Adds annotation to layer")
    func addAnnotation() {
        var layer = AnnotationLayer()
        let annotation = Annotation(row: 5, col: 5, symbol: "?", color: "blue")
        layer.add(annotation)
        #expect(layer.annotations.count == 1)
        #expect(layer.annotations[0] == annotation)
    }

    @Test("Removes annotation from layer")
    func removeAnnotation() {
        var layer = AnnotationLayer()
        let annotation = Annotation(row: 2, col: 3, symbol: "!", color: "green")
        layer.add(annotation)
        layer.remove(at: (2, 3))
        #expect(layer.annotations.isEmpty)
    }

    @Test("Clears all annotations")
    func clearAnnotations() {
        var layer = AnnotationLayer()
        layer.add(Annotation(row: 0, col: 0, symbol: "A", color: "red"))
        layer.add(Annotation(row: 1, col: 1, symbol: "B", color: "blue"))
        layer.clear()
        #expect(layer.annotations.isEmpty)
    }

    @Test("Removes only matching annotation")
    func removeOnlyMatching() {
        var layer = AnnotationLayer()
        layer.add(Annotation(row: 0, col: 0, symbol: "A", color: "red"))
        layer.add(Annotation(row: 1, col: 1, symbol: "B", color: "blue"))
        layer.remove(at: (0, 0))
        #expect(layer.annotations.count == 1)
        #expect(layer.annotations[0].row == 1)
    }

    @Test("Multiple annotations at different positions")
    func multipleAnnotations() {
        var layer = AnnotationLayer()
        layer.add(Annotation(row: 0, col: 0, symbol: "1", color: "red"))
        layer.add(Annotation(row: 5, col: 5, symbol: "2", color: "blue"))
        layer.add(Annotation(row: 10, col: 10, symbol: "3", color: "green"))
        #expect(layer.annotations.count == 3)
    }

    @Test("Remove non-existent annotation does nothing")
    func removeNonExistent() {
        var layer = AnnotationLayer()
        layer.add(Annotation(row: 3, col: 3, symbol: "X", color: "red"))
        layer.remove(at: (5, 5))
        #expect(layer.annotations.count == 1)
    }
}
