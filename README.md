# Units

A description of this package.

## Constant Values

Units that include a constant value, such as Fahrenheit, cannot be used within composite unit convertions. For example,
you may not convert `5m/°F` to `m/°C` because its unclear how to handle their shifted scale. Instead use the 
non-constant Kelvin and Rankine temperature units to refer to temperature differentials.

## To Do:

- Add unit registry system
- Add more defined units
- Add easier initializers (like `5.meters`, for example)
- Documentation & Readme
