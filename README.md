# Units 📏

Units is a Swift package to manipulate, compare, and convert between physical quantities. This package models measurements, 
which are a numerical value with a unit of measure. It has been designed so that users don't need to worry whether they are 
using a defined unit (like `Newton`) or a complex composite unit (like `kg*m/s^2`). Both should be easy to convert to and from
different units, perform arithmetic operations, check dimensionality, or serialize to and from a string format.

This approach allows us to easily handle any permutation of units. You want to convert `12 km³/hr/N` to 
`ft²*s/lb`? We've got you covered!

## Getting Started

To start using Units, import it to your project via the `Package.swift` file:

```swift
    dependencies: [
        .package(url: "https://github.com/NeedleInAJayStack/Units", from: "0.0.1"),
```

This package has no other dependencies.

## Usage

Users should interact primarily with the `Measurement` struct. Here are a few usage examples:

```swift
let drivingSpeed = 60.measured(in: .mile / .hour)
print(drivingSpeed.convert(to: .kilometer / .hour)) // Prints 96.56064 km/h

let drivingTime = 30.measured(in: .minute)
let drivingDistance = drivingSpeed * drivingTime
print(drivingDistance.convert(to: .mile)) // Prints 30 mi
```

The type names in this package align closely with the unit system provided by `Foundation`. This was intentional to provide a 
familiar nomenclature for Swift developers. The APIs have been designed to avoid namespace ambiguity in files where both `Units` 
and `Foundation` are imported as much as possible. However, if an issue arises, just qualify the desired package like so:

```swift
let measurement = Units.Measurement(value: 5, unit: .mile)
``` 

## Conversion

Only linear conversions are supported. The vast majority of unit conversions are simply changes in scale, represented by a single
conversion coefficient, sometimes with a constant shift. Units that don't match this format (like currency conversions, which are
typically time-based functions) are not supported.

Composite units are those that represent complex quantities and dimensions. A good example is `horsepower`, whose quantity is 
`mass * length^2 / time^2`.

### Coefficients

Each quantity has a single "base unit", through which the units of that quantity may be converted. SI units have been
chosen to be these base units for all quantities.

Non-base units require a conversion coefficient to convert between them and other units of the same dimension. This coefficient
is the number of base units there are in one of the defined unit. For example, `kilometer` has a coefficient of `1000` 
because there are 1000 meters in 1 kilometer.

Composite units must have a coefficient that converts to the composte SI units of those dimensions. That is, `horsepower` should 
have a conversion to `kilogram * meter^2 / second^2` (otherwise known as `watt`). This is natural for SI quantities and units, but
care should be taken that a single, absolute base unit is chosen for all non-SI quantities since they will impact all composite 
conversions.

### Constants

Units that include a constant value, such as Fahrenheit, cannot be used within composite unit conversions. For example,
you may not convert `5m/°F` to `m/°C` because its unclear how to handle their shifted scale. Instead use the 
non-shifted Kelvin and Rankine temperature units to refer to temperature differentials.

## Serialization

Each defined unit must have a unique symbol, which is used to identify and serialize/deserialize it. These symbols are not allowed to
contain the `*`, `/`, or `^` characters because those are used in the symbol representation of complex units.

## Custom Units

To extend this package, users can define their own custom units using `Unit.define`:

```swift
let centifoot = try Unit.define(
    name: "centifoot",
    symbol: "cft",
    dimension: [.Length: 1],
    coefficient: 0.003048 // This is the conversion to meters
)

let measurement = Measurement(value: 5, unit: centifoot)
print(5.measured(in: .foot).convert(to: centifoot))
```

This returns a Unit object that can be used in arithmetic, conversions, and serialization.

### Adding custom units to the Registry

To support deserialization and runtime querying of available units, this package keeps a global
registry of the default units. The `Unit.define` method does not insert new definitions into this
registry. While this avoids conflicts and prevents race conditions, it also means that units created
using `Unit.define` cannot be deserialized correctly or looked up using `Unit(fromSymbol:)` 

If these features are absolutely needed, and the implications are understood, custom units can be
added to the registry using `Unit.register`:

```swift
let centifoot = try Unit.register(
    name: "centifoot",
    symbol: "cft",
    dimension: [.Length: 1],
    coefficient: 0.003048 // This is the conversion to meters
)
```

Note that you may only register the unit once globally, and afterwards it should be accessed 
either by the assigned variable or using `Unit(fromSymbol: String)`.

To simplify access, `Unit` may be extended with a static property:

```swift
extension Unit {
    public static var centifoot = try! Unit.fromSymbol("cft")
}

let measurement = 5.measured(in: .centifoot)
```

Again, unless strictly necessary, `Unit.define` is preferred over `Unit.register`.

## Contributing

Contributions are absolutely welcome! If you find yourself using a custom unit a lot, feel free
to stick it in an MR, and we can add it to the default list!

