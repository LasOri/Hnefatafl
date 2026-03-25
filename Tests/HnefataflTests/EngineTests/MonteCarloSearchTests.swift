import Testing
@testable import Hnefatafl

@Suite("MonteCarloSearch Tests")
struct MonteCarloSearchTests {

    @Test("MCTSNode starts with zero visits")
    func nodeInit() {
        let node = MCTSNode(position: Position.copenhagenStart(), player: .attacker, move: nil)
        #expect(node.visits == 0)
        #expect(node.totalValue == 0.0)
    }

    @Test("MCTSNode winRate is zero initially")
    func nodeWinRate() {
        let node = MCTSNode(position: Position.copenhagenStart(), player: .attacker, move: nil)
        #expect(node.winRate == 0.0)
    }

    @Test("MCTSNode winRate after visits")
    func nodeWinRateAfterVisits() {
        let node = MCTSNode(position: Position.copenhagenStart(), player: .attacker, move: nil)
        node.visits = 10
        node.totalValue = 7.0
        #expect(node.winRate == 0.7)
    }

    @Test("search returns a legal move")
    func searchReturnsLegal() {
        let game = Game()
        let move = MonteCarloSearch.search(game: game, iterations: 50)
        #expect(move != nil)
        let legal = game.position.allLegalMoves(for: game.currentPlayer)
        #expect(legal.contains(move!))
    }

    @Test("search with 1 iteration returns a move")
    func singleIteration() {
        let game = Game()
        let move = MonteCarloSearch.search(game: game, iterations: 1)
        #expect(move != nil)
    }

    @Test("UCT value increases with fewer visits")
    func uctExploration() {
        let parent = MCTSNode(position: Position.copenhagenStart(), player: .attacker, move: nil)
        parent.visits = 100
        let child1 = MCTSNode(position: Position.copenhagenStart(), player: .defender, move: nil)
        child1.visits = 50
        child1.totalValue = 25.0
        let child2 = MCTSNode(position: Position.copenhagenStart(), player: .defender, move: nil)
        child2.visits = 5
        child2.totalValue = 2.5
        let uct1 = MonteCarloSearch.uctValue(node: child1, parentVisits: parent.visits)
        let uct2 = MonteCarloSearch.uctValue(node: child2, parentVisits: parent.visits)
        #expect(uct2 > uct1)
    }

    @Test("randomPlayout terminates")
    func playoutTerminates() {
        let pos = Position.copenhagenStart()
        let result = MonteCarloSearch.randomPlayout(position: pos, player: .attacker, maxMoves: 200)
        #expect(result >= 0.0 && result <= 1.0)
    }

    @Test("search returns nil for no legal moves")
    func noMoves() {
        let pos = Position(cells: Array(repeating: nil, count: 121))
        let game = Game(position: pos, currentPlayer: .attacker, moveHistory: [])
        let move = MonteCarloSearch.search(game: game, iterations: 10)
        #expect(move == nil)
    }
}
