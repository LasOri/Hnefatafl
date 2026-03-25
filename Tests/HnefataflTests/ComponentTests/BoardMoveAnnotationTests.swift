import Testing
@testable import Hnefatafl

@Suite("BoardMoveAnnotation Tests")
struct BoardMoveAnnotationTests {
    @Test("Creates annotation with properties")
    func createAnnotation() {
        let annotation = BoardMoveAnnotation(row: 3, col: 4, text: "!", color: "blue")
        #expect(annotation.row == 3)
        #expect(annotation.col == 4)
        #expect(annotation.text == "!")
        #expect(annotation.color == "blue")
    }

    @Test("Brilliant move quality")
    func brilliantQuality() {
        let annotation = BoardMoveAnnotation.fromMoveQuality(row: 5, col: 5, quality: "brilliant")
        #expect(annotation.text == "!!")
        #expect(annotation.color == "#00c853")
    }

    @Test("Blunder move quality")
    func blunderQuality() {
        let annotation = BoardMoveAnnotation.fromMoveQuality(row: 0, col: 0, quality: "blunder")
        #expect(annotation.text == "??")
        #expect(annotation.color == "#b71c1c")
    }

    @Test("Good move quality")
    func goodQuality() {
        let annotation = BoardMoveAnnotation.fromMoveQuality(row: 1, col: 1, quality: "good")
        #expect(annotation.text == "!")
        #expect(annotation.color == "#2196f3")
    }

    @Test("Unknown quality uses raw string")
    func unknownQuality() {
        let annotation = BoardMoveAnnotation.fromMoveQuality(row: 2, col: 3, quality: "custom")
        #expect(annotation.text == "custom")
        #expect(annotation.color == "#757575")
    }

    @Test("Equatable conformance works")
    func equatable() {
        let a = BoardMoveAnnotation(row: 1, col: 2, text: "!", color: "red")
        let b = BoardMoveAnnotation(row: 1, col: 2, text: "!", color: "red")
        let c = BoardMoveAnnotation(row: 1, col: 2, text: "?", color: "red")
        #expect(a == b)
        #expect(a != c)
    }

    @Test("All standard qualities produce distinct text")
    func distinctQualities() {
        let qualities = ["brilliant", "good", "interesting", "dubious", "mistake", "blunder"]
        let texts = qualities.map { BoardMoveAnnotation.fromMoveQuality(row: 0, col: 0, quality: $0).text }
        let uniqueTexts = Set(texts)
        #expect(uniqueTexts.count == qualities.count)
    }
}
