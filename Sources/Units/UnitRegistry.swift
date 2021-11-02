/// UnitRegistry defines a structure that contains all defined units. This ensures
/// that we are able to parse to and from unit symbol representations.
class UnitRegistry {
    
    // TODO: Should we eliminate this singleton and make clients keep track?
    static let instance = UnitRegistry()
    
    // Store units as a dictionary based on symbol for fast access
    // TODO: Change to Unit to avoid creating multiple Units in memory
    private var units: [String: DefinedUnit]
    private init() {
        self.units = [:]
        for defaultUnit in UnitRegistry.defaultUnits {
            // Protect against double-defining symbols
            if self.units[defaultUnit.symbol] != nil {
                fatalError("Duplicate symbol: \(defaultUnit.symbol)")
            }
            self.units[defaultUnit.symbol] = defaultUnit
        }
    }
    
    /// Parses a string symbol into a unit. This supports composite units and is able to correspond directly with
    /// `Unit.symbol`
    public func fromSymbol(_ symbol: String) throws -> Unit {
        if symbol.contains("*") || symbol.contains("/") || symbol.contains("^") {
            var compositeUnits: [DefinedUnit: Int] = [:]
            for multSymbol in symbol.split(separator: "*", omittingEmptySubsequences: false) {
                for (index, divSymbol) in multSymbol.split(separator: "/", omittingEmptySubsequences: false).enumerated() {
                    let symbolSplit = divSymbol.split(separator: "^", omittingEmptySubsequences: false)
                    let subSymbol = String(symbolSplit[0])
                    var exp = 1
                    if symbolSplit.count == 2 {
                        guard let expInt = Int(String(symbolSplit[1])) else {
                            throw UnitError.invalidSymbol(message: "Symbol '^' must be followed by an integer: \(symbol)")
                        }
                        exp = expInt
                    }
                    if index > 0 {
                        exp = -1 * exp
                    }
                    guard subSymbol != "1" else {
                        continue
                    }
                    guard subSymbol != "" else {
                        throw UnitError.unitNotFound(message: "Expected subsymbol missing")
                    }
                    guard let subUnit = units[subSymbol] else {
                        throw UnitError.unitNotFound(message: "Symbol '\(subSymbol)' not recognized")
                    }
                    compositeUnits[subUnit] = exp
                }
            }
            return Unit(composedOf: compositeUnits)
        } else {
            guard let unit = units[symbol] else {
                throw UnitError.unitNotFound(message: "Symbol '\(symbol)' not recognized")
            }
            return Unit(definedBy: unit)
        }
    }
    
    /// Define a new unit to add to the registry
    /// - parameter name: The string name of the unit.
    /// - parameter symbol: The string symbol of the unit. Symbols may not contain the characters `*`, `/`, or `^`.
    /// - parameter dimension: The unit dimensionality as a dictionary of quantities and their respective exponents.
    /// - parameter coefficient: The value to multiply a base unit of this dimension when converting it to this unit. For base units, this is 1.
    /// - parameter constant: The value to add to a base unit when converting it to this unit. This is added after the coefficient is multiplied according to order-of-operations.
    public func addUnit(
        name: String,
        symbol: String,
        dimension: [Quantity: Int],
        coefficient: Double = 1,
        constant: Double = 0
    ) throws {
        let newUnit = try DefinedUnit(name: name, symbol: symbol, dimension: dimension, coefficient: coefficient, constant: constant)
        self.units[symbol] = newUnit
    }
    
    /// Returns all units currently defined by the registry
    public func allUnits() -> [Unit] {
        var allUnits = [Unit]()
        for (_, unit) in units {
            allUnits.append(Unit(definedBy: unit))
        }
        return allUnits
    }
    
