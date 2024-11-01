import Foundation

// MARK: - Enum Initializers -

extension DefaultsStorage {
    /// Creates a property that can read and write to an integer user default,
    /// transforming that to `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///     enum MyEnum: Int {
    ///         case a
    ///         case b
    ///         case c
    ///     }
    ///     struct MyModel {
    ///         @DefaultsStorage("MyEnumValue") private var value = MyEnum.a
    ///     }
    ///     var model = MyModel() {
    ///         didSet {
    ///             ...
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if an integer value
    ///     is not specified for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == Int {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = Value(rawValue: self.store.value(forKey: key) as? Value.RawValue ?? defaultValue.rawValue) ?? defaultValue
    }

    /// Creates a property that can read and write to a string user default,
    /// transforming that to `RawRepresentable` data type.
    ///
    /// A common usage is with enumerations:
    ///
    ///     enum MyEnum: String {
    ///         case a
    ///         case b
    ///         case c
    ///     }
    ///     struct MyModel {
    ///         @DefaultsStorage("MyEnumValue") private var value = MyEnum.a
    ///     }
    ///     var model = MyModel() {
    ///         didSet {
    ///             ...
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - wrappedValue: The default value if a string value
    ///     is not specified for the given key.
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value: RawRepresentable, Value.RawValue == String {
        self.key = key
        self.store = store ?? UserDefaults.standard
        defaultValue = wrappedValue
        storedValue = Value(rawValue: self.store.value(forKey: key) as? Value.RawValue ?? defaultValue.rawValue) ?? defaultValue
    }
}

// MARK: - Enum Optional Initializers -

extension DefaultsStorage where Value: ExpressibleByNilLiteral {
    /// Creates a property that can save and restore an Optional integer,
    /// transforming it to an Optional `RawRepresentable` data type.
    ///
    /// Defaults to nil if there is no restored value
    ///
    /// A common usage is with enumerations:
    ///
    ///     enum MyEnum: Int {
    ///         case a
    ///         case b
    ///         case c
    ///     }
    ///     struct MyModel {
    ///         @DefaultsStorage("MyEnumValue") private var value: MyEnum?
    ///     }
    ///     var model = MyModel() {
    ///         didSet {
    ///             ...
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init<R>(_ key: String, store: UserDefaults? = nil) where Value == R?, R: RawRepresentable, R.RawValue == Int {
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

    /// Creates a property that can save and restore an Optional string,
    /// transforming it to an Optional `RawRepresentable` data type.
    ///
    /// Defaults to nil if there is no restored value
    ///
    /// A common usage is with enumerations:
    ///
    ///     enum MyEnum: String {
    ///         case a
    ///         case b
    ///         case c
    ///     }
    ///     struct MyModel {
    ///         @DefaultsStorage("MyEnumValue") private var value: MyEnum?
    ///     }
    ///     var model = MyModel() {
    ///         didSet {
    ///             ...
    ///         }
    ///     }
    ///
    /// - Parameters:
    ///   - key: The key to read and write the value to in the user defaults
    ///     store.
    ///   - store: The user defaults store to read and write to. A value
    ///     of `nil` will use the user default store from the environment.
    public init<R>(_ key: String, store: UserDefaults? = nil) where Value == R?, R: RawRepresentable, R.RawValue == String {
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
