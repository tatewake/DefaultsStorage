import Foundation

// MARK: - Optional Initializers -

extension DefaultsStorage where Value: ExpressibleByNilLiteral {
    /// Creates a property that can read and write an Optional boolean user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) where Value == Bool? {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write an Optional integer user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) where Value == Int? {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write an Optional double user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) where Value == Double? {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write an Optional string user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) where Value == String? {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write an Optional Date user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) where Value == Date? {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write an Optional data user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) where Value == Data? {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }
}
