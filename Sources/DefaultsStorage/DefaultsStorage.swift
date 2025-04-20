import Foundation

// MARK: - DefaultsStorage -

/// A property wrapper type that reflects a value from `UserDefaults` and
/// allows reactive updates for non-SwiftUI projects via `didSet` when the
/// value changes.
@propertyWrapper
public struct DefaultsStorage<Value> {
    let key: String
    let defaultValue: Value
    let store: UserDefaults
    var storedValue: Value

    private static func isValidType(_ value: Any) -> Bool {
        let mirror = Mirror(reflecting: value)
        if mirror.displayStyle == .optional {
            if let unwrapped = mirror.children.first?.value {
                return isValidType(unwrapped)
            } else {
                return true
            }
        } else {
            switch value {
            case is Bool, is Int, is Double, is String, is Date, is Data:
                return true
            case let array as [Any]:
                return array.allSatisfy(isValidType)
            case let dict as [String: Any]:
                return dict.values.allSatisfy(isValidType)
            default:
                return false
            }
        }
    }

    public var wrappedValue: Value {
        get {
            storedValue
        }
        set {
            if let newRawValue = newValue as? (any RawRepresentable) {
                store.set(newRawValue.rawValue, forKey: key)
            } else if let newURLValue = newValue as? URL {
                if newURLValue.isFileURL {
                    store.set(newURLValue.absoluteURL.path, forKey: key)
                } else if let archivedData = try? NSKeyedArchiver.archivedData(withRootObject: newURLValue, requiringSecureCoding: false) {
                    store.set(archivedData, forKey: key)
                }
            } else {
                let mirror = Mirror(reflecting: newValue)

                if mirror.displayStyle == .optional {
                    if let unwrappedValue = mirror.children.first?.value {
                        store.set(unwrappedValue, forKey: key)
                    } else {
                        store.removeObject(forKey: key)
                    }
                } else {
                    store.set(newValue, forKey: key)
                }
            }
            storedValue = newValue
        }
    }
}

// MARK: - Standard Initializers -

extension DefaultsStorage {
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue

        guard DefaultsStorage.isValidType(defaultValue) else {
            fatalError("UserDefaults cannot be used with type \(type(of: defaultValue))")
        }

        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }
}

// MARK: - Optional Initializers -

extension DefaultsStorage where Value: ExpressibleByNilLiteral {
    public init(_ key: String, store: UserDefaults? = nil) {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil

        guard DefaultsStorage.isValidType(defaultValue) else {
            fatalError("UserDefaults cannot be used with type \(type(of: defaultValue))")
        }

        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }
}

// MARK: - Equatable -

extension DefaultsStorage: Equatable where Value: Equatable {
    public static func == (lhs: DefaultsStorage<Value>, rhs: DefaultsStorage<Value>) -> Bool {
        lhs.storedValue == rhs.storedValue
    }
}
