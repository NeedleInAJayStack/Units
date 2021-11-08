# Units 📏

Units is a Swift package to manipulate, compare, and convert between physical quantities. This package models measurements, 
which are a numerical value with a unit of measure. It has been designed so that users don't need to worry whether they are 
using a defined unit (like `Newton`) or a complex composite unit (like `kg*m/s^2`). Both should be easy to convert to and from
different units, perform arithmetic operations, check dimensionality, or serialize to and from a string format.

This approach allows us to easily handle any permutation of units imaginable. You want to convert `12 km³/hr/N` to 
`ft²*s/lb`? We've got you covered!

## Usage

Users should interact primarily with Measurements. Here are a few usage examples:

```swift
let drivingSpeed = 60.measured(in: .mile / .hour)
print(drivingSpeed.convert(to: .kilometer / .hour)) // Prints 96.56064 km/h

let drivingTime = 30.measured(in: .minute)
let drivingDistance = drivingSpeed * drivingTime
print(drivingDistance.convert(to: .mile)) // Prints 30 mi
```

## Conversion

Only linear conversions are supported. The vast majority of unit conversions are simply changes in scale, represented by a single
conversion coefficient, sometimes with a constant shift. Units that don't match this format (like currency conversions, which are
typically time-based functions) are not supported.

### Coefficients

Each quantity should have a single "base unit", through which the units of that quantity may be converted. SI units have been
chosen to be these base units for all quantities.

Non-base units require a conversion coefficient to convert between them and other units of the same dimension. This coefficient
value should be what a base unit is multiplied by to result in the defined unit. For example, `kilometer` should have a coefficient
of `1000` because there are 1000 meters in 1 kilometer.

Defined units of complex quantities (`horsepower`, for example) must have coefficients that convert to the SI unit of that dimension.
That is, `horsepower` should have a conversion to `kilogram * meter^2 / second^2` (otherwise known as `watt`)

### Constants

Units that include a constant value, such as Fahrenheit, cannot be used within composite unit convertions. For example,
you may not convert `5m/°F` to `m/°C` because its unclear how to handle their shifted scale. Instead use the 
non-shifted Kelvin and Rankine temperature units to refer to temperature differentials.

## Codability

Each defined unit must have a unique symbol, which is used to identify and encode/decode it. These symbols must not contain
the `*`, `/`, or `^` characters because those are used in the symbol representation of complex units.

## Custom Units

To support serialization, Unit is backed by a global registry which is populated with many values by default. However,
you may add your own custom units to this registry using the `Unit.define` function.

```swift
let centifoot = try Unit.define(
    name: "centifoot",
    symbol: "cft",
    dimension: [.Length: 1],
    coefficient: 0.003048 // This is the conversion to meters
)

let measurement = Measurement(value: 5, unit: centifoot)
```

Note that you can only define the unit once globally, and afterwards it should be accessed using `Unit(fromSymbol: String)`. 
If desired, you can simplify access by extending `Unit` with a static property:

```swift
extension Unit {
    public static var centifoot = Unit.fromSymbol("cft")
}

let measurement = Measurement(value: 5, unit: .centifoot)
```

## To Do:

- Add more defined units
- Allow user-defined quantities
