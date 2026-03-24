import LINKER

struct GameStyleSheet {
    static let css = """
    :root {
        --board-bg: #5c3a1e;
        --square-bg: #d4a76a;
        --square-corner: #8b6914;
        --square-throne: #c9a84c;
        --text-primary: #2d1b0e;
        --text-light: #e8dcc8;
        --accent-gold: #c9a84c;
        --glow-color: rgba(201, 168, 76, 0.6);
    }

    .viking-app {
        display: flex;
        flex-direction: column;
        align-items: center;
        font-family: 'Segoe UI', system-ui, sans-serif;
        background: var(--board-bg);
        color: var(--text-light);
        min-height: 100vh;
        padding: 1rem;
    }

    .viking-theme {
        background: var(--board-bg);
        padding: 8px;
        border-radius: 4px;
    }

    .board {
        display: grid;
        grid-template-columns: repeat(11, 1fr);
        gap: 1px;
        max-width: 550px;
        width: 100%;
        aspect-ratio: 1;
        touch-action: none;
        user-select: none;
        -webkit-user-select: none;
    }

    .board-row {
        display: contents;
    }

    .square {
        aspect-ratio: 1;
        background: var(--square-bg);
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        position: relative;
        transition: background-color 0.15s;
        min-width: 44px;
        min-height: 44px;
    }

    .square:hover {
        filter: brightness(1.1);
    }

    .square-corner {
        background: var(--square-corner);
        border: 2px solid var(--accent-gold);
    }

    .square-throne {
        background: var(--square-throne);
        border: 2px dashed var(--accent-gold);
    }

    .piece-attacker, .piece-defender, .piece-king {
        cursor: grab;
    }

    .dragging {
        cursor: grabbing;
        opacity: 0.7;
        z-index: 10;
    }

    .selected {
        outline: 2px solid var(--accent-gold);
        outline-offset: -2px;
    }

    .glow {
        box-shadow: 0 0 12px 4px var(--glow-color);
        z-index: 1;
    }

    .move-indicator {
        background: rgba(201, 168, 76, 0.3);
    }

    .move-indicator::after {
        content: '';
        width: 30%;
        height: 30%;
        border-radius: 50%;
        background: var(--accent-gold);
        opacity: 0.7;
        position: absolute;
    }

    .game-over-overlay {
        position: fixed;
        inset: 0;
        background: rgba(0, 0, 0, 0.8);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 100;
    }

    .game-over-text {
        color: var(--accent-gold);
        font-size: 2rem;
        text-align: center;
    }

    .capture-effect {
        position: absolute;
        inset: 0;
        pointer-events: none;
    }

    .particle {
        position: absolute;
        width: 6px;
        height: 6px;
        border-radius: 50%;
        background: var(--accent-gold);
        animation: particle-burst 0.5s ease-out forwards;
    }

    @keyframes particle-burst {
        0% { transform: scale(1); opacity: 1; }
        100% { transform: scale(0); opacity: 0; }
    }

    .move-trail {
        position: absolute;
        inset: 0;
        pointer-events: none;
        opacity: 0.5;
    }

    .toolbar {
        display: flex;
        gap: 0.5rem;
        margin: 0.5rem 0;
        flex-wrap: wrap;
        justify-content: center;
    }

    .btn {
        padding: 0.5rem 1rem;
        border: 1px solid var(--accent-gold);
        background: transparent;
        color: var(--text-light);
        border-radius: 4px;
        cursor: pointer;
        font-size: 0.875rem;
    }

    .btn:hover {
        background: rgba(201, 168, 76, 0.2);
    }

    .status {
        text-align: center;
        margin: 0.5rem 0;
    }

    .move-history-panel {
        max-height: 200px;
        overflow-y: auto;
        width: 100%;
        max-width: 550px;
    }

    .move-history {
        list-style: none;
        padding: 0;
        display: flex;
        flex-wrap: wrap;
        gap: 0.25rem;
        font-size: 0.75rem;
    }

    .move-item {
        padding: 2px 6px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 2px;
    }

    @media (max-width: 600px) {
        .board {
            max-width: 100vw;
        }
        .game-over-text {
            font-size: 1.5rem;
        }
        .btn {
            padding: 0.625rem 1.25rem;
            font-size: 1rem;
        }
    }

    .status-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        max-width: 550px;
        margin: 0.5rem 0;
    }

    .status-turn {
        font-size: 1.1rem;
        font-weight: 600;
    }

    .status-in-progress {
        color: var(--text-light);
    }

    .status-game-over {
        color: var(--accent-gold);
        font-size: 1.3rem;
    }

    .status-captures {
        display: flex;
        gap: 1rem;
        font-size: 0.85rem;
        opacity: 0.8;
    }

    .capture-count {
        padding: 2px 8px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 4px;
    }

    .square:focus-visible {
        outline: 2px solid #fff;
        outline-offset: -2px;
        z-index: 2;
    }

    .legal-move {
        background: rgba(201, 168, 76, 0.3);
    }

    .btn:focus-visible {
        outline: 2px solid #fff;
        outline-offset: 2px;
    }

    .btn:active {
        background: rgba(201, 168, 76, 0.4);
    }

    .piece-svg-attacker, .piece-svg-defender, .piece-svg-king {
        width: 80%;
        height: 80%;
    }

    .focused {
        outline: 2px dashed #fff;
        outline-offset: -2px;
        z-index: 1;
    }

    .coord-label {
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.7rem;
        color: rgba(232, 220, 200, 0.5);
        user-select: none;
    }

    @keyframes piece-move {
        from { transform: translate(var(--move-dx), var(--move-dy)); }
        to { transform: translate(0, 0); }
    }

    .animating {
        animation: piece-move 0.3s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
    }

    @keyframes trail-fade {
        from { opacity: 0; }
        to { opacity: 0.5; }
    }

    .move-trail {
        animation: trail-fade 0.2s ease-in forwards;
    }

    @keyframes capture-burst {
        0% { transform: scale(0); opacity: 1; }
        50% { transform: scale(1.2); opacity: 0.8; }
        100% { transform: scale(0); opacity: 0; }
    }

    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-4px); }
        75% { transform: translateX(4px); }
    }

    .shake {
        animation: shake 0.3s ease-in-out;
    }

    @media (prefers-reduced-motion: reduce) {
        .particle { animation: none; }
        .move-trail { transition: none; animation: none; }
        .square { transition: none; }
        .animating { animation: none; }
    }

    @media (prefers-color-scheme: dark) {
        :root {
            --board-bg: #1a1207;
            --square-bg: #3d2a14;
            --text-light: #e0d5c0;
        }
    }

    @media (prefers-contrast: more) {
        :root {
            --board-bg: #000;
            --square-bg: #f5e6c8;
            --text-primary: #000;
            --text-light: #fff;
            --accent-gold: #ff0;
        }
        .square { border: 2px solid #000; }
        .btn { border-width: 2px; }
    }
    """

    static func render() -> [AnyNode] {
        let style = Element<AnyHTMLContext>(
            tag: "style",
            attributes: [],
            children: [AnyNode(Text(css))]
        )
        return [AnyNode(style)]
    }
}
