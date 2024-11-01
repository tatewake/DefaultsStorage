import Foundation

// MARK: - Standard Initializers -

extension DefaultsStorage {
    /// Creates a property that can read and write to a boolean user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a boolean value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Bool {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write to an integer user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if an integer value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Int {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write to a double user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a double value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Double {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write to a string user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a string value is not specified
    ///     for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == String {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write to a date user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a date value is not specified for
    ///     the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Date {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }

    /// Creates a property that can read and write to a user default as data.
    ///
    /// Avoid storing large data blobs in user defaults, such as image data,
    /// as it can negatively affect performance of your app. On tvOS, a
    /// `NSUserDefaultsSizeLimitExceededNotification` notification is posted
    /// if the total user default size reaches 512kB.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a data value is not specified for
    ///    the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == Data {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = self.store.value(forKey: key) as? Value ?? defaultValue
    }
}
