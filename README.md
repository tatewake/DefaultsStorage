# DefaultsStorage

Use `UserDefaults` in AppKit and UIKit as easily as `@AppStorage` in SwiftUI, with simple reactivity via `didSet`, no Combine dependency required.

## License

* **Author:** [Terence J. Grant](mailto:tjgrant@tatewake.com)
* **License:** MIT License
* **Donate:** [Your donations are appreciated!](http://tjgrant.com/wiki/donate)

## About

`@DefaultsStorage` is a property wrapper that reflects a `UserDefaults` value, allowing reactive updates via `didSet` when values change.

This work-alike for `@AppStorage` reads from and writes to `UserDefaults` the same way, making migration to or from SwiftUI straightforward.

## Features

* Simple property wrapper for storing and retrieving `UserDefaults` values.
* Supports `Bool`, `Int`, `Double`, `String`, `Date`, and `Data`.
  * Arrays of those types, for instance `[Int]`
  * Dictionaries of those types where the "key" is of type `String`, for instance `[String: Int]`
* Also supports `URL` and enums with `String` or `Int` raw values.
* Provides `didSet`-based reactivity.
* Compatible with values stored by `@AppStorage`.
* Fully tested for reliability.

## Installation

### Swift Package Manager (SPM)

Add `DefaultsStorage` to your project with Swift Package Manager in Xcode:

1. Go to "File -> Add Package Dependency…"
2. Enter the package URL: `https://github.com/tatewake/DefaultsStorage`
3. Use "Dependency Rule -> Exact Version" and set to use release version "1.1.0".

## Usage

### Simple Example

The `@DefaultStorage` tag will load from `UserDefaults` on instantiation and save automatically when the value changes. If no value exists in `UserDefaults`, the initializer will provide a default value.

```swift
@DefaultsStorage("name") var name = "User"
```

This syncs automatically on initialization or when modified in code.

### Reactive Example

Here’s an example using `SettingsModel` as a `struct` to leverage `didSet` reactivity.

```swift
struct SettingsModel {
    struct Display: Equatable {
        enum Address: String {
            case first, multiple, last
        }

        @DefaultsStorage("addressSourcePublic") var addressSourcePublic = false
        @DefaultsStorage("addressToDisplay") var addressToDisplay = Address.multiple
    }

    struct Network: Equatable {
        @DefaultsStorage("offlineUpdateFrequency") var offlineUpdateFrequency = 30.0
        @DefaultsStorage("onlineUpdateFrequency") var onlineUpdateFrequency = 60.0
    }

    var display = Display()
    var network = Network()
}
```

Now, in a top-level `Model` `class`, we use `didSet` to handle changes in `SettingsModel` via a delegate:

```swift
class Model {
	weak var delegate: MyDelegate?

	var settings = SettingsModel() {
	    didSet {
	        if oldValue.display != settings.display {
	            delegate?.displaySettingsChanged(display: settings.display)
	        }

	        if oldValue.network != settings.network {
	            delegate?.networkSettingsChanged(network: settings.network)
	        }
	    }
	}
	...
}
```

This is just a simple example, but it shows the straightforward nature of `DefaultsStorage`.

## Caveats

While `@DefaultsStorage` is similar to `@AppStorage`, there are two key differences:

1. External changes won’t update in real time, and
2. Properties sharing the same key won’t stay in sync.

This is because `@DefaultsStorage` only reads from `UserDefaults` on initialization, and only internal code changes trigger the `didSet` handler.

Therefore, if another app or process updates your `UserDefaults` store, or two `@DefaultsStorage` properties use the same key, these changes won’t trigger reactively. 

The first scenario is rare, and for the second, ensure a single variable per setting as the “source of truth.” 

## Acknowledgements

* Inspired by SwiftUI's `@AppStorage`.
