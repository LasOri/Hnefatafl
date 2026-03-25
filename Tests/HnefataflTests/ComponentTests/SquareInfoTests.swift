import Testing
@testable import Hnefatafl

@Suite("Square Info Tests")
struct SquareInfoTests {

    @Test("empty square info")
    func emptySquareInfo() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let info = SquareInfo.info(row: 5, col: 5, position: position)
        #expect(info.piece == nil)
        #expect(info.row == 5)
        #expect(info.col == 5)
        #expect(info.label == "f6")
    }

    @Test("throne square is special")
    func throneIsSpecial() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let info = SquareInfo.info(row: 5, col: 5, position: position)
        #expect(info.isSpecial == true)
        #expect(info.specialType == "Throne")
    }

    @Test("corner square is special")
    func cornerIsSpecial() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let info = SquareInfo.info(row: 0, col: 0, position: position)
        #expect(info.isSpecial == true)
        #expect(info.specialType == "Corner")
    }

    @Test("regular square is not special")
    func regularNotSpecial() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let info = SquareInfo.info(row: 3, col: 3, position: position)
        #expect(info.isSpecial == false)
        #expect(info.specialType == nil)
    }

    @Test("occupied square shows piece")
    func occupiedSquareShowsPiece() {
        var cells: [Piece?] = Array(repeating: nil, count: 121)
        cells[5 * 11 + 5] = .king
        let position = Position(cells: cells)
        let info = SquareInfo.info(row: 5, col: 5, position: position)
        #expect(info.piece == .king)
    }

    @Test("label format is column letter and row number")
    func labelFormat() {
        let position = Position(cells: Array(repeating: nil, count: 121))
        let info = SquareInfo.info(row: 0, col: 0, position: position)
        #expect(info.label == "a11")
        let info2 = SquareInfo.info(row: 10, col: 10, position: position)
        #expect(info2.label == "k1")
    }
}
