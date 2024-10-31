@testable import DefaultsStorage
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

final class DefaultsStorageURLTests: XCTestCase {
    // swiftlint: disable implicitly_unwrapped_optional
    private static let suiteName = "com.example.DefaultsStorageURLTests"
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

    func testURL() throws {
        let key = "testURL"
        typealias TestType = URL
        typealias RemoteStorageType = Data
        typealias LocalStorageType = String

        // swiftlint: disable force_unwrapping
        let initialValue: TestType = URL(string: "http://example.com/")!
        let updatedValue: TestType = URL(filePath: ".")!
        // swiftlint: enable force_unwrapping

        let archivedInitialValue = try? NSKeyedArchiver.archivedData(withRootObject: initialValue, requiringSecureCoding: false)

        @DefaultsStorage(key, store: store) var value = initialValue {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? RemoteStorageType)
        XCTAssertNil(store.value(forKey: key) as? LocalStorageType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? RemoteStorageType, archivedInitialValue)
        XCTAssertNil(store.value(forKey: key) as? LocalStorageType)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertNil(store.value(forKey: key) as? RemoteStorageType)
        XCTAssertEqual(store.value(forKey: key) as? LocalStorageType, updatedValue.absoluteURL.path)
        XCTAssertEqual(setCount, 2)
    }

    func testOptionalURL() throws {
        let key = "testOptionalURL"
        typealias TestType = URL
        typealias RemoteStorageType = Data
        typealias LocalStorageType = String

        // swiftlint: disable force_unwrapping
        let initialValue: TestType = URL(string: "http://example.com/")!
        let updatedValue: TestType = URL(filePath: ".")!
        // swiftlint: enable force_unwrapping

        let archivedInitialValue = try? NSKeyedArchiver.archivedData(withRootObject: initialValue, requiringSecureCoding: false)

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? RemoteStorageType)
        XCTAssertNil(store.value(forKey: key) as? LocalStorageType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? RemoteStorageType, archivedInitialValue)
        XCTAssertNil(store.value(forKey: key) as? LocalStorageType)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertNil(store.value(forKey: key) as? RemoteStorageType)
        XCTAssertEqual(store.value(forKey: key) as? LocalStorageType, updatedValue.absoluteURL.path)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }
}

// swiftlint: enable attributes explicit_enum_raw_value static_over_final_class
