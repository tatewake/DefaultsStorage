@testable import DefaultsStorage
import XCTest

// swiftlint: disable attributes explicit_enum_raw_value static_over_final_class

final class DefaultsStorageTests: XCTestCase {
    // swiftlint: disable implicitly_unwrapped_optional
    private var store: UserDefaults!
    private static let suiteName = "com.example.DefaultsStorageTests"
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
        let updatedValue: TestType = false

        @DefaultsStorage(key, store: store) var value = initialValue
        XCTAssertNil(store.value(forKey: key) as? TestType)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
    }

    func testInt() throws {
        let key = "testInt"
        typealias TestType = Int
        let initialValue: TestType = -12
        let updatedValue: TestType = 42

        @DefaultsStorage(key, store: store) var value = initialValue
        XCTAssertNil(store.value(forKey: key) as? TestType)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
    }

    func testDouble() throws {
        let key = "testDouble"
        typealias TestType = Double
        let initialValue: TestType = -12.5
        let updatedValue: TestType = 42.5

        @DefaultsStorage(key, store: store) var value = initialValue
        XCTAssertNil(store.value(forKey: key) as? TestType)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
    }

    func testString() throws {
        let key = "testString"
        typealias TestType = String
        let initialValue: TestType = "Hello"
        let updatedValue: TestType = "World"

        @DefaultsStorage(key, store: store) var value = initialValue
        XCTAssertNil(store.value(forKey: key) as? TestType)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
    }

    func testURL() throws {
        let key = "testURL"
        typealias TestType = URL
        typealias StorageType = String

        // swiftlint: disable force_unwrapping
        let initialValue: TestType = URL(string: "http://example.com/")!
        let updatedValue: TestType = URL(filePath: ".")!
        // swiftlint: enable force_unwrapping

        @DefaultsStorage(key, store: store) var value = initialValue
        XCTAssertNil(store.value(forKey: key) as? StorageType)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, initialValue.absoluteString)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, updatedValue.absoluteString)
    }

    func testData() throws {
        let key = "testData"
        typealias TestType = Data
        let initialValue: TestType = Data([0x01, 0x02, 0x03])
        let updatedValue: TestType = Data([0x04, 0x05, 0x06])

        @DefaultsStorage(key, store: store) var value = initialValue
        XCTAssertNil(store.value(forKey: key) as? TestType)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, initialValue)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? TestType, updatedValue)
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

        @DefaultsStorage(key, store: store) var value = initialValue
        XCTAssertNil(store.value(forKey: key) as? StorageType)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, initialValue.rawValue)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, updatedValue.rawValue)
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

        @DefaultsStorage(key, store: store) var value = initialValue
        XCTAssertNil(store.value(forKey: key) as? StorageType)
        value = initialValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, initialValue.rawValue)
        value = updatedValue
        XCTAssertEqual(store.value(forKey: key) as? StorageType, updatedValue.rawValue)
    }
}

// swiftlint: enable attributes explicit_enum_raw_value static_over_final_class
