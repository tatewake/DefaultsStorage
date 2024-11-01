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

// MARK: - Equatable -

extension DefaultsStorage: Equatable where Value: Equatable {
    public static func == (lhs: DefaultsStorage<Value>, rhs: DefaultsStorage<Value>) -> Bool {
        lhs.storedValue == rhs.storedValue
    }
}
