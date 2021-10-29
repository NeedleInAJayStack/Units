# Units 📏

Units is a Swift package to manipulate, compare, and convert between physical quantities. This package models measurements, 
which are a numerical value with a unit of measure. It supports arithmetic operations between measurements, conversion to and 
from different units, and dimensionality checks. With it, you can easily convert between any imaginable permutation of units. 
You want to convert `12 km³/hr/N` to `ft²*s/lb`? We've got you covered! 

## Conversion

Only linear conversions are supported. The vast majority of unit conversions are simply changes in scale, represented by a single
conversion coefficient, with an occasionaly shift by an additional constant.

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
non-constant Kelvin and Rankine temperature units to refer to temperature differentials.

## To Do:

- Add more defined units
- Documentation & Readme
- Allow user-defined quantities
- Improve interoperability with Foundation
- Add easier initializers (like `5.meters`, for example)
