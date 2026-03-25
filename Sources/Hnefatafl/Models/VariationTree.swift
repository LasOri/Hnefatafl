class VariationNode {
    let id: Int
    let move: Move?
    var children: [VariationNode] = []

    init(move: Move?, id: Int = 0) {
        self.id = id
        self.move = move
    }
}

struct VariationTree {
    let rootNode: VariationNode
    let position: Position
    let player: Player
    private var nextId: Int = 1

    init(position: Position, player: Player) {
        self.position = position
        self.player = player
        self.rootNode = VariationNode(move: nil, id: 0)
    }

    mutating func addMove(_ move: Move, to nodeId: Int) {
        guard let parent = findNode(id: nodeId) else { return }
        let child = VariationNode(move: move, id: nextId)
        nextId += 1
        parent.children.append(child)
    }

    var mainLine: [Move] {
        var line: [Move] = []
        var current = rootNode
        while let first = current.children.first {
            if let move = first.move {
                line.append(move)
            }
            current = first
        }
        return line
    }

    var depth: Int {
        computeDepth(node: rootNode)
    }

    var nodeCount: Int {
        computeCount(node: rootNode)
    }

    func findNode(id: Int) -> VariationNode? {
        findNodeRecursive(node: rootNode, id: id)
    }

    private func computeDepth(node: VariationNode) -> Int {
        if node.children.isEmpty { return 0 }
        return 1 + node.children.map { computeDepth(node: $0) }.max()!
    }

    private func computeCount(node: VariationNode) -> Int {
        1 + node.children.reduce(0) { $0 + computeCount(node: $1) }
    }

    private func findNodeRecursive(node: VariationNode, id: Int) -> VariationNode? {
        if node.id == id { return node }
        for child in node.children {
            if let found = findNodeRecursive(node: child, id: id) {
                return found
            }
        }
        return nil
    }
}
