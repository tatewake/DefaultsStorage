@testable import DefaultsStorage
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

/// DefaultsStorageStandardTests validates reading and writing "Standard"
/// values supported by `UserDefaults` via `@DefaultsStorage`
final class DefaultsStorageStandardTests: XCTestCase {
    // swiftlint: disable implicitly_unwrapped_optional
    private static let suiteName = "com.example.DefaultsStorageStandardTests"
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

    func testBool() throws {
        let key = "testBool"
        typealias TestType = Bool
        let initialValue: TestType = true
        let updatedValue: TestType = false

        @DefaultsStorage(key, store: store) var value = initialValue {
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
    }

    func testInt() throws {
        let key = "testInt"
        typealias TestType = Int
        let initialValue: TestType = -12
        let updatedValue: TestType = 42

        @DefaultsStorage(key, store: store) var value = initialValue {
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
    }

    func testDouble() throws {
        let key = "testDouble"
        typealias TestType = Double
        let initialValue: TestType = -12.5
        let updatedValue: TestType = 42.5

        @DefaultsStorage(key, store: store) var value = initialValue {
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
    }

    func testString() throws {
        let key = "testString"
        typealias TestType = String
        let initialValue: TestType = "Hello"
        let updatedValue: TestType = "World"

        @DefaultsStorage(key, store: store) var value = initialValue {
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
    }

    func testDate() throws {
        let key = "testDate"
        typealias TestType = Date
        let initialValue: TestType = .distantPast
        let updatedValue: TestType = .distantFuture

        @DefaultsStorage(key, store: store) var value = initialValue {
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
    }

    func testData() throws {
        let key = "testData"
        typealias TestType = Data
        let initialValue: TestType = Data([0x01, 0x02, 0x03])
        let updatedValue: TestType = Data([0x04, 0x05, 0x06])

        @DefaultsStorage(key, store: store) var value = initialValue {
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
    }
}

// swiftlint: enable attributes explicit_enum_raw_value static_over_final_class
