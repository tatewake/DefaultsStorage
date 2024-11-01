import Foundation

// MARK: - URL Initializers -

extension DefaultsStorage {
    /// Creates a property that can read and write to a url user default.
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a url value is not specified for
    ///     the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == URL {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue =
            if let stringData = self.store.value(forKey: key) as? String {
                URL(fileURLWithPath: stringData)
            } else if let archiveData = self.store.value(forKey: key) as? Data,
                      let unarchivedURL = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSURL.self, from: archiveData) as? URL
            {
                unarchivedURL
            } else {
                defaultValue
            }
    }
}

// MARK: - URL Optional Initializers -

extension DefaultsStorage where Value: ExpressibleByNilLiteral {
    /// Creates a property that can read and write an Optional URL user
    /// default.
    ///
    /// Defaults to nil if there is no restored value.
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(_ key: String, store: UserDefaults? = nil) where Value == URL? {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = nil
        storedValue =
            if let stringData = self.store.value(forKey: key) as? String {
                URL(fileURLWithPath: stringData)
            } else if let archiveData = self.store.value(forKey: key) as? Data,
                      let unarchivedURL = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSURL.self, from: archiveData) as? URL
            {
                unarchivedURL
            } else {
                defaultValue
            }
    }
}
