@testable import DefaultsStorage
import SwiftUI
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

final class AppStorageWriteTests: XCTestCase {
    // swiftlint: disable implicitly_unwrapped_optional
    private static let suiteName = "com.example.AppStorageWriteTests"
    private var store: UserDefaults!
    private var setCount: Int = 0
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
        setCount = 0
    }

    override func tearDown() {
        store = nil

        super.tearDown()
    }

    private func appStorageKey(_ key: String) -> String {
        "AS-\(key)"
    }

    private func defaultsStorageKey(_ key: String) -> String {
        "DS-\(key)"
    }

    func testBool() throws {
        let key = "testBool"
        typealias TestType = Bool
        let initialValue: TestType = true

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? TestType
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? TestType

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
    }

    func testInt() throws {
        let key = "testInt"
        typealias TestType = Int
        let initialValue: TestType = -12

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? TestType
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? TestType

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
    }

    func testDouble() throws {
        let key = "testDouble"
        typealias TestType = Double
        let initialValue: TestType = -12.5

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? TestType
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? TestType

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
    }

    func testString() throws {
        let key = "testString"
        typealias TestType = String
        let initialValue: TestType = "Hello"

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? TestType
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? TestType

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
    }

    func testRemoteURL() throws {
        let key = "testRemoteURL"
        typealias TestType = URL
        typealias StorageType = Data

        // swiftlint: disable force_unwrapping
        let initialValue: TestType = URL(string: "http://example.com/")!
        // swiftlint: enable force_unwrapping

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? StorageType
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? StorageType

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
    }

    func testLocalURL() throws {
        let key = "testLocalURL"
        typealias TestType = URL
        typealias StorageType = String

        // swiftlint: disable force_unwrapping
        let initialValue: TestType = URL(filePath: ".")!
        // swiftlint: enable force_unwrapping

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? StorageType
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? StorageType

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
    }

    @available(macOS 15.0, *)
    func testDate() throws {
        let key = "testDate"
        typealias TestType = Date
        let initialValue: TestType = .distantPast

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? TestType
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? TestType

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
    }

    func testData() throws {
        let key = "testData"
        typealias TestType = Data
        let initialValue: TestType = Data([0x01, 0x02, 0x03])

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? TestType
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? TestType

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
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

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? TestType.RawValue
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? TestType.RawValue

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
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

        @AppStorage(appStorageKey(key), store: store) var appStorageValue: TestType = initialValue
        @DefaultsStorage(defaultsStorageKey(key), store: store) var defaultsStorageValue: TestType = initialValue

        appStorageValue = initialValue
        defaultsStorageValue = initialValue

        let valueStoredViaAppStorage = store.value(forKey: appStorageKey(key)) as? TestType.RawValue
        let valueStoredViaDefaultsStorage = store.value(forKey: defaultsStorageKey(key)) as? TestType.RawValue

        XCTAssertNotNil(valueStoredViaAppStorage)
        XCTAssertNotNil(valueStoredViaDefaultsStorage)
        XCTAssertEqual(valueStoredViaAppStorage, valueStoredViaDefaultsStorage)
    }
}

// swiftlint: enable attributes explicit_enum_raw_value static_over_final_class
