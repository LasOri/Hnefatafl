import Testing
@testable import Hnefatafl

@Suite("GameMenuConfig Tests")
struct GameMenuConfigTests {

    @Test("default menu contains all item types")
    func defaultMenuHasAllItems() {
        let config = GameMenuConfig.defaultMenu
        #expect(config.items.count == MenuItemType.allCases.count)
        for item in MenuItemType.allCases {
            #expect(config.items.contains(item))
        }
    }

    @Test("default menu is closed")
    func defaultMenuIsClosed() {
        #expect(!GameMenuConfig.defaultMenu.isOpen)
    }

    @Test("minimal menu has two items")
    func minimalMenuHasTwoItems() {
        let config = GameMenuConfig.minimalMenu
        #expect(config.items.count == 2)
        #expect(config.items.contains(.newGame))
        #expect(config.items.contains(.undo))
    }

    @Test("minimal menu is closed")
    func minimalMenuIsClosed() {
        #expect(!GameMenuConfig.minimalMenu.isOpen)
    }

    @Test("MenuItemType has five cases")
    func menuItemTypeFiveCases() {
        #expect(MenuItemType.allCases.count == 5)
    }

    @Test("custom menu config equality")
    func customMenuEquality() {
        let a = GameMenuConfig(items: [.newGame, .rules], isOpen: true)
        let b = GameMenuConfig(items: [.newGame, .rules], isOpen: true)
        #expect(a == b)
    }

    @Test("MenuItemType raw values are camelCase strings")
    func rawValues() {
        #expect(MenuItemType.newGame.rawValue == "newGame")
        #expect(MenuItemType.settings.rawValue == "settings")
    }
}
