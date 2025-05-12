# Units 📏

Units is a Swift package to manipulate, compare, and convert between physical quantities. This package models measurements, which are a numerical value with a unit of measure. It has been designed so that users don't need to worry whether they are using a defined unit (like `Newton`) or a complex composite unit (like `kg*m/s^2`). Both should be easy to convert to and from different units, perform arithmetic operations, check dimensionality, or serialize to and from a string format.

This approach allows us to easily handle any permutation of units. You want to convert `12 km³/hr/N` to `ft²*s/lb`? We've got you covered!

Included is a convenient command-line tool for performing quick unit conversions. See the [CLI section](#cli) for details.

## Getting Started

To start using Units, import it to your project via the `Package.swift` file:

```swift
    dependencies: [
        .package(url: "https://github.com/NeedleInAJayStack/Units", from: "0.0.1"),
```

This package has no other dependencies.

## Usage

Users should interact primarily with the `Measurement` struct. Here are a examples of arithmetic:

```swift
let drivingSpeed = 60.measured(in: .mile / .hour)
print(drivingSpeed.convert(to: .kilometer / .hour)) // Prints 96.56064 km/h

let drivingTime = 30.measured(in: .minute)
let drivingDistance = drivingSpeed * drivingTime
print(drivingDistance.convert(to: .mile)) // Prints 30 mi
```

Note that a measurement may be multiplied or divided by another measurement with any unit, resulting in a measurement that has a new-dimensioned unit (5 meters / 10 seconds ✅). However, addition and subtraction requires that both measurements have the same dimensionality (5 meters - 10 seconds ❌), otherwise a runtime error is thrown. If adding or subtracting two measurements with different units but the same dimensionality, the result retains the first measurement's unit (5 meters - 5 millimeters = 4.995 meters).

The type names in this package align closely with the unit system provided by `Foundation`. This was intentional to provide a familiar nomenclature for Swift developers. The APIs have been designed to avoid namespace ambiguity in files where both `Units` and `Foundation` are imported as much as possible. However, if an issue arises, just qualify the desired package like so:

```swift
let measurement = Units.Measurement(value: 5, unit: .mile)
```

## Scalars

This package provides a special `none` unit that represents a unitless scalar measurement:

```swift
let unitless = 5.measured(in: .none)
```

Measurements whose arithmetic has cancelled out units are also represented as unitless:

```swift
let a = 6.measured(in: .meter) / 2.measured(in: .meter)
print(a.unit)  // Prints 'none'
```

Measurements are also representible through `Int` or `Float` scalars, which are automatically interpreted as unitless:

```swift
let m: Measurement = 6  // Has unit of 'none'
```

This allows including scalar values directly in arithmetic equations:

```swift
let distance: 5.measured(in: .meter) * 3 / 1.measured(in: .second)
print(distance)  // Prints '15 m/s'
```

## Conversion

Only linear conversions are supported. The vast majority of unit conversions are simply changes in scale, represented by a single conversion coefficient, sometimes with a constant shift. Units that don't match this format (like currency conversions, which are typically time-based functions) are not supported.

Composite units are those that represent complex quantities and dimensions. A good example is `horsepower`, whose quantity is `mass * length^2 / time^2`.

### Coefficients

Each quantity has a single "base unit", through which the units of that quantity may be converted. SI units have been chosen to be these base units for all quantities.

Non-base units require a conversion coefficient to convert between them and other units of the same dimension. This coefficient is the number of base units there are in one of the defined unit. For example, `kilometer` has a coefficient of `1000` because there are 1000 meters in 1 kilometer.

Composite units must have a coefficient that converts to the composte SI units of those dimensions. That is, `horsepower` should have a conversion to `kilogram * meter^2 / second^2` (otherwise known as `watt`). This is natural for SI quantities and units, but care should be taken that a single, absolute base unit is chosen for all non-SI quantities since they will impact all composite conversions.

### Constants

Units that include a constant value, such as Fahrenheit, cannot be used within composite unit conversions. For example, you may not convert `5m/°F` to `m/°C` because its unclear how to handle their shifted scale. Instead use the non-shifted Kelvin and Rankine temperature units to refer to temperature differentials.

## Serialization

Each defined unit must have a unique symbol, which is used to identify and serialize/deserialize it. Defined unit symbols are not allowed to contain the `*`, `/`, `^`, or ` ` characters because those are used in the symbol representation of complex units. Complex units are represented by their arithmetic combination of simple units using `*` for multiplication, `/` for division, and `^` for exponentiation. Order of operations treats exponentiation first, and multiplication and division equally, from left-to-right. This means that, unless negatively exponentiated, units following a `*` can always be considered to be "in the numerator", and those following `/` can always be considered to be "in the denominator".

Here are a few examples:

- `kW*hr`: kilowatt-hours
- `m/s`: meters per second
- `m^2/s^2`: square meters per square seconds
- `kg*m/s`: kilogram-meters per second.
- `m/s*kg`: equivalent to `kg*m/s`
- `m^1*s^-1*kg^1`: equivalent to `kg*m/s`

Measurements are represented as the numeric value followed by the serialized unit with an optional space. For example, `5m/s` or `5 m/s`.

Expressions are a mathematical combination of measurements. Arithemetic operators, exponents, and sub-expressions are supported. Here are a few expression examples:

- `5m + 3m`
- `5.3 m + 3.8 m`
- `5m^2/s + (1m + 2m)^2 / 5s`

There are few expression parsing rules to keep in mind:

- All parentheses must be matched
- All measurement operators must have a leading and following space. i.e. ` * `
- Only integer exponentiation is supported
- Exponentiated measurements must have parentheses to avoid ambiguity with units. i.e. `(3m)^2`

## Default Units

For a list of the default units and their conversion factors, see the [`DefaultUnits.swift file`](https://github.com/NeedleInAJayStack/Units/blob/main/Sources/Units/Unit/DefaultUnits.swift)

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

### Non-scientific Units

For "non-scientific" units, it is typically appropriate to use the `Amount` quantity. Through this approach, you can easily build up an impromptu conversion system on the fly. For example:

```swift
let apple = try Unit.define(
    name: "apple",
    symbol: "apple",
    dimension: [.Amount: 1],
    coefficient: 1
)

let carton = try Unit.define(
    name: "carton",
    symbol: "carton",
    dimension: [.Amount: 1],
    coefficient: 48
)

let harvest = 288.measured(in: apple)
print(harvest.convert(to: carton)) // Prints '6.0 carton'
```

We can extend this example to determine how many cartons a group of people can pick in a week:

```swift
let person = try Unit.define(
    name: "person",
    symbol: "person",
    dimension: [.Amount: 1],
    coefficient: 1
)

let personPickRate = 600.measured(in: apple / .day / person)
let workforce = 4.measured(in: person)
let weeklyCartons = try (workforce * personPickRate).convert(to: carton / .week)
print(weeklyCartons)  // Prints '350.0 carton/week'
```

### Adding custom units to the Registry

To support deserialization and runtime querying of available units, this package keeps a global registry of the default units. The `Unit.define` method does not insert new definitions into this registry. While this avoids conflicts and prevents race conditions, it also means that units created using `Unit.define` cannot be deserialized correctly or looked up using `Unit(fromSymbol:)`

If these features are absolutely needed, and the implications are understood, custom units can be added to the registry using `Unit.register`:

```swift
let centifoot = try Unit.register(
    name: "centifoot",
    symbol: "cft",
    dimension: [.Length: 1],
    coefficient: 0.003048 // This is the conversion to meters
)
```

Note that you may only register the unit once globally, and afterwards it should be accessed either by the assigned variable or using `Unit(fromSymbol: String)`.

To simplify access, `Unit` may be extended with a static property:

```swift
extension Unit {
    public static var centifoot = try! Unit.fromSymbol("cft")
}

let measurement = 5.measured(in: .centifoot)
```

Again, unless strictly necessary, `Unit.define` is preferred over `Unit.register`.

## CLI

The easiest way to install the CLI is with brew:

```sh
brew tap NeedleInAJayStack/tap
brew install units
```

Alternatively, you can build it from source and install it to `/usr/local/bin/` using the install script. Note that [swift](https://www.swift.org/download/) must be installed, and you need write permissions to `/usr/local/bin/`.

```bash
./install.sh
```

To uninstall, run:

```bash
./uninstall.sh
```

### Convert

You can then perform unit conversions using the `unit convert` command:

```bash
unit convert 5m/s mi/hr  # Returns 11.184681460272012 mi/hr
```

This command uses the unit and expression [serialization format](#serialization). Note that for convenience, you may use an underscore `_` to represent the normally serialized space. Also, `*` characters may need to be escaped.

You can also evaulate math in the first argument. For example:

```bash
unit convert "60mi/hr * 30min" "mi"  # Returns 30.0 mi
```

### List

To list the available units, use the `unit list` command:

```bash
unit list
```

## Contributing

Contributions are absolutely welcome! If you find yourself using a custom unit a lot, feel free to stick it in an MR, and we can add it to the default list!
