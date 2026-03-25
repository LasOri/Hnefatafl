enum LayoutMode: Equatable {
    case mobile
    case tablet
    case desktop
}

struct ResponsiveLayout {
    static let mobileBreakpoint = 768
    static let tabletBreakpoint = 1024

    static func forWidth(_ width: Int) -> LayoutMode {
        if width < mobileBreakpoint { return .mobile }
        if width < tabletBreakpoint { return .tablet }
        return .desktop
    }

    static func boardSize(for mode: LayoutMode) -> Int {
        switch mode {
        case .mobile: return 320
        case .tablet: return 440
        case .desktop: return 560
        }
    }

    static func showSidebar(for mode: LayoutMode) -> Bool {
        mode == .desktop || mode == .tablet
    }

    static func mediaQueryCSS() -> String {
        """
        @media (max-width: 768px) {
            .board { width: 320px; height: 320px; }
            .sidebar { display: none; }
        }
        @media (min-width: 769px) and (max-width: 1024px) {
            .board { width: 440px; height: 440px; }
        }
        """
    }
}
