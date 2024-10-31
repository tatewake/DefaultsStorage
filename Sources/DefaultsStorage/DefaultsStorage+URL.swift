import Foundation

// MARK: - URL Initializers -

extension DefaultsStorage {
    init(wrappedValue: Value, _ key: String, store: UserDefaults? = nil) where Value == URL {
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

extension DefaultsStorage {
    init(_ key: String, store: UserDefaults? = nil) where Value == URL? {
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
