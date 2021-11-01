class UnitRegistry {
    
    // TODO: Should we eliminate this singleton and make clients keep track?
    // Singleton access
    static let instance = UnitRegistry()
    
    // Store units as a dictionary based on symbol for fast access
    private var units: [String: DefinedUnit]
    private init() {
        self.units = [:]
        for defaultUnit in UnitRegistry.defaultUnits {
            // Protect against double-defining symbols
            if let alreadyDefined = self.units[defaultUnit.symbol] {
                fatalError("\(alreadyDefined.name) has same symbol as \(defaultUnit.name): \(defaultUnit.symbol)")
            }
            self.units[defaultUnit.symbol] = defaultUnit
        }
    }
    
    public func fromSymbol(_ symbol: String) throws -> Unit {
        guard let unit = units[symbol] else {
            throw UnitError.unitNotFound(message: "symbol '\(symbol)' not recognized")
        }
        return Unit(definedBy: unit)
    }
    
    public func addUnit(
        name: String,
        symbol: String,
        dimension: [Quantity: Int],
        coefficient: Double = 1,
        constant: Double = 0
    ) {
        let newUnit = DefinedUnit(name: name, symbol: symbol, dimension: dimension, coefficient: coefficient, constant: constant)
        self.units[symbol] = newUnit
    }
    
    public func allUnits() -> [Unit] {
        var allUnits = [Unit]()
        for (_, unit) in units {
            allUnits.append(Unit(definedBy: unit))
        }
        return allUnits
    }
    
    
    static let defaultUnits: [DefinedUnit] = [
        // MARK: Acceleration
        // Base unit is m/s^2
        DefinedUnit (
            name: "gravitationalAcceleration",
            symbol: "ɡ",
            dimension: [.Length: 1, .Time: -2],
            coefficient: 9.80665
        ),
        
        // MARK: Amount
        DefinedUnit (
            name: "mole",
            symbol: "mol",
            dimension: [.Amount: 1]
        ),
        DefinedUnit (
            name: "millimole",
            symbol: "mmol",
            dimension: [.Amount: 1],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "particle",
            symbol: "particle",
            dimension: [.Amount: 1],
            coefficient: 6.02214076E23
        ),
        
        // MARK: Angle
        DefinedUnit (
            name: "radian",
            symbol: "rad",
            dimension: [.Angle: 1]
        ),
        DefinedUnit (
            name: "degree",
            symbol: "°",
            dimension: [.Angle: 1],
            coefficient: 180 / Double.pi
        ),
        
        // MARK: Area
        // Base unit is m^2
        DefinedUnit (
            name: "acre",
            symbol: "ac",
            dimension: [.Length: 2],
            coefficient: 4046.8564224
        ),
        DefinedUnit (
            name: "are",
            symbol: "a",
            dimension: [.Length: 2],
            coefficient: 100
        ),
        DefinedUnit (
            name: "hectare",
            symbol: "ha",
            dimension: [.Length: 2],
            coefficient: 10000
        ),
        
        // MARK: Capacitance
        DefinedUnit (
            name: "farad",
            symbol: "F",
            dimension: [.Current: 2, .Time: 4, .Length: -2, .Mass: -1]
        ),
        
        // MARK: Charge
        DefinedUnit (
            name: "coulomb",
            symbol: "C",
            dimension: [.Current: 1, .Time: 1]
        ),
        
        // MARK: Current
        DefinedUnit (
            name: "ampere",
            symbol: "A",
            dimension: [.Current: 1]
        ),
        DefinedUnit (
            name: "microampere",
            symbol: "μA",
            dimension: [.Current: 1],
            coefficient: 1e-6
        ),
        DefinedUnit (
            name: "milliampere",
            symbol: "mA",
            dimension: [.Current: 1],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "kiloampere",
            symbol: "kA",
            dimension: [.Current: 1],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "megaampere",
            symbol: "MA",
            dimension: [.Current: 1],
            coefficient: 1e6
        ),
        
        // MARK: Data
        DefinedUnit (
            name: "bit",
            symbol: "bit",
            dimension: [.Data: 1]
        ),
        DefinedUnit (
            name: "byte",
            symbol: "byte",
            dimension: [.Data: 1],
            coefficient: 8
        ),
        DefinedUnit (
            name: "kilobyte",
            symbol: "kB",
            dimension: [.Data: 1],
            coefficient: 8000
        ),
        DefinedUnit (
            name: "megabyte",
            symbol: "MB",
            dimension: [.Data: 1],
            coefficient: 8e6
        ),
        DefinedUnit (
            name: "gigabyte",
            symbol: "GB",
            dimension: [.Data: 1],
            coefficient: 8e9
        ),
        DefinedUnit (
            name: "petabyte",
            symbol: "PB",
            dimension: [.Data: 1],
            coefficient: 8e12
        ),
        
        // MARK: Electric Potential Difference
        DefinedUnit (
            name: "volt",
            symbol: "V",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1]
        ),
        DefinedUnit (
            name: "microvolt",
            symbol: "μV",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
            coefficient: 1e-6
        ),
        DefinedUnit (
            name: "millivolt",
            symbol: "mV",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "kilovolt",
            symbol: "kV",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "megavolt",
            symbol: "MV",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
            coefficient: 1e6
        ),
        
        // MARK: Energy
        DefinedUnit (
            name: "joule",
            symbol: "J",
            dimension: [.Mass: 1, .Length: 2, .Time: -2]
        ),
        DefinedUnit (
            name: "kilojoule",
            symbol: "kJ",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "calorie",
            symbol: "cal",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 4.184
        ),
        DefinedUnit (
            name: "kilocalorie",
            symbol: "kCal",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 4184
        ),
        DefinedUnit (
            name: "btu",
            symbol: "BTU",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1054.35
        ),
        DefinedUnit (
            name: "kilobtu",
            symbol: "kBTU",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1.05435E6
        ),
        DefinedUnit (
            name: "megabtu",
            symbol: "MBTU",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1.05435E9
        ),
        DefinedUnit (
            name: "therm",
            symbol: "therm",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1.05435E8
        ),
        DefinedUnit (
            name: "electronVolt",
            symbol: "eV",
            dimension: [.Mass: 1, .Length: 2, .Time: -2],
            coefficient: 1.602176634e-19
        ),
        
        // MARK: Force
        DefinedUnit (
            name: "newton",
            symbol: "N",
            dimension: [.Mass: 1, .Length: 1, .Time: -2]
        ),
        DefinedUnit (
            name: "poundForce",
            symbol: "lbf",
            dimension: [.Mass: 1, .Length: 1, .Time: -2],
            coefficient: 4.448222
        ),
        
        // MARK: Frequency
        DefinedUnit (
            name: "hertz",
            symbol: "Hz",
            dimension: [.Time: -1]
        ),
        DefinedUnit (
            name: "nanohertz",
            symbol: "nHz",
            dimension: [.Time: -1],
            coefficient: 1e-9
        ),
        DefinedUnit (
            name: "microhertz",
            symbol: "μHz",
            dimension: [.Time: -1],
            coefficient: 1e-6
        ),
        DefinedUnit (
            name: "millihertz",
            symbol: "mHz",
            dimension: [.Time: -1],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "kilohertz",
            symbol: "kHz",
            dimension: [.Time: -1],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "megahertz",
            symbol: "MHz",
            dimension: [.Time: -1],
            coefficient: 1e6
        ),
        DefinedUnit (
            name: "gigahertz",
            symbol: "GHz",
            dimension: [.Time: -1],
            coefficient: 1e9
        ),
        DefinedUnit (
            name: "terahertz",
            symbol: "THz",
            dimension: [.Time: -1],
            coefficient: 1e12
        ),
        
        // MARK: Illuminance
        DefinedUnit (
            name: "lux",
            symbol: "lx",
            dimension: [.LuminousIntensity: 1, .Length: -2]
        ),
        DefinedUnit (
            name: "footCandle",
            symbol: "fc",
            dimension: [.LuminousIntensity: 1, .Length: -2],
            coefficient: 10.76
        ),
        DefinedUnit (
            name: "phot",
            symbol: "phot",
            dimension: [.LuminousIntensity: 1, .Length: -2],
            coefficient: 10000
        ),
        
        // MARK: Inductance
        DefinedUnit (
            name: "henry",
            symbol: "H",
            dimension: [.Length: 2, .Mass: 1, .Current: -2]
        ),
        
        // MARK: Length
        DefinedUnit (
            name: "meter",
            symbol: "m",
            dimension: [.Length: 1]
        ),
        DefinedUnit (
            name: "picometer",
            symbol: "pm",
            dimension: [.Length: 1],
            coefficient: 1e-12
        ),
        DefinedUnit (
            name: "nanoometer",
            symbol: "nm",
            dimension: [.Length: 1],
            coefficient: 1e-9
        ),
        DefinedUnit (
            name: "micrometer",
            symbol: "μm",
            dimension: [.Length: 1],
            coefficient: 1e-6
        ),
        DefinedUnit (
            name: "millimeter",
            symbol: "mm",
            dimension: [.Length: 1],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "centimeter",
            symbol: "cm",
            dimension: [.Length: 1],
            coefficient: 0.01
        ),
        DefinedUnit (
            name: "decameter",
            symbol: "dm",
            dimension: [.Length: 1],
            coefficient: 10
        ),
        DefinedUnit (
            name: "hectometer",
            symbol: "hm",
            dimension: [.Length: 1],
            coefficient: 100
        ),
        DefinedUnit (
            name: "kilometer",
            symbol: "km",
            dimension: [.Length: 1],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "megameter",
            symbol: "Mm",
            dimension: [.Length: 1],
            coefficient: 1e6
        ),
        DefinedUnit (
            name: "inch",
            symbol: "in",
            dimension: [.Length: 1],
            coefficient: 0.0254
        ),
        DefinedUnit (
            name: "foot",
            symbol: "ft",
            dimension: [.Length: 1],
            coefficient: 0.3048
        ),
        DefinedUnit (
            name: "yard",
            symbol: "yd",
            dimension: [.Length: 1],
            coefficient: 0.9144
        ),
        DefinedUnit (
            name: "mile",
            symbol: "mi",
            dimension: [.Length: 1],
            coefficient: 1609.344
        ),
        DefinedUnit (
            name: "scandanavianMile",
            symbol: "smi",
            dimension: [.Length: 1],
            coefficient: 10000
        ),
        DefinedUnit (
            name: "nauticalMile",
            symbol: "NM",
            dimension: [.Length: 1],
            coefficient: 1852
        ),
        DefinedUnit (
            name: "fathom",
            symbol: "fathom",
            dimension: [.Length: 1],
            coefficient: 1.8288
        ),
        DefinedUnit (
            name: "furlong",
            symbol: "furlong",
            dimension: [.Length: 1],
            coefficient: 201.168
        ),
        DefinedUnit (
            name: "astronomicalDefinedUnit",
            symbol: "au",
            dimension: [.Length: 1],
            coefficient: 1.495978707e11
        ),
        DefinedUnit (
            name: "lightyear",
            symbol: "ly",
            dimension: [.Length: 1],
            coefficient: 9.4607304725808e15
        ),
        DefinedUnit (
            name: "parsec",
            symbol: "pc",
            dimension: [.Length: 1],
            coefficient: 3.0856775814913673e16
        ),
        
        // MARK: Luminous Intensity
        DefinedUnit (
            name: "candela",
            symbol: "cd",
            dimension: [.LuminousIntensity: 1]
        ),
        
        // MARK: Magnetic Flux
        DefinedUnit (
            name: "weber",
            symbol: "Wb",
            dimension: [.Mass: 1, .Length: 2, .Time: -2, .Current: -1]
        ),
        
        // MARK: Magnetic Flux Density
        DefinedUnit (
            name: "tesla",
            symbol: "T",
            dimension: [.Mass: 1, .Time: -2, .Current: -1]
        ),
        
        // MARK: Mass
        DefinedUnit (
            name: "kilogram",
            symbol: "kg",
            dimension: [.Mass: 1]
        ),
        DefinedUnit (
            name: "picogram",
            symbol: "pg",
            dimension: [.Mass: 1],
            coefficient: 1e-15
        ),
        DefinedUnit (
            name: "nanogram",
            symbol: "ng",
            dimension: [.Mass: 1],
            coefficient: 1e-12
        ),
        DefinedUnit (
            name: "microgram",
            symbol: "μg",
            dimension: [.Mass: 1],
            coefficient: 1e-9
        ),
        DefinedUnit (
            name: "milligram",
            symbol: "mg",
            dimension: [.Mass: 1],
            coefficient: 1e-6
        ),
        DefinedUnit (
            name: "centigram",
            symbol: "cg",
            dimension: [.Mass: 1],
            coefficient: 0.00001
        ),
        DefinedUnit (
            name: "decigram",
            symbol: "dg",
            dimension: [.Mass: 1],
            coefficient: 0.0001
        ),
        DefinedUnit (
            name: "gram",
            symbol: "g",
            dimension: [.Mass: 1],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "metricTon",
            symbol: "t",
            dimension: [.Mass: 1],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "carat",
            symbol: "ct",
            dimension: [.Mass: 1],
            coefficient: 0.0002
        ),
        DefinedUnit (
            name: "ounce",
            symbol: "oz",
            dimension: [.Mass: 1],
            coefficient: 0.028349523125
        ),
        DefinedUnit (
            name: "pound",
            symbol: "lb",
            dimension: [.Mass: 1],
            coefficient: 0.45359237
        ),
        DefinedUnit (
            name: "stone",
            symbol: "st",
            dimension: [.Mass: 1],
            coefficient: 6.35029318
        ),
        DefinedUnit (
            name: "shortTon",
            symbol: "ton",
            dimension: [.Mass: 1],
            coefficient: 907.18474
        ),
        DefinedUnit (
            name: "troyOunces",
            symbol: "troyOunces",
            dimension: [.Mass: 1],
            coefficient: 0.0311034768
        ),
        DefinedUnit (
            name: "slug",
            symbol: "slug",
            dimension: [.Mass: 1],
            coefficient: 14.5939
        ),
        
        // MARK: Power
        DefinedUnit (
            name: "watt",
            symbol: "W",
            dimension: [.Mass: 1, .Length: 2, .Time: -3]
        ),
        DefinedUnit (
            name: "femptowatt",
            symbol: "fW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e-15
        ),
        DefinedUnit (
            name: "picowatt",
            symbol: "pW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e-12
        ),
        DefinedUnit (
            name: "nanowatt",
            symbol: "nW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e-9
        ),
        DefinedUnit (
            name: "microwatt",
            symbol: "μW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e-6
        ),
        DefinedUnit (
            name: "milliwatt",
            symbol: "mW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "kilowatt",
            symbol: "kW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "megawatt",
            symbol: "MW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e6
        ),
        DefinedUnit (
            name: "gigawatt",
            symbol: "GW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e9
        ),
        DefinedUnit (
            name: "terawatt",
            symbol: "TW",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 1e12
        ),
        DefinedUnit (
            name: "horsepower",
            symbol: "hp",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 745.6998715822702
        ),
        DefinedUnit (
            name: "tonRefrigeration",
            symbol: "TR",
            dimension: [.Mass: 1, .Length: 2, .Time: -3],
            coefficient: 3500
        ),
        
        // MARK: Pressure
        DefinedUnit (
            name: "pascal",
            symbol: "Pa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2]
        ),
        DefinedUnit (
            name: "hectopascal",
            symbol: "hPa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 100
        ),
        DefinedUnit (
            name: "kilopascal",
            symbol: "kPa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "megapascal",
            symbol: "MPa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 1e6
        ),
        DefinedUnit (
            name: "gigapascal",
            symbol: "GPa",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 1e9
        ),
        DefinedUnit (
            name: "bar",
            symbol: "bar",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 100000
        ),
        DefinedUnit (
            name: "millibar",
            symbol: "mbar",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 100
        ),
        DefinedUnit (
            name: "atmosphere",
            symbol: "atm",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 101317.1
        ),
        DefinedUnit (
            name: "millimeterOfMercury",
            symbol: "mmhg",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 133.322387415
        ),
        DefinedUnit (
            name: "centimeterOfMercury",
            symbol: "cmhg",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 1333.22387415
        ),
        DefinedUnit (
            name: "inchOfMercury",
            symbol: "inhg",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 3386.389
        ),
        DefinedUnit (
            name: "centimeterOfWater",
            symbol: "cmH₂0",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 98.0665
        ),
        DefinedUnit (
            name: "inchOfWater",
            symbol: "inH₂0",
            dimension: [.Mass: 1, .Length: -1, .Time: -2],
            coefficient: 249.082
        ),
        
        // MARK: Resistance
        DefinedUnit (
            name: "ohm",
            symbol: "Ω",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2]
        ),
        DefinedUnit (
            name: "microohm",
            symbol: "μΩ",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
            coefficient: 1e-6
        ),
        DefinedUnit (
            name: "milliohm",
            symbol: "mΩ",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "kiloohm",
            symbol: "kΩ",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "megaohm",
            symbol: "MΩ",
            dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
            coefficient: 1e6
        ),
        
        // MARK: Solid Angle
        DefinedUnit (
            name: "steradian",
            symbol: "sr",
            dimension: [.Angle: 2]
        ),
        
        // MARK: Temperature
        DefinedUnit (
            name: "kelvin",
            symbol: "K",
            dimension: [.Temperature: 1]
        ),
        DefinedUnit (
            name: "celsius",
            symbol: "°C",
            dimension: [.Temperature: 1],
            constant: 273.15
        ),
        DefinedUnit (
            name: "fahrenheit",
            symbol: "°F",
            dimension: [.Temperature: 1],
            coefficient: 5.0/9.0,
            constant: 273.15 - (32 * 5.0/9.0)
        ),
        DefinedUnit (
            name: "rankine",
            symbol: "°R",
            dimension: [.Temperature: 1],
            coefficient: 5.0/9.0
        ),
        
        // MARK: Time
        DefinedUnit (
            name: "second",
            symbol: "s",
            dimension: [.Time: 1]
        ),
        DefinedUnit (
            name: "nanosecond",
            symbol: "ns",
            dimension: [.Time: 1],
            coefficient: 1E-9
        ),
        DefinedUnit (
            name: "microsecond",
            symbol: "μs",
            dimension: [.Time: 1],
            coefficient: 1E-6
        ),
        DefinedUnit (
            name: "millisecond",
            symbol: "ms",
            dimension: [.Time: 1],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "minute",
            symbol: "min",
            dimension: [.Time: 1],
            coefficient: 60
        ),
        DefinedUnit (
            name: "hour",
            symbol: "hr",
            dimension: [.Time: 1],
            coefficient: 3600
        ),
        
        // MARK: Velocity
        // Base unit is m/s
        DefinedUnit (
            name: "knots",
            symbol: "knot",
            dimension: [.Length: 1, .Time: -1],
            coefficient: 0.514444
        ),
        
        // MARK: Volume
        // Base unit is meter^3
        DefinedUnit (
            name: "liter",
            symbol: "L",
            dimension: [.Length: 3],
            coefficient: 0.001
        ),
        DefinedUnit (
            name: "milliliter",
            symbol: "mL",
            dimension: [.Length: 3],
            coefficient: 1e-6
        ),
        DefinedUnit (
            name: "centiliter",
            symbol: "cL",
            dimension: [.Length: 3],
            coefficient: 1e-5
        ),
        DefinedUnit (
            name: "deciliter",
            symbol: "dL",
            dimension: [.Length: 3],
            coefficient: 1e-4
        ),
        DefinedUnit (
            name: "kiloliter",
            symbol: "kL",
            dimension: [.Length: 3],
            coefficient: 1
        ),
        DefinedUnit (
            name: "megaliter",
            symbol: "ML",
            dimension: [.Length: 3],
            coefficient: 1000
        ),
        DefinedUnit (
            name: "bushel",
            symbol: "bushel",
            dimension: [.Length: 3],
            coefficient: 0.03523907
        ),
        DefinedUnit (
            name: "teaspoon",
            symbol: "tsp",
            dimension: [.Length: 3],
            coefficient: 4.92892159375e-6
        ),
        DefinedUnit (
            name: "tablespoon",
            symbol: "tbsp",
            dimension: [.Length: 3],
            coefficient: 14.7867647812e-6
        ),
        DefinedUnit (
            name: "fluidOunce",
            symbol: "fl_oz",
            dimension: [.Length: 3],
            coefficient: 29.5735295625e-6
        ),
        DefinedUnit (
            name: "cup",
            symbol: "cup",
            dimension: [.Length: 3],
            coefficient: 236.5882365e-6
        ),
        DefinedUnit (
            name: "pint",
            symbol: "pt",
            dimension: [.Length: 3],
            coefficient: 473.176473e-6
        ),
        DefinedUnit (
            name: "gallon",
            symbol: "gal",
            dimension: [.Length: 3],
            coefficient: 0.003785411784
        ),
        DefinedUnit (
            name: "imperialFluidOunce",
            symbol: "ifl_oz",
            dimension: [.Length: 3],
            coefficient: 28.4130625e-6
        ),
        DefinedUnit (
            name: "imperialCup",
            symbol: "icup",
            dimension: [.Length: 3],
            coefficient: 197.15686375-6
        ),
        DefinedUnit (
            name: "imperialPint",
            symbol: "ipt",
            dimension: [.Length: 3],
            coefficient: 568.26125e-6
        ),
        DefinedUnit (
            name: "imperialGallon",
            symbol: "igal",
            dimension: [.Length: 3],
            coefficient: 0.00454609
        ),
        DefinedUnit (
            name: "metricCup",
            symbol: "mcup",
            dimension: [.Length: 3],
            coefficient: 0.00025
        )
    ]
}
