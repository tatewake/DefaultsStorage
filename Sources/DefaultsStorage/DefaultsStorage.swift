import Foundation

// MARK: - DefaultsStorage -

@propertyWrapper
struct DefaultsStorage<Value> {
    private let key: String
    private let defaultValue: Value
    private let store: UserDefaults
    private var storedValue: Value

    var wrappedValue: Value {
        get {
            storedValue
        }
        set {
            if let newRawValue = newValue as? (any RawRepresentable) {
                store.set(newRawValue.rawValue, forKey: key)
            } else if let newURLValue = newValue as? URL {
                store.set(newURLValue.absoluteString, forKey: key)
            } else {
                store.set(newValue, forKey: key)
            }
            storedValue = newValue
        }
    }
}

// MARK: - Equatable -

extension DefaultsStorage: Equatable where Value: Equatable {
    static func == (lhs: DefaultsStorage<Value>, rhs: DefaultsStorage<Value>) -> Bool {
        lhs.storedValue == rhs.storedValue
    }
}

// MARK: - Supported Initializers -

extension DefaultsStorage {
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Bool {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Int {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Double {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == String {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == URL {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = URL(string: self.store.value(forKey: key) as? String ?? "") ?? defaultValue
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Data {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == Int {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = Value(rawValue: self.store.value(forKey: key) as? Value.RawValue ?? defaultValue.rawValue) ?? defaultValue
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = Value(rawValue: self.store.value(forKey: key) as? Value.RawValue ?? defaultValue.rawValue) ?? defaultValue
    }
}
