@testable import DefaultsStorage
import SwiftUI
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

/// AppStorageWriteTests tests if values written by `@DefaultStorage`and
/// `@AppStorage` are equal
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

    func testWriteBool() throws {
        let key = "testWriteBool"
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

    func testWriteInt() throws {
        let key = "testWriteInt"
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

    func testWriteDouble() throws {
        let key = "testWriteDouble"
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

    func testWriteString() throws {
        let key = "testWriteString"
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

    func testWriteRemoteURL() throws {
        let key = "testWriteRemoteURL"
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

    func testWriteLocalURL() throws {
        let key = "testWriteLocalURL"
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

    @available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
    func testWriteDate() throws {
        let key = "testWriteDate"
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

    func testWriteData() throws {
        let key = "testWriteData"
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

    func testWriteIntEnum() throws {
        enum IntEnum: Int {
            case alpha = -12
            case beta = 42
        }

        let key = "testWriteIntEnum"
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

    func testWriteStringEnum() throws {
        enum StringEnum: String {
            case alpha = "Hello"
            case beta = "World"
        }

        let key = "testWriteStringEnum"
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
