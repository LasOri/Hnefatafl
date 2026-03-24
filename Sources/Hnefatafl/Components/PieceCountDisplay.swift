import LINKER

struct PieceCountDisplay {
    static func render(count: PieceCount) -> [AnyNode] {
        let attackerSpan = Element<AnyHTMLContext>(
            tag: "span",
            attributes: [
                Attribute(name: "class", value: "piece-count piece-count-attacker"),
                Attribute(name: "aria-label", value: "Attackers: \(count.attackers)")
            ],
            children: [AnyNode(Text("\(count.attackers)"))]
        )

        let defenderLabel = count.hasKing ? "\(count.defenders)+K" : "\(count.defenders)"
        let defenderSpan = Element<AnyHTMLContext>(
            tag: "span",
            attributes: [
                Attribute(name: "class", value: "piece-count piece-count-defender"),
                Attribute(name: "aria-label", value: "Defenders: \(defenderLabel)")
            ],
            children: [AnyNode(Text("\(count.defenders)"))]
        )

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "piece-counts")],
            children: [AnyNode(attackerSpan), AnyNode(defenderSpan)]
        )

        return [AnyNode(container)]
    }
}
