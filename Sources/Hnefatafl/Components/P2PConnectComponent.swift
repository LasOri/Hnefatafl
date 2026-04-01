// MARK: - P2P Connect Component
// Viking-themed P2P connection screen
// Shield-card layout: Host panel (gold/defender) and Join panel (woad/attacker)
// Shows local endpoint ID, input for remote peer ID, connection status

import LINKER

struct P2PConnectComponent {

    static func render(state: GameState) -> [AnyNode] {
        guard let session = state.p2pSession else {
            return hostOrJoinScreen(state: state)
        }

        // Show connection status while connecting/connected
        return connectionStatusScreen(session: session, state: state)
    }

    // MARK: - Host or Join Selection

    private static func hostOrJoinScreen(state: GameState) -> [AnyNode] {
        let title = Element<AnyHTMLContext>(
            tag: "h2",
            attributes: [
                Attribute(name: "class", value: "p2p-title"),
                Attribute(name: "style", value: "font-family: var(--font-display); font-size: 1.5rem; color: var(--viking-gold); text-align: center; letter-spacing: 0.1em; margin-bottom: var(--space-4);")
            ],
            children: [AnyNode(Text("Peer-to-Peer Battle"))]
        )

        // Host Game panel
        let hostPanel = panel(
            title: "Host a Game",
            description: "Create a game as the Defender and share your ID with an opponent.",
            buttonLabel: "Raise the Banner",
            buttonClass: "btn btn-host",
            action: "p2p-host",
            variant: state.selectedVariant
        )

        // Divider
        let divider = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "p2p-divider")],
            children: [AnyNode(Text("or"))]
        )

        // Join Game panel
        let joinPanel = joinGamePanel()

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "p2p-connect"),
                Attribute(name: "role", value: "region"),
                Attribute(name: "aria-label", value: "Peer-to-peer connection")
            ],
            children: [AnyNode(title), AnyNode(hostPanel), AnyNode(divider), AnyNode(joinPanel)]
        )
        return [AnyNode(container)]
    }

    // MARK: - Connection Status

    private static func connectionStatusScreen(session: P2PSessionState, state: GameState) -> [AnyNode] {
        let roleText = session.isHost ? "Hosting as Defender" : "Joined as Attacker"
        let roleEl = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "style", value: "font-family: var(--font-display); font-size: 1.125rem; letter-spacing: 0.05em;")
            ],
            children: [AnyNode(Text(roleText))]
        )

        let statusDotClass: String
        let statusText: String
        switch session.connectionState {
        case .connected:
            statusDotClass = "p2p-status-dot connected"
            statusText = "Connected"
        case .connecting:
            statusDotClass = "p2p-status-dot connecting"
            statusText = "Connecting..."
        case .disconnected:
            statusDotClass = "p2p-status-dot disconnected"
            statusText = "Disconnected"
        case .reconnecting(let attempt):
            statusDotClass = "p2p-status-dot connecting"
            statusText = "Reconnecting (attempt \(attempt))..."
        case .failed:
            statusDotClass = "p2p-status-dot failed"
            statusText = "Connection failed"
        }

        let dot = Element<AnyHTMLContext>(
            tag: "span",
            attributes: [Attribute(name: "class", value: statusDotClass)],
            children: []
        )
        let label = Element<AnyHTMLContext>(
            tag: "span",
            attributes: [],
            children: [AnyNode(Text(statusText))]
        )
        let statusRow = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "p2p-status"),
                Attribute(name: "aria-live", value: "polite")
            ],
            children: [AnyNode(dot), AnyNode(label)]
        )

        var children: [AnyNode] = [AnyNode(roleEl), AnyNode(statusRow)]

        // Show endpoint ID for host (for sharing)
        if session.isHost, let endpointId = session.localEndpointId {
            let idLabel = Element<AnyHTMLContext>(
                tag: "div",
                attributes: [
                    Attribute(name: "style", value: "font-size: 0.75rem; color: var(--text-muted); margin-top: var(--space-3);")
                ],
                children: [AnyNode(Text("Share this ID with your opponent:"))]
            )
            let idDisplay = Element<AnyHTMLContext>(
                tag: "div",
                attributes: [
                    Attribute(name: "class", value: "p2p-id"),
                    Attribute(name: "data-action", value: "copy-id"),
                    Attribute(name: "aria-label", value: "Your peer ID, click to copy")
                ],
                children: [AnyNode(Text(endpointId))]
            )
            children.append(AnyNode(idLabel))
            children.append(AnyNode(idDisplay))
        }

        // Leave button
        let leaveBtn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn"),
                Attribute(name: "data-action", value: "p2p-leave"),
                Attribute(name: "aria-label", value: "Leave game"),
                Attribute(name: "style", value: "margin-top: var(--space-4);")
            ],
            children: [AnyNode(Text("Leave Game"))]
        )
        children.append(AnyNode(leaveBtn))

        let container = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "class", value: "p2p-panel"),
                Attribute(name: "role", value: "status"),
                Attribute(name: "aria-label", value: "Connection status")
            ],
            children: children
        )
        return [AnyNode(container)]
    }

    // MARK: - Helpers

    private static func panel(title: String, description: String, buttonLabel: String, buttonClass: String, action: String, variant: SelectedVariant) -> Element<AnyHTMLContext> {
        let h3 = Element<AnyHTMLContext>(
            tag: "h3",
            attributes: [],
            children: [AnyNode(Text(title))]
        )
        let desc = Element<AnyHTMLContext>(
            tag: "p",
            attributes: [
                Attribute(name: "style", value: "font-size: 0.875rem; color: var(--text-secondary); margin-bottom: var(--space-4);")
            ],
            children: [AnyNode(Text(description))]
        )
        let variantLabel = Element<AnyHTMLContext>(
            tag: "div",
            attributes: [
                Attribute(name: "style", value: "font-size: 0.75rem; color: var(--text-muted); margin-bottom: var(--space-2);")
            ],
            children: [AnyNode(Text("Variant: \(variant.label)"))]
        )
        let btn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: buttonClass),
                Attribute(name: "data-action", value: action),
                Attribute(name: "aria-label", value: buttonLabel)
            ],
            children: [AnyNode(Text(buttonLabel))]
        )
        return Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "p2p-panel")],
            children: [AnyNode(h3), AnyNode(desc), AnyNode(variantLabel), AnyNode(btn)]
        )
    }

    private static func joinGamePanel() -> Element<AnyHTMLContext> {
        let h3 = Element<AnyHTMLContext>(
            tag: "h3",
            attributes: [],
            children: [AnyNode(Text("Join a Game"))]
        )
        let desc = Element<AnyHTMLContext>(
            tag: "p",
            attributes: [
                Attribute(name: "style", value: "font-size: 0.875rem; color: var(--text-secondary); margin-bottom: var(--space-4);")
            ],
            children: [AnyNode(Text("Enter the host's Peer ID to join as the Attacker."))]
        )
        let input = Element<AnyHTMLContext>(
            tag: "input",
            attributes: [
                Attribute(name: "type", value: "text"),
                Attribute(name: "class", value: "p2p-input"),
                Attribute(name: "placeholder", value: "Paste peer ID here..."),
                Attribute(name: "data-input", value: "peer-id"),
                Attribute(name: "aria-label", value: "Remote peer ID"),
                Attribute(name: "autocomplete", value: "off"),
                Attribute(name: "spellcheck", value: "false")
            ],
            children: []
        )
        let btn = Element<AnyHTMLContext>(
            tag: "button",
            attributes: [
                Attribute(name: "class", value: "btn btn-join"),
                Attribute(name: "data-action", value: "p2p-join"),
                Attribute(name: "aria-label", value: "Join game"),
                Attribute(name: "style", value: "margin-top: var(--space-3);")
            ],
            children: [AnyNode(Text("Join the Raid"))]
        )
        return Element<AnyHTMLContext>(
            tag: "div",
            attributes: [Attribute(name: "class", value: "p2p-panel")],
            children: [AnyNode(h3), AnyNode(desc), AnyNode(input), AnyNode(btn)]
        )
    }
}
