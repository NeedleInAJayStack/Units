# Units

A description of this package.

## Constant Values

Units that include a constant value, such as Fahrenheit, cannot be used within composite unit convertions. For example,
you may not convert `5m/°F` to `m/°C` because its unclear how to handle their shifted scale. Instead use the 
non-constant kelvin and rankine temperature units to refer to temperature differentials.
