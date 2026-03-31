
#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

class MCTSNode {
    let position: Position
    let player: Player
    let move: Move?
    var visits: Int = 0
    var totalValue: Double = 0.0
    var children: [MCTSNode] = []

    var winRate: Double {
        visits > 0 ? totalValue / Double(visits) : 0.0
    }

    init(position: Position, player: Player, move: Move?) {
        self.position = position
        self.player = player
        self.move = move
    }
}

enum MonteCarloSearch {
    static let explorationConstant: Double = 1.414

    static func search(game: Game, iterations: Int) -> Move? {
        let root = MCTSNode(position: game.position, player: game.currentPlayer, move: nil)
        let legalMoves = game.position.allLegalMoves(for: game.currentPlayer)
        guard !legalMoves.isEmpty else { return nil }

        let nextPlayer: Player = game.currentPlayer == .attacker ? .defender : .attacker
        for move in legalMoves {
            let newPos = game.position.applyMove(move)
            let child = MCTSNode(position: newPos, player: nextPlayer, move: move)
            root.children.append(child)
        }

        for _ in 0..<iterations {
            let selected = selectChild(root)
            let result = randomPlayout(position: selected.position, player: selected.player, maxMoves: 200)
            backpropagate(node: selected, result: result, rootPlayer: game.currentPlayer)
        }

        return root.children.max(by: { $0.visits < $1.visits })?.move
    }

    static func uctValue(node: MCTSNode, parentVisits: Int) -> Double {
        guard node.visits > 0 else { return Double.infinity }
        let exploitation = node.winRate
        let exploration = explorationConstant * sqrt(log(Double(parentVisits)) / Double(node.visits))
        return exploitation + exploration
    }

    static func randomPlayout(position: Position, player: Player, maxMoves: Int) -> Double {
        var pos = position
        var currentPlayer = player
        for _ in 0..<maxMoves {
            let status = Position.gameStatus(pos, currentPlayer: currentPlayer)
            switch status {
            case .attackerWins: return 0.5
            case .defenderWins: return 0.5
            case .draw: return 0.5
            case .inProgress: break
            }
            let moves = pos.allLegalMoves(for: currentPlayer)
            guard !moves.isEmpty else { return 0.5 }
            let randomIndex = Int.random(in: 0..<moves.count)
            pos = pos.applyMove(moves[randomIndex])
            currentPlayer = currentPlayer == .attacker ? .defender : .attacker
        }
        return 0.5
    }

    private static func selectChild(_ node: MCTSNode) -> MCTSNode {
        guard !node.children.isEmpty else { return node }
        let parentVisits = max(node.visits, 1)
        return node.children.max(by: { uctValue(node: $0, parentVisits: parentVisits) < uctValue(node: $1, parentVisits: parentVisits) })!
    }

    private static func backpropagate(node: MCTSNode, result: Double, rootPlayer: Player) {
        node.visits += 1
        node.totalValue += (node.player == rootPlayer) ? result : (1.0 - result)
    }
}
