import XCTest
@testable import aTerminal

final class ThemeStoreTests: XCTestCase {
    private var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: "ThemeStoreTests")
        defaults.removePersistentDomain(forName: "ThemeStoreTests")
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: "ThemeStoreTests")
        super.tearDown()
    }

    func testDefaults() {
        let store = ThemeStore(defaults: defaults)
        XCTAssertEqual(store.theme, .system)
        XCTAssertEqual(store.appFontSize, ThemeStore.defaultAppFontSize)
        XCTAssertEqual(store.terminalFontSize, ThemeStore.defaultTerminalFontSize)
    }

    func testPersistsAcrossInstances() {
        let store = ThemeStore(defaults: defaults)
        store.theme = .dark
        store.terminalFontSize = 16

        let reloaded = ThemeStore(defaults: defaults)
        XCTAssertEqual(reloaded.theme, .dark)
        XCTAssertEqual(reloaded.terminalFontSize, 16)
    }

    func testResetRestoresDefaults() {
        let store = ThemeStore(defaults: defaults)
        store.appFontSize = 22
        store.terminalFontSize = 18

        store.resetAppFontSize()
        store.resetTerminalFontSize()

        XCTAssertEqual(store.appFontSize, ThemeStore.defaultAppFontSize)
        XCTAssertEqual(store.terminalFontSize, ThemeStore.defaultTerminalFontSize)
    }

    func testThemeColorScheme() {
        XCTAssertNil(AppTheme.system.colorScheme)
        XCTAssertEqual(AppTheme.light.colorScheme, .light)
        XCTAssertEqual(AppTheme.dark.colorScheme, .dark)
    }
}
