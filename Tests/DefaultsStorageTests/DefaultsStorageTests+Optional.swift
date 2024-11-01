@testable import DefaultsStorage
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

/// DefaultsStorageOptionalTests validates reading and writing Optional
/// versions of "Standard" values supported by `UserDefaults`
/// via `@DefaultsStorage`
final class DefaultsStorageOptionalTests: XCTestCase {
    // swiftlint: disable implicitly_unwrapped_optional
    private static let suiteName = "com.example.DefaultsStorageOptionalTests"
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

    func testOptionalBool() throws {
        let key = "testOptionalBool"
        typealias TestType = Bool
        let initialValue: TestType = true
        let updatedValue: TestType = false

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? TestType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }

    func testOptionalInt() throws {
        let key = "testOptionalInt"
        typealias TestType = Int
        let initialValue: TestType = -12
        let updatedValue: TestType = 42

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? TestType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }

    func testOptionalDouble() throws {
        let key = "testOptionalDouble"
        typealias TestType = Double
        let initialValue: TestType = -12.5
        let updatedValue: TestType = 42.5

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? TestType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }

    func testOptionalString() throws {
        let key = "testOptionalString"
        typealias TestType = String
        let initialValue: TestType = "Hello"
        let updatedValue: TestType = "World"

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? TestType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }

    func testOptionalDate() throws {
        let key = "testOptionalDate"
        typealias TestType = Date
        let initialValue: TestType = .distantPast
        let updatedValue: TestType = .distantFuture

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? TestType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }

    func testOptionalData() throws {
        let key = "testOptionalData"
        typealias TestType = Data
        let initialValue: TestType = Data([0x01, 0x02, 0x03])
        let updatedValue: TestType = Data([0x04, 0x05, 0x06])

        @DefaultsStorage(key, store: store) var value: TestType? {
            didSet {
                setCount += 1
            }
        }
        XCTAssertNil(store.value(forKey: key) as? TestType)
        XCTAssertEqual(setCount, 0)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        XCTAssertEqual(setCount, 1)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
        XCTAssertEqual(setCount, 2)
        value = nil
        XCTAssertNil(store.value(forKey: key))
    }
}

// swiftlint: enable attributes explicit_enum_raw_value static_over_final_class
