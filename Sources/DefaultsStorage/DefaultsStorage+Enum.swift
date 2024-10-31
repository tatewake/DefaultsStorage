import Foundation

// MARK: - Enum Initializers -

extension DefaultsStorage {
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

// MARK: - Enum Optional Initializers -

extension DefaultsStorage {
    init<R>(_ key: String, store: UserDefaults? = nil) where Value == R?, R: RawRepresentable, R.RawValue == Int {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue =
            if let rawValue = self.store.value(forKey: key) as? R.RawValue {
                R(rawValue: rawValue)
            } else {
                defaultValue
            }
    }

    init<R>(_ key: String, store: UserDefaults? = nil) where Value == R?, R: RawRepresentable, R.RawValue == String {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue =
            if let rawValue = self.store.value(forKey: key) as? R.RawValue {
                R(rawValue: rawValue)
            } else {
                defaultValue
            }
    }
}