    private static let defaultUnits: [DefinedUnit] = [
        // MARK: Acceleration
        // Base unit is m/s^2
        try! DefinedUnit(
            name: "standardGravity",
            symbol: "ɡ",
            dimension: [.Length: 1, .Time: -2],
            coefficient: 9.80665
        ),
        
        // MARK: Amount
        try! DefinedUnit(
            name: "mole",
            symbol: "mol",
            dimension: [.Amount: 1]
        ),
        try! DefinedUnit(
            name: "millimole",
            symbol: "mmol",
            dimension: [.Amount: 1],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "particle",
            symbol: "particle",
            dimension: [.Amount: 1],
            coefficient: 6.02214076E23
        ),
        
        // MARK: Angle
        try! DefinedUnit(
            name: "radian",
            symbol: "rad",
            dimension: [.Angle: 1]
        ),
        try! DefinedUnit(
            name: "degree",
            symbol: "°",
            dimension: [.Angle: 1],
            coefficient: 180 / Double.pi
        ),
        
        // MARK: Area
        // Base unit is m^2
        try! DefinedUnit(
            name: "acre",
            symbol: "ac",
            dimension: [.Length: 2],
            coefficient: 4046.8564224
        ),
        try! DefinedUnit(
            name: "are",
            symbol: "a",
            dimension: [.Length: 2],
            coefficient: 100
        ),
        try! DefinedUnit(
            name: "hectare",
            symbol: "ha",
            dimension: [.Length: 2],
            coefficient: 10000
        ),
        
        // MARK: Capacitance
        try! DefinedUnit(
            name: "farad",
            symbol: "F",
            dimension: [.Current: 2, .Time: 4, .Length: -2, .Mass: -1]
        ),
        
        // MARK: Charge
        try! DefinedUnit(
            name: "coulomb",
            symbol: "C",
            dimension: [.Current: 1, .Time: 1]
        ),
        
        // MARK: Current
        try! DefinedUnit(
            name: "ampere",
            symbol: "A",
            dimension: [.Current: 1]
        ),
        try! DefinedUnit(
            name: "microampere",
            symbol: "μA",
            dimension: [.Current: 1],
            coefficient: 1e-6
        ),
        try! DefinedUnit(
            name: "milliampere",
            symbol: "mA",
            dimension: [.Current: 1],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "kiloampere",
            symbol: "kA",
            dimension: [.Current: 1],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "megaampere",
            symbol: "MA",
            dimension: [.Current: 1],
            coefficient: 1e6
        ),
        
        // MARK: Data
        try! DefinedUnit(
            name: "bit",
            symbol: "bit",
            dimension: [.Data: 1]
        ),
        try! DefinedUnit(
            name: "byte",
            symbol: "byte",
            dimension: [.Data: 1],
            coefficient: 8
        ),
        try! DefinedUnit(
            name: "kilobyte",
            symbol: "kB",
            dimension: [.Data: 1],
            coefficient: 8000
        ),
        try! DefinedUnit(
            name: "megabyte",
            symbol: "MB",
            dimension: [.Data: 1],
            coefficient: 8e6
        ),
        try! DefinedUnit(
            name: "gigabyte",
            symbol: "GB",
            dimension: [.Data: 1],
            coefficient: 8e9
        ),
        try! DefinedUnit(
            name: "petabyte",
            symbol: "PB",
            dimension: [.Data: 1],
            coefficient: 8e12
        ),
        
        // MARK: Electric Potential Difference
        try! DefinedUnit(
            name: "volt",
            symbol: "V",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1]
        ),
        try! DefinedUnit(
            name: "microvolt",
            symbol: "μV",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
            coefficient: 1e-6
        ),
        try! DefinedUnit(
            name: "millivolt",
            symbol: "mV",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "kilovolt",
            symbol: "kV",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "megavolt",
            symbol: "MV",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
            coefficient: 1e6
        ),
        
        // MARK: Energy
        try! DefinedUnit(
            name: "joule",
            symbol: "J",
            dimension: [.Mass: 1, .Length: 2, .Time: -2]
        ),
        try! DefinedUnit(
            name: "kilojoule",
            symbol: "kJ",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "calorie",
            symbol: "cal",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 4.184
        ),
        try! DefinedUnit(
            name: "kilocalorie",
            symbol: "kCal",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 4184
        ),
        try! DefinedUnit(
            name: "btu",
            symbol: "BTU",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1054.35
        ),
        try! DefinedUnit(
            name: "kilobtu",
            symbol: "kBTU",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1.05435E6
        ),
        try! DefinedUnit(
            name: "megabtu",
            symbol: "MBTU",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1.05435E9
        ),
        try! DefinedUnit(
            name: "therm",
            symbol: "therm",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1.05435E8
        ),
        try! DefinedUnit(
            name: "electronVolt",
            symbol: "eV",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1.602176634e-19
        ),
        
