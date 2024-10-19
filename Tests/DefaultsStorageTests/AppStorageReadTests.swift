@testable import DefaultsStorage
import SwiftUI
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

final class AppStorageReadTests: XCTestCase {
    // swiftlint: disable implicitly_unwrapped_optional
    private static let suiteName = "com.example.AppStorageReadTests"
    private var store: UserDefaults!
    // swiftlint: enable implicitly_unwrapped_optional

    override final class func setUp() {
        super.setUp()

        UserDefaults(suiteName: suiteName)?.removePersistentDomain(forName: suiteName)
    }

    override final class func tearDown() {
        UserDefaults(suiteName: suiteName)?.removePersistentDomain(forName: suiteName)

        super.tearDown()
    }

    override func setUp() {
        super.setUp()

        store = UserDefaults(suiteName: Self.suiteName)
    }

    override func tearDown() {
        store = nil

        super.tearDown()
    }

    func testBool() throws {
        let key = "testBool"
        typealias TestType = Bool
        let initialValue: TestType = true
        let dummyValue: TestType = false

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }

    func testInt() throws {
        let key = "testInt"
        typealias TestType = Int
        let initialValue: TestType = -12
        let dummyValue: TestType = 42

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }

    func testDouble() throws {
        let key = "testDouble"
        typealias TestType = Double
        let initialValue: TestType = -12.5
        let dummyValue: TestType = 42.5

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }

    func testString() throws {
        let key = "testString"
        typealias TestType = String
        let initialValue: TestType = "Hello"
        let dummyValue: TestType = "World"

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }

    func testRemoteURL() throws {
        let key = "testRemoteURL"
        typealias TestType = URL

        // swiftlint: disable force_unwrapping
        let initialValue: TestType = URL(string: "http://example.com/")!
        let dummyValue: TestType = URL(filePath: ".")!
        // swiftlint: enable force_unwrapping

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }

    func testLocalURL() throws {
        let key = "testLocalURL"
        typealias TestType = URL
        typealias StorageType = String

        // swiftlint: disable force_unwrapping
        let initialValue: TestType = URL(filePath: ".")!
        let dummyValue: TestType = URL(string: "http://example.com")!
        // swiftlint: enable force_unwrapping

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @AppStorage(key, store: store) var appStorageValue2: TestType = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        // Note: In `@AppStorage` a stored and retrieved URL will not necessarily be equal
        // to what was stored
        XCTAssertNotEqual(appStorageValue, appStorageValue2)

        // Note: Therefore, we actually need to test two "retrieved" values against each other
        // to ensure we're at least retrieving it in the way `@AppStorage` retrieves it
        XCTAssertEqual(appStorageValue2, defaultsStorageValue)
    }

    @available(macOS 15.0, *)
    func testDate() throws {
        let key = "testDate"
        typealias TestType = Date
        let initialValue: TestType = .distantPast
        let dummyValue: TestType = .distantFuture

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }

    func testData() throws {
        let key = "testData"
        typealias TestType = Data
        let initialValue: TestType = Data([0x01, 0x02, 0x03])
        let dummyValue: TestType = Data([0x04, 0x05, 0x06])

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }

    func testIntEnum() throws {
        enum IntEnum: Int {
            case alpha
            case beta
        }

        let key = "testIntEnum"
        typealias TestType = IntEnum
        typealias StorageType = Int
        let initialValue: TestType = .alpha
        let dummyValue: TestType = .beta

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }

    func testStringEnum() throws {
        enum StringEnum: String {
            case alpha
            case beta
        }

        let key = "testStringEnum"
        typealias TestType = StringEnum
        typealias StorageType = String
        let initialValue: TestType = .alpha
        let dummyValue: TestType = .beta

        @AppStorage(key, store: store) var appStorageValue: TestType = initialValue
        appStorageValue = initialValue
        @DefaultsStorage(key, store: store) var defaultsStorageValue: TestType = dummyValue

        XCTAssertEqual(appStorageValue, defaultsStorageValue)
    }
}

// swiftlint: enable attributes explicit_enum_raw_value static_over_final_class
