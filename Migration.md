# v0 to v1

## Registry singleton removal

To avoid data races, the internal `Registry` singleton has been removed, instead preferring an explicit user-defined `Registry`. For example, when parsing or querying units from Strings, a registry instance should be passed:

```swift
let meter = try Unit(fromSymbol: "m") // old
let meter = try Unit(fromSymbol: "m", registry: registry) // new
```

Note that if registry is omitted from these functions, the default unit database is used, which should provide a relatively smooth transition in the common case where custom units are not used.

## Registry builder

Registries should be defined and instantiated during startup, and must not be changed after creation. To enforce this lifecycle, a `RegistryBuilder` has been introduced that custom units may be registered to.

```swift
// old
let centifoot = try Unit.define(
    name: "centifoot",
    symbol: "cft",
    dimension: [.Length: 1],
    coefficient: 0.003048
)

// new
let registryBuilder = RegistryBuilder()
registryBuilder.addUnit(
    name: "centifoot",
    symbol: "cft",
    dimension: [.Length: 1],
    coefficient: 0.003048
)
let registry = registryBuilder.registry()
```

## Registry Encode/Decode support

To provide `Registry` lookup support inside `Encode`/`Decode` processes, a `userInfo` key has been added:

```swift
let encoder = JSONEncoder()
encoder.userInfo[Unit.registryUserInfoKey] = Registry.default
try encoder.encode(Unit.meter / .second)

let decoder = JSONDecoder()
decoder.userInfo[Unit.registryUserInfoKey] = Registry.default
try decoder.decode(Unit.self, from: "\"m\\/s\"".data(using: .utf8)!)
```