        // MARK: Force
        try! DefinedUnit(
            name: "newton",
            symbol: "N",
            dimension: [.Mass: 1, .Length: 1, .Time: -2]
        ),
        try! DefinedUnit(
            name: "poundForce",
            symbol: "lbf",
            dimension: [.Mass: 1, .Length: 1, .Time: -2],
            coefficient: 4.448222
        ),
        
        // MARK: Frequency
        try! DefinedUnit(
            name: "hertz",
            symbol: "Hz",
            dimension: [.Time: -1]
        ),
        try! DefinedUnit(
            name: "nanohertz",
            symbol: "nHz",
            dimension: [.Time: -1],
            coefficient: 1e-9
        ),
        try! DefinedUnit(
            name: "microhertz",
            symbol: "μHz",
            dimension: [.Time: -1],
            coefficient: 1e-6
        ),
        try! DefinedUnit(
            name: "millihertz",
            symbol: "mHz",
            dimension: [.Time: -1],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "kilohertz",
            symbol: "kHz",
            dimension: [.Time: -1],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "megahertz",
            symbol: "MHz",
            dimension: [.Time: -1],
            coefficient: 1e6
        ),
        try! DefinedUnit(
            name: "gigahertz",
            symbol: "GHz",
            dimension: [.Time: -1],
            coefficient: 1e9
        ),
        try! DefinedUnit(
            name: "terahertz",
            symbol: "THz",
            dimension: [.Time: -1],
            coefficient: 1e12
        ),
        
        // MARK: Illuminance
        try! DefinedUnit(
            name: "lux",
            symbol: "lx",
            dimension: [.LuminousIntensity: 1, .Length: -2]
        ),
        try! DefinedUnit(
            name: "footCandle",
            symbol: "fc",
            dimension: [.LuminousIntensity: 1, .Length: -2],
            coefficient: 10.76
        ),
        try! DefinedUnit(
            name: "phot",
            symbol: "phot",
            dimension: [.LuminousIntensity: 1, .Length: -2],
            coefficient: 10000
        ),
        
        // MARK: Inductance
        try! DefinedUnit(
            name: "henry",
            symbol: "H",
            dimension: [.Length: 2, .Mass: 1, .Current: -2]
        ),
        
        // MARK: Length
        try! DefinedUnit(
            name: "meter",
            symbol: "m",
            dimension: [.Length: 1]
        ),
        try! DefinedUnit(
            name: "picometer",
            symbol: "pm",
            dimension: [.Length: 1],
            coefficient: 1e-12
        ),
        try! DefinedUnit(
            name: "nanoometer",
            symbol: "nm",
            dimension: [.Length: 1],
            coefficient: 1e-9
        ),
        try! DefinedUnit(
            name: "micrometer",
            symbol: "μm",
            dimension: [.Length: 1],
            coefficient: 1e-6
        ),
        try! DefinedUnit(
            name: "millimeter",
            symbol: "mm",
            dimension: [.Length: 1],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "centimeter",
            symbol: "cm",
            dimension: [.Length: 1],
            coefficient: 0.01
        ),
        try! DefinedUnit(
            name: "decameter",
            symbol: "dm",
            dimension: [.Length: 1],
            coefficient: 10
        ),
        try! DefinedUnit(
            name: "hectometer",
            symbol: "hm",
            dimension: [.Length: 1],
            coefficient: 100
        ),
        try! DefinedUnit(
            name: "kilometer",
            symbol: "km",
            dimension: [.Length: 1],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "megameter",
            symbol: "Mm",
            dimension: [.Length: 1],
            coefficient: 1e6
        ),
        try! DefinedUnit(
            name: "inch",
            symbol: "in",
            dimension: [.Length: 1],
            coefficient: 0.0254
        ),
        try! DefinedUnit(
            name: "foot",
            symbol: "ft",
            dimension: [.Length: 1],
            coefficient: 0.3048
        ),
        try! DefinedUnit(
            name: "yard",
            symbol: "yd",
            dimension: [.Length: 1],
            coefficient: 0.9144
        ),
        try! DefinedUnit(
            name: "mile",
            symbol: "mi",
            dimension: [.Length: 1],
            coefficient: 1609.344
        ),
        try! DefinedUnit(
            name: "scandanavianMile",
            symbol: "smi",
            dimension: [.Length: 1],
            coefficient: 10000
        ),
        try! DefinedUnit(
            name: "nauticalMile",
            symbol: "NM",
            dimension: [.Length: 1],
            coefficient: 1852
        ),
        try! DefinedUnit(
            name: "fathom",
            symbol: "fathom",
            dimension: [.Length: 1],
            coefficient: 1.8288
        ),
        try! DefinedUnit(
            name: "furlong",
            symbol: "furlong",
            dimension: [.Length: 1],
            coefficient: 201.168
        ),
        try! DefinedUnit(
            name: "astronomicalUnit",
            symbol: "au",
            dimension: [.Length: 1],
            coefficient: 1.495978707e11
        ),
        try! DefinedUnit(
            name: "lightyear",
            symbol: "ly",
            dimension: [.Length: 1],
            coefficient: 9.4607304725808e15
        ),
        try! DefinedUnit(
            name: "parsec",
            symbol: "pc",
            dimension: [.Length: 1],
            coefficient: 3.0856775814913673e16
        ),
        
