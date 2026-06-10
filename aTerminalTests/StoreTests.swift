import XCTest
@testable import aTerminal

/// Product IDs are App Store Connect contracts — lock them down so a refactor
/// can't silently break live purchases.
final class StoreProductsTests: XCTestCase {
    func testProductIdentifiersAreStable() {
        XCTAssertEqual(StoreProducts.tips, [
            "com.aaroncx.relay.tip.small",
            "com.aaroncx.relay.tip.medium",
            "com.aaroncx.relay.tip.large",
        ])
        XCTAssertEqual(StoreProducts.subscriptions, [
            "com.aaroncx.relay.supporter.monthly",
            "com.aaroncx.relay.supporter.yearly",
        ])
        XCTAssertEqual(StoreProducts.all.count, 5)
    }

    func testStoreKitConfigurationListsEveryProduct() throws {
        // The local .storekit file must stay in sync with StoreProducts.
        let root = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        let config = try String(contentsOf: root.appendingPathComponent("aTerminal.storekit"), encoding: .utf8)
        for id in StoreProducts.all {
            XCTAssertTrue(config.contains("\"\(id)\""), "\(id) missing from aTerminal.storekit")
        }
    }
}
