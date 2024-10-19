@testable import DefaultsStorage
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

final class OptionalStorageTests: XCTestCase {
    // swiftlint: disable implicitly_unwrapped_optional
    private static let suiteName = "com.example.OptionalStorageTests"
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

    func testInt() throws {
        let key = "testInt"
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

    func testDouble() throws {
        let key = "testDouble"
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

    func testString() throws {
        let key = "testString"
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

    func testDate() throws {
        let key = "testDate"
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

    func testData() throws {
        let key = "testData"
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

    func testIntEnum() throws {
        enum IntEnum: Int {
            case alpha
            case beta
        }

        let key = "testIntEnum"
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

    func testStringEnum() throws {
        enum StringEnum: String {
            case alpha
            case beta
        }

        let key = "testStringEnum"
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