        // MARK: Luminous Intensity
        try! DefinedUnit(
            name: "candela",
            symbol: "cd",
            dimension: [.LuminousIntensity: 1]
        ),
        
        // MARK: Magnetic Flux
        try! DefinedUnit(
            name: "weber",
            symbol: "Wb",
            dimension: [.Mass: 1, .Length: 2, .Time: -2, .Current: -1]
        ),
        
        // MARK: Magnetic Flux Density
        try! DefinedUnit(
            name: "tesla",
            symbol: "T",
            dimension: [.Mass: 1, .Time: -2, .Current: -1]
        ),
        
        // MARK: Mass
        try! DefinedUnit(
            name: "kilogram",
            symbol: "kg",
            dimension: [.Mass: 1]
        ),
        try! DefinedUnit(
            name: "picogram",
            symbol: "pg",
            dimension: [.Mass: 1],
            coefficient: 1e-15
        ),
        try! DefinedUnit(
            name: "nanogram",
            symbol: "ng",
            dimension: [.Mass: 1],
            coefficient: 1e-12
        ),
        try! DefinedUnit(
            name: "microgram",
            symbol: "μg",
            dimension: [.Mass: 1],
            coefficient: 1e-9
        ),
        try! DefinedUnit(
            name: "milligram",
            symbol: "mg",
            dimension: [.Mass: 1],
            coefficient: 1e-6
        ),
        try! DefinedUnit(
            name: "centigram",
            symbol: "cg",
            dimension: [.Mass: 1],
            coefficient: 0.00001
        ),
        try! DefinedUnit(
            name: "decigram",
            symbol: "dg",
            dimension: [.Mass: 1],
            coefficient: 0.0001
        ),
        try! DefinedUnit(
            name: "gram",
            symbol: "g",
            dimension: [.Mass: 1],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "metricTon",
            symbol: "t",
            dimension: [.Mass: 1],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "carat",
            symbol: "ct",
            dimension: [.Mass: 1],
            coefficient: 0.0002
        ),
        try! DefinedUnit(
            name: "ounce",
            symbol: "oz",
            dimension: [.Mass: 1],
            coefficient: 0.028349523125
        ),
        try! DefinedUnit(
            name: "pound",
            symbol: "lb",
            dimension: [.Mass: 1],
            coefficient: 0.45359237
        ),
        try! DefinedUnit(
            name: "stone",
            symbol: "st",
            dimension: [.Mass: 1],
            coefficient: 6.35029318
        ),
        try! DefinedUnit(
            name: "shortTon",
            symbol: "ton",
            dimension: [.Mass: 1],
            coefficient: 907.18474
        ),
        try! DefinedUnit(
            name: "troyOunces",
            symbol: "troyOunces",
            dimension: [.Mass: 1],
            coefficient: 0.0311034768
        ),
        try! DefinedUnit(
            name: "slug",
            symbol: "slug",
            dimension: [.Mass: 1],
            coefficient: 14.5939
        ),
        
