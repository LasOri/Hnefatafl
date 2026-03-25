import Testing
@testable import Hnefatafl

@Suite("VariationTree Tests")
struct VariationTreeTests {

    @Test("root node has no parent move")
    func rootNode() {
        let tree = VariationTree(position: Position.copenhagenStart(), player: .attacker)
        #expect(tree.rootNode.move == nil)
        #expect(tree.rootNode.children.isEmpty)
    }

    @Test("add variation creates child")
    func addVariation() {
        var tree = VariationTree(position: Position.copenhagenStart(), player: .attacker)
        let moves = Position.copenhagenStart().allLegalMoves(for: .attacker)
        tree.addMove(moves[0], to: tree.rootNode.id)
        #expect(tree.rootNode.children.count == 1)
    }

    @Test("main line returns first child at each level")
    func mainLine() {
        var tree = VariationTree(position: Position.copenhagenStart(), player: .attacker)
        let move1 = Position.copenhagenStart().allLegalMoves(for: .attacker)[0]
        tree.addMove(move1, to: tree.rootNode.id)
        let line = tree.mainLine
        #expect(line.count == 1)
        #expect(line[0] == move1)
    }

    @Test("multiple variations from same position")
    func multipleVariations() {
        var tree = VariationTree(position: Position.copenhagenStart(), player: .attacker)
        let moves = Position.copenhagenStart().allLegalMoves(for: .attacker)
        tree.addMove(moves[0], to: tree.rootNode.id)
        tree.addMove(moves[1], to: tree.rootNode.id)
        #expect(tree.rootNode.children.count == 2)
    }

    @Test("depth returns longest line")
    func depth() {
        var tree = VariationTree(position: Position.copenhagenStart(), player: .attacker)
        #expect(tree.depth == 0)
        let move = Position.copenhagenStart().allLegalMoves(for: .attacker)[0]
        tree.addMove(move, to: tree.rootNode.id)
        #expect(tree.depth == 1)
    }

    @Test("nodeCount returns total nodes")
    func nodeCount() {
        var tree = VariationTree(position: Position.copenhagenStart(), player: .attacker)
        #expect(tree.nodeCount == 1)
        let move = Position.copenhagenStart().allLegalMoves(for: .attacker)[0]
        tree.addMove(move, to: tree.rootNode.id)
        #expect(tree.nodeCount == 2)
    }

    @Test("VariationNode stores move")
    func nodeStoresMove() {
        let move = Position.copenhagenStart().allLegalMoves(for: .attacker)[0]
        let node = VariationNode(move: move)
        #expect(node.move == move)
    }

    @Test("find node by id")
    func findNode() {
        let tree = VariationTree(position: Position.copenhagenStart(), player: .attacker)
        let found = tree.findNode(id: tree.rootNode.id)
        #expect(found != nil)
    }
}
