import Foundation

// MARK: - Standard Initializers -

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

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Date {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Data {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }
}