        // MARK: Power
        try! DefinedUnit(
            name: "watt",
            symbol: "W",
            dimension: [.Mass: 1, .Length: 2, .Time: -3]
        ),
        try! DefinedUnit(
            name: "femptowatt",
            symbol: "fW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e-15
        ),
        try! DefinedUnit(
            name: "picowatt",
            symbol: "pW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e-12
        ),
        try! DefinedUnit(
            name: "nanowatt",
            symbol: "nW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e-9
        ),
        try! DefinedUnit(
            name: "microwatt",
            symbol: "μW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e-6
        ),
        try! DefinedUnit(
            name: "milliwatt",
            symbol: "mW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "kilowatt",
            symbol: "kW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "megawatt",
            symbol: "MW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e6
        ),
        try! DefinedUnit(
            name: "gigawatt",
            symbol: "GW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e9
        ),
        try! DefinedUnit(
            name: "terawatt",
            symbol: "TW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e12
        ),
        try! DefinedUnit(
            name: "horsepower",
            symbol: "hp",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 745.6998715822702
        ),
        try! DefinedUnit(
            name: "tonRefrigeration",
            symbol: "TR",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 3500
        ),
        
        // MARK: Pressure
        try! DefinedUnit(
            name: "pascal",
            symbol: "Pa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2]
        ),
        try! DefinedUnit(
            name: "hectopascal",
            symbol: "hPa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 100
        ),
        try! DefinedUnit(
            name: "kilopascal",
            symbol: "kPa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "megapascal",
            symbol: "MPa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 1e6
        ),
        try! DefinedUnit(
            name: "gigapascal",
            symbol: "GPa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 1e9
        ),
        try! DefinedUnit(
            name: "bar",
            symbol: "bar",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 100000
        ),
        try! DefinedUnit(
            name: "millibar",
            symbol: "mbar",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 100
        ),
        try! DefinedUnit(
            name: "atmosphere",
            symbol: "atm",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 101317.1
        ),
        try! DefinedUnit(
            name: "millimeterOfMercury",
            symbol: "mmhg",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 133.322387415
        ),
        try! DefinedUnit(
            name: "centimeterOfMercury",
            symbol: "cmhg",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 1333.22387415
        ),
        try! DefinedUnit(
            name: "inchOfMercury",
            symbol: "inhg",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 3386.389
        ),
        try! DefinedUnit(
            name: "centimeterOfWater",
            symbol: "cmH₂0",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 98.0665
        ),
        try! DefinedUnit(
            name: "inchOfWater",
            symbol: "inH₂0",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 249.082
        ),
        
