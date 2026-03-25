import Testing
@testable import Hnefatafl

@Suite("TacticalPuzzle Tests")
struct TacticalPuzzleTests {

    @Test("puzzle has title and description")
    func hasMetadata() {
        let puzzle = TacticalPuzzle.allPuzzles[0]
        #expect(!puzzle.title.isEmpty)
        #expect(!puzzle.description.isEmpty)
    }

    @Test("puzzle has a valid position")
    func hasPosition() {
        for puzzle in TacticalPuzzle.allPuzzles {
            let pieceCount = (0..<121).filter { puzzle.position.pieceAt(row: $0 / 11, col: $0 % 11) != nil }.count
            #expect(pieceCount > 0)
        }
    }

    @Test("puzzle has a solution move")
    func hasSolution() {
        for puzzle in TacticalPuzzle.allPuzzles {
            #expect(puzzle.solutionMove != nil || !puzzle.solutionMoves.isEmpty)
        }
    }

    @Test("puzzle solution is a legal move")
    func solutionIsLegal() {
        for puzzle in TacticalPuzzle.allPuzzles {
            let legalMoves = puzzle.position.allLegalMoves(for: puzzle.playerToMove)
            if let solution = puzzle.solutionMove {
                #expect(legalMoves.contains(solution), "Puzzle '\(puzzle.title)' solution is not legal")
            }
        }
    }

    @Test("puzzle has a category")
    func hasCategory() {
        for puzzle in TacticalPuzzle.allPuzzles {
            let validCategories: Set<PuzzleCategory> = [.kingEscape, .capture, .fork, .blockade, .endgame]
            #expect(validCategories.contains(puzzle.category))
        }
    }

    @Test("puzzle has difficulty rating")
    func hasDifficulty() {
        for puzzle in TacticalPuzzle.allPuzzles {
            #expect(puzzle.difficulty >= 1 && puzzle.difficulty <= 5)
        }
    }

    @Test("at least 3 puzzles exist")
    func minimumCount() {
        #expect(TacticalPuzzle.allPuzzles.count >= 3)
    }

    @Test("checkSolution returns true for correct move")
    func correctSolution() {
        let puzzle = TacticalPuzzle.allPuzzles[0]
        if let solution = puzzle.solutionMove {
            #expect(puzzle.checkSolution(solution))
        }
    }

    @Test("checkSolution returns false for wrong move")
    func wrongSolution() {
        let puzzle = TacticalPuzzle.allPuzzles[0]
        let wrongMove = Move(fromRow: 0, fromCol: 0, toRow: 0, toCol: 1)
        #expect(!puzzle.checkSolution(wrongMove))
    }

    @Test("puzzles for category returns filtered list")
    func filterByCategory() {
        let captures = TacticalPuzzle.puzzles(for: .capture)
        for puzzle in captures {
            #expect(puzzle.category == .capture)
        }
    }

    @Test("PuzzleCategory is Equatable")
    func categoryEquatable() {
        #expect(PuzzleCategory.kingEscape == PuzzleCategory.kingEscape)
        #expect(PuzzleCategory.capture != PuzzleCategory.fork)
    }
}
