@testable import DefaultsStorage
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

/// DefaultsStorageEnumTests validates reading and writing `Int` or `String`
/// backed `enum` types via `@DefaultsStorage`
final class DefaultsStorageEnumTests: XCTestCase {
    // swiftlint: disable implicitly_unwrapped_optional
    private static let suiteName = "com.example.DefaultsStorageEnumTests"
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

    func testIntEnum() throws {
        enum IntEnum: Int {
            case alpha = -12
            case beta = 42
        }

        let key = "testIntEnum"
        typealias TestType = IntEnum
        typealias StorageType = Int
        let initialValue: TestType = .alpha
        let updatedValue: TestType = .beta

        @DefaultsStorage(key, store: store) var value = initialValue {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? StorageType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, initialValue.rawValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, updatedValue.rawValue)
        XCTAssertEqual(setCount, 2)
    }

    func testStringEnum() throws {
        enum StringEnum: String {
            case alpha = "Hello"
            case beta = "World"
        }

        let key = "testStringEnum"
        typealias TestType = StringEnum
        typealias StorageType = String
        let initialValue: TestType = .alpha
        let updatedValue: TestType = .beta

        @DefaultsStorage(key, store: store) var value = initialValue {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? StorageType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, initialValue.rawValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, updatedValue.rawValue)
        XCTAssertEqual(setCount, 2)
    }

    func testOptionalIntEnum() throws {
        enum IntEnum: Int {
            case alpha = -12
            case beta = 42
        }

        let key = "testOptionalIntEnum"
        typealias TestType = IntEnum
        typealias StorageType = Int
        let initialValue: TestType = .alpha
        let updatedValue: TestType = .beta

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? StorageType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, initialValue.rawValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, updatedValue.rawValue)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }

    func testOptionalStringEnum() throws {
        enum StringEnum: String {
            case alpha = "Hello"
            case beta = "World"
        }

        let key = "testOptionalStringEnum"
        typealias TestType = StringEnum
        typealias StorageType = String
        let initialValue: TestType = .alpha
        let updatedValue: TestType = .beta

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? StorageType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, initialValue.rawValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, updatedValue.rawValue)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }
}

// swiftlint: enable attributes explicit_enum_raw_value static_over_final_class