        // MARK: Resistance
        try! DefinedUnit(
            name: "ohm",
            symbol: "Ω",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2]
        ),
        try! DefinedUnit(
            name: "microohm",
            symbol: "μΩ",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
            coefficient: 1e-6
        ),
        try! DefinedUnit(
            name: "milliohm",
            symbol: "mΩ",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "kiloohm",
            symbol: "kΩ",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "megaohm",
            symbol: "MΩ",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
            coefficient: 1e6
        ),
        
        // MARK: Solid Angle
        try! DefinedUnit(
            name: "steradian",
            symbol: "sr",
            dimension: [.Angle: 2]
        ),
        
        // MARK: Temperature
        try! DefinedUnit(
            name: "kelvin",
            symbol: "K",
            dimension: [.Temperature: 1]
        ),
        try! DefinedUnit(
            name: "celsius",
            symbol: "°C",
            dimension: [.Temperature: 1],
            constant: 273.15
        ),
        try! DefinedUnit(
            name: "fahrenheit",
            symbol: "°F",
            dimension: [.Temperature: 1],
            coefficient: 5.0/9.0,
            constant: 273.15 - (32 * 5.0/9.0)
        ),
        try! DefinedUnit(
            name: "rankine",
            symbol: "°R",
            dimension: [.Temperature: 1],
            coefficient: 5.0/9.0
        ),
        
        // MARK: Time
        try! DefinedUnit(
            name: "second",
            symbol: "s",
            dimension: [.Time: 1]
        ),
        try! DefinedUnit(
            name: "nanosecond",
            symbol: "ns",
            dimension: [.Time: 1],
            coefficient: 1E-9
        ),
        try! DefinedUnit(
            name: "microsecond",
            symbol: "μs",
            dimension: [.Time: 1],
            coefficient: 1E-6
        ),
        try! DefinedUnit(
            name: "millisecond",
            symbol: "ms",
            dimension: [.Time: 1],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "minute",
            symbol: "min",
            dimension: [.Time: 1],
            coefficient: 60
        ),
        try! DefinedUnit(
            name: "hour",
            symbol: "hr",
            dimension: [.Time: 1],
            coefficient: 3600
        ),
        
        // MARK: Velocity
        // Base unit is m/s
        try! DefinedUnit(
            name: "knots",
            symbol: "knot",
            dimension: [.Length: 1, .Time: -1],
            coefficient: 0.514444
        ),
        
        // MARK: Volume
        // Base unit is meter^3
        try! DefinedUnit(
            name: "liter",
            symbol: "L",
            dimension: [.Length: 3],
            coefficient: 0.001
        ),
        try! DefinedUnit(
            name: "milliliter",
            symbol: "mL",
            dimension: [.Length: 3],
            coefficient: 1e-6
        ),
        try! DefinedUnit(
            name: "centiliter",
            symbol: "cL",
            dimension: [.Length: 3],
            coefficient: 1e-5
        ),
        try! DefinedUnit(
            name: "deciliter",
            symbol: "dL",
            dimension: [.Length: 3],
            coefficient: 1e-4
        ),
        try! DefinedUnit(
            name: "kiloliter",
            symbol: "kL",
            dimension: [.Length: 3],
            coefficient: 1
        ),
        try! DefinedUnit(
            name: "megaliter",
            symbol: "ML",
            dimension: [.Length: 3],
            coefficient: 1000
        ),
        try! DefinedUnit(
            name: "bushel",
            symbol: "bushel",
            dimension: [.Length: 3],
            coefficient: 0.03523907
        ),
        try! DefinedUnit(
            name: "teaspoon",
            symbol: "tsp",
            dimension: [.Length: 3],
            coefficient: 4.92892159375e-6
        ),
        try! DefinedUnit(
            name: "tablespoon",
            symbol: "tbsp",
            dimension: [.Length: 3],
            coefficient: 14.7867647812e-6
        ),
        try! DefinedUnit(
            name: "fluidOunce",
            symbol: "fl_oz",
            dimension: [.Length: 3],
            coefficient: 29.5735295625e-6
        ),
        try! DefinedUnit(
            name: "cup",
            symbol: "cup",
            dimension: [.Length: 3],
            coefficient: 236.5882365e-6
        ),
        try! DefinedUnit(
            name: "pint",
            symbol: "pt",
            dimension: [.Length: 3],
            coefficient: 473.176473e-6
        ),
        try! DefinedUnit(
            name: "gallon",
            symbol: "gal",
            dimension: [.Length: 3],
            coefficient: 0.003785411784
        ),
        try! DefinedUnit(
            name: "imperialFluidOunce",
            symbol: "ifl_oz",
            dimension: [.Length: 3],
            coefficient: 28.4130625e-6
        ),
        try! DefinedUnit(
            name: "imperialCup",
            symbol: "icup",
            dimension: [.Length: 3],
            coefficient: 197.15686375-6
        ),
        try! DefinedUnit(
            name: "imperialPint",
            symbol: "ipt",
            dimension: [.Length: 3],
            coefficient: 568.26125e-6
        ),
        try! DefinedUnit(
            name: "imperialGallon",
            symbol: "igal",
            dimension: [.Length: 3],
            coefficient: 0.00454609
        ),
        try! DefinedUnit(
            name: "metricCup",
            symbol: "mcup",
            dimension: [.Length: 3],
            coefficient: 0.00025
        )
    ]
}
