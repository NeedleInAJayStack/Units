// TODO: Make more
// - Concentration Mass
// - Dispersion
// - Information Storage: https://developer.apple.com/documentation/foundation/unitinformationstorage

extension Unit {
    // MARK: Acceleration
    // Base unit is m/s^2
    public static var gravitationalAcceleration = Unit (
        symbol: "g",
        dimension: [.Length: 1, .Time: -2],
        coefficient: 9.80665
    )
    
    // MARK: Amount
    public static var mole = Unit (
        symbol: "mol",
        dimension: [.Amount: 1]
    )
    public static var millimole = Unit (
        symbol: "mmol",
        dimension: [.Amount: 1],
        coefficient: 0.001
    )
    public static var particle = Unit (
        symbol: "particle",
        dimension: [.Amount: 1],
        coefficient: 6.02214076E23
    )
    
    // MARK: Angle
    public static var radian = Unit (
        symbol: "rad",
        dimension: [.Angle: 1]
    )
    public static var degree = Unit (
        symbol: "°",
        dimension: [.Angle: 1],
        coefficient: 180 / Double.pi
    )
    
    // MARK: Area
    // Base unit is m^2
    public static var acre = Unit (
        symbol: "ac",
        dimension: [.Length: 2],
        coefficient: 4046.8564224
    )
    public static var are = Unit (
        symbol: "a",
        dimension: [.Length: 2],
        coefficient: 100
    )
    public static var hectare = Unit (
        symbol: "ha",
        dimension: [.Length: 2],
        coefficient: 10000
    )
    
    // MARK: Capacitance
    public static var farad = Unit (
        symbol: "F",
        dimension: [.Current: 2, .Time: 4, .Length: -2, .Mass: -1]
    )
    
    // MARK: Charge
    public static var coulomb = Unit (
        symbol: "C",
        dimension: [.Current: 1, .Time: 1]
    )
    
    // MARK: Current
    public static var ampere = Unit (
        symbol: "A",
        dimension: [.Current: 1]
    )
    public static var microampere = Unit (
        symbol: "μA",
        dimension: [.Current: 1],
        coefficient: 1e-6
    )
    public static var milliampere = Unit (
        symbol: "mA",
        dimension: [.Current: 1],
        coefficient: 0.001
    )
    public static var kiloampere = Unit (
        symbol: "kA",
        dimension: [.Current: 1],
        coefficient: 1000
    )
    public static var megaampere = Unit (
        symbol: "MA",
        dimension: [.Current: 1],
        coefficient: 1e6
    )
    
    // MARK: Data
    public static var bit = Unit (
        symbol: "bit",
        dimension: [.Data: 1]
    )
    public static var byte = Unit (
        symbol: "byte",
        dimension: [.Data: 1],
        coefficient: 8
    )
    public static var kilobyte = Unit (
        symbol: "kB",
        dimension: [.Data: 1],
        coefficient: 8000
    )
    public static var megabyte = Unit (
        symbol: "MB",
        dimension: [.Data: 1],
        coefficient: 8e6
    )
    public static var gigabyte = Unit (
        symbol: "GB",
        dimension: [.Data: 1],
        coefficient: 8e9
    )
    public static var petabyte = Unit (
        symbol: "PB",
        dimension: [.Data: 1],
        coefficient: 8e12
    )
    
    // MARK: Electric Potential Difference
    public static var volt = Unit (
        symbol: "V",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1]
    )
    public static var microvolt = Unit (
        symbol: "μV",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
        coefficient: 1e-6
    )
    public static var millivolt = Unit (
        symbol: "mV",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
        coefficient: 0.001
    )
    public static var kilovolt = Unit (
        symbol: "kV",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
        coefficient: 1000
    )
    public static var megavolt = Unit (
        symbol: "MV",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
        coefficient: 1e6
    )
    
    // MARK: Energy
    public static var joule = Unit (
        symbol: "J",
        dimension: [.Mass: 1, .Length: 2, .Time: -2]
    )
    public static var kilojoule = Unit (
        symbol: "kJ",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1000
    )
    public static var calorie = Unit (
        symbol: "cal",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 4.184
    )
    public static var kilocalorie = Unit (
        symbol: "kCal",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 4184
    )
    public static var btu = Unit (
        symbol: "BTU",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1054.35
    )
    public static var kilobtu = Unit (
        symbol: "kBTU",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1.05435E6
    )
    public static var megabtu = Unit (
        symbol: "MBTU",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1.05435E9
    )
    public static var therm = Unit (
        symbol: "therm",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1.05435E8
    )
    public static var electronVolt = Unit (
        symbol: "eV",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1.602176634e-19
    )
    
    // MARK: Force
    public static var newton = Unit (
        symbol: "N",
        dimension: [.Mass: 1, .Length: 1, .Time: -2]
    )
    public static var poundForce = Unit (
        symbol: "lbf",
        dimension: [.Mass: 1, .Length: 1, .Time: -2],
        coefficient: 4.448222
    )
    
    // MARK: Frequency
    public static var hertz = Unit (
        symbol: "Hz",
        dimension: [.Time: -1]
    )
    public static var nanohertz = Unit (
        symbol: "nHz",
        dimension: [.Time: -1],
        coefficient: 1e-9
    )
    public static var microhertz = Unit (
        symbol: "μHz",
        dimension: [.Time: -1],
        coefficient: 1e-6
    )
    public static var millihertz = Unit (
        symbol: "mHz",
        dimension: [.Time: -1],
        coefficient: 0.001
    )
    public static var kilohertz = Unit (
        symbol: "mHz",
        dimension: [.Time: -1],
        coefficient: 1000
    )
    public static var megahertz = Unit (
        symbol: "MHz",
        dimension: [.Time: -1],
        coefficient: 1e6
    )
    public static var gigahertz = Unit (
        symbol: "GHz",
        dimension: [.Time: -1],
        coefficient: 1e9
    )
    public static var terahertz = Unit (
        symbol: "THz",
        dimension: [.Time: -1],
        coefficient: 1e12
    )
    
    // MARK: Illuminance
    public static var lux = Unit (
        symbol: "lx",
        dimension: [.LuminousIntensity: 1, .Length: -2]
    )
    public static var footCandle = Unit (
        symbol: "fc",
        dimension: [.LuminousIntensity: 1, .Length: -2],
        coefficient: 10.76
    )
    public static var phot = Unit (
        symbol: "phot",
        dimension: [.LuminousIntensity: 1, .Length: -2],
        coefficient: 10000
    )
    
    // MARK: Inductance
    public static var henry = Unit (
        symbol: "H",
        dimension: [.Length: 2, .Mass: 1, .Current: -2]
    )
    
    // MARK: Length
    public static var meter = Unit (
        symbol: "m",
        dimension: [.Length: 1]
    )
    public static var picometer = Unit (
        symbol: "pm",
        dimension: [.Length: 1],
        coefficient: 1e-12
    )
    public static var nanoometer = Unit (
        symbol: "nm",
        dimension: [.Length: 1],
        coefficient: 1e-9
    )
    public static var micrometer = Unit (
        symbol: "μm",
        dimension: [.Length: 1],
        coefficient: 1e-6
    )
    public static var millimeter = Unit (
        symbol: "mm",
        dimension: [.Length: 1],
        coefficient: 0.001
    )
    public static var centimeter = Unit (
        symbol: "cm",
        dimension: [.Length: 1],
        coefficient: 0.01
    )
    public static var decameter = Unit (
        symbol: "dm",
        dimension: [.Length: 1],
        coefficient: 10
    )
    public static var hectometer = Unit (
        symbol: "hm",
        dimension: [.Length: 1],
        coefficient: 100
    )
    public static var kilometer = Unit (
        symbol: "km",
        dimension: [.Length: 1],
        coefficient: 1000
    )
    public static var megameter = Unit (
        symbol: "Mm",
        dimension: [.Length: 1],
        coefficient: 1e6
    )
    public static var inch = Unit (
        symbol: "in",
        dimension: [.Length: 1],
        coefficient: 0.0254
    )
    public static var foot = Unit (
        symbol: "ft",
        dimension: [.Length: 1],
        coefficient: 0.3048
    )
    public static var yard = Unit (
        symbol: "yd",
        dimension: [.Length: 1],
        coefficient: 0.9144
    )
    public static var mile = Unit (
        symbol: "mi",
        dimension: [.Length: 1],
        coefficient: 1609.344
    )
    public static var scandanavianMile = Unit (
        symbol: "smi",
        dimension: [.Length: 1],
        coefficient: 10000
    )
    public static var nauticalMile = Unit (
        symbol: "NM",
        dimension: [.Length: 1],
        coefficient: 1852
    )
    public static var fathom = Unit (
        symbol: "fathom",
        dimension: [.Length: 1],
        coefficient: 1.8288
    )
    public static var furlong = Unit (
        symbol: "furlong",
        dimension: [.Length: 1],
        coefficient: 201.168
    )
    public static var astronomicalUnit = Unit (
        symbol: "au",
        dimension: [.Length: 1],
        coefficient: 1.495978707e11
    )
    public static var lightyear = Unit (
        symbol: "ly",
        dimension: [.Length: 1],
        coefficient: 9.4607304725808e15
    )
    public static var parsec = Unit (
        symbol: "pc",
        dimension: [.Length: 1],
        coefficient: 3.0856775814913673e16
    )
    
    // MARK: Luminous Intensity
    public static var candela = Unit (
        symbol: "cd",
        dimension: [.LuminousIntensity: 1]
    )
    
    // MARK: Magnetic Flux
    public static var weber = Unit (
        symbol: "Wb",
        dimension: [.Mass: 1, .Length: 2, .Time: -2, .Current: -1]
    )
    
    // MARK: Magnetic Flux Density
    public static var tesla = Unit (
        symbol: "T",
        dimension: [.Mass: 1, .Time: -2, .Current: -1]
    )
    
    // MARK: Mass
    public static var kilogram = Unit (
        symbol: "kg",
        dimension: [.Mass: 1]
    )
    public static var picogram = Unit (
        symbol: "pg",
        dimension: [.Mass: 1],
        coefficient: 1e-15
    )
    public static var nanogram = Unit (
        symbol: "ng",
        dimension: [.Mass: 1],
        coefficient: 1e-12
    )
    public static var microgram = Unit (
        symbol: "μg",
        dimension: [.Mass: 1],
        coefficient: 1e-9
    )
    public static var milligram = Unit (
        symbol: "mg",
        dimension: [.Mass: 1],
        coefficient: 1e-6
    )
    public static var centigram = Unit (
        symbol: "cg",
        dimension: [.Mass: 1],
        coefficient: 0.00001
    )
    public static var decigram = Unit (
        symbol: "cg",
        dimension: [.Mass: 1],
        coefficient: 0.0001
    )
    public static var gram = Unit (
        symbol: "g",
        dimension: [.Mass: 1],
        coefficient: 0.001
    )
    public static var metricTon = Unit (
        symbol: "t",
        dimension: [.Mass: 1],
        coefficient: 1000
    )
    public static var carat = Unit (
        symbol: "ct",
        dimension: [.Mass: 1],
        coefficient: 0.0002
    )
    public static var ounce = Unit (
        symbol: "oz",
        dimension: [.Mass: 1],
        coefficient: 0.028349523125
    )
    public static var pound = Unit (
        symbol: "lb",
        dimension: [.Mass: 1],
        coefficient: 0.45359237
    )
    public static var stone = Unit (
        symbol: "st",
        dimension: [.Mass: 1],
        coefficient: 6.35029318
    )
    public static var shortTon = Unit (
        symbol: "ton",
        dimension: [.Mass: 1],
        coefficient: 907.18474
    )
    public static var troyOunces = Unit (
        symbol: "troyOunces",
        dimension: [.Mass: 1],
        coefficient: 0.0311034768
    )
    public static var slug = Unit (
        symbol: "slug",
        dimension: [.Mass: 1],
        coefficient: 14.5939
    )
    
    // MARK: Power
    public static var watt = Unit (
        symbol: "W",
        dimension: [.Mass: 1, .Length: 2, .Time: -3]
    )
    public static var femptowatt = Unit (
        symbol: "fW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e-15
    )
    public static var picowatt = Unit (
        symbol: "pW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e-12
    )
    public static var nanowatt = Unit (
        symbol: "pW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e-9
    )
    public static var microwatt = Unit (
        symbol: "μW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e-6
    )
    public static var milliwatt = Unit (
        symbol: "mW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 0.001
    )
    public static var kilowatt = Unit (
        symbol: "kW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1000
    )
    public static var megawatt = Unit (
        symbol: "MW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e6
    )
    public static var gigawatt = Unit (
        symbol: "MW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e9
    )
    public static var terawatt = Unit (
        symbol: "TW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e12
    )
    public static var horsepower = Unit (
        symbol: "hp",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 745.6998715822702
    )
    public static var tonRefrigeration = Unit (
        symbol: "TR",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 3500
    )
    
    // MARK: Pressure
    public static var pascal = Unit (
        symbol: "Pa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2]
    )
    public static var hectopascal = Unit (
        symbol: "hPa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 100
    )
    public static var kilopascal = Unit (
        symbol: "kPa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 1000
    )
    public static var megapascal = Unit (
        symbol: "MPa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 1e6
    )
    public static var gigapascal = Unit (
        symbol: "GPa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 1e9
    )
    public static var bar = Unit (
        symbol: "bar",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 100000
    )
    public static var millibar = Unit (
        symbol: "mbar",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 100
    )
    public static var atmosphere = Unit (
        symbol: "atm",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 101317.1
    )
    public static var millimeterOfMercury = Unit (
        symbol: "mmhg",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 133.322387415
    )
    public static var centimeterOfMercury = Unit (
        symbol: "mmhg",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 1333.22387415
    )
    public static var inchOfMercury = Unit (
        symbol: "inhg",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 3386.389
    )
    public static var centimeterOfWater = Unit (
        symbol: "mmH₂0",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 98.0665
    )
    public static var inchOfWater = Unit (
        symbol: "inH₂0",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 249.082
    )
    
    // MARK: Resistance
    public static var ohm = Unit (
        symbol: "Ω",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2]
    )
    public static var microohm = Unit (
        symbol: "μΩ",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
        coefficient: 1e-6
    )
    public static var milliohm = Unit (
        symbol: "mΩ",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
        coefficient: 0.001
    )
    public static var kiloohm = Unit (
        symbol: "kΩ",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
        coefficient: 1000
    )
    public static var megaohm = Unit (
        symbol: "MΩ",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
        coefficient: 1e6
    )
    
    // MARK: Solid Angle
    public static var steradian = Unit (
        symbol: "sr",
        dimension: [.Angle: 2]
    )
    
    // MARK: Temperature
    public static var kelvin = Unit (
        symbol: "K",
        dimension: [.Temperature: 1]
    )
    public static var celsius = Unit (
        symbol: "°C",
        dimension: [.Temperature: 1],
        constant: 273.15
    )
    public static var fahrenheit = Unit (
        symbol: "°F",
        dimension: [.Temperature: 1],
        coefficient: 5.0/9.0,
        constant: 273.15 - (32 * 5.0/9.0)
    )
    public static var rankine = Unit (
        symbol: "°R",
        dimension: [.Temperature: 1],
        coefficient: 5.0/9.0
    )
    
    // MARK: Time
    public static var second = Unit (
        symbol: "s",
        dimension: [.Time: 1]
    )
    public static var nanosecond = Unit (
        symbol: "ns",
        dimension: [.Time: 1],
        coefficient: 1E-9
    )
    public static var microsecond = Unit (
        symbol: "μs",
        dimension: [.Time: 1],
        coefficient: 1E-6
    )
    public static var millisecond = Unit (
        symbol: "ms",
        dimension: [.Time: 1],
        coefficient: 0.001
    )
    public static var minute = Unit (
        symbol: "min",
        dimension: [.Time: 1],
        coefficient: 60
    )
    public static var hour = Unit (
        symbol: "hr",
        dimension: [.Time: 1],
        coefficient: 3600
    )
    
    // MARK: Velocity
    // Base unit is m/s
    public static var knots = Unit (
        symbol: "knot",
        dimension: [.Length: 1, .Time: -1],
        coefficient: 0.514444
    )
    
    // MARK: Volume
    // Base unit is meter^3
    public static var liter = Unit (
        symbol: "L",
        dimension: [.Length: 3],
        coefficient: 0.001
    )
    public static var milliliter = Unit (
        symbol: "mL",
        dimension: [.Length: 3],
        coefficient: 1e-6
    )
    public static var centiliter = Unit (
        symbol: "cL",
        dimension: [.Length: 3],
        coefficient: 1e-5
    )
    public static var deciliter = Unit (
        symbol: "dL",
        dimension: [.Length: 3],
        coefficient: 1e-4
    )
    public static var kiloliter = Unit (
        symbol: "kL",
        dimension: [.Length: 3],
        coefficient: 1
    )
    public static var megaliter = Unit (
        symbol: "ML",
        dimension: [.Length: 3],
        coefficient: 1000
    )
    public static var bushel = Unit (
        symbol: "bushel",
        dimension: [.Length: 3],
        coefficient: 0.03523907
    )
    public static var teaspoon = Unit (
        symbol: "tsp",
        dimension: [.Length: 3],
        coefficient: 4.92892159375e-6
    )
    public static var tablespoon = Unit (
        symbol: "tbsp",
        dimension: [.Length: 3],
        coefficient: 14.7867647812e-6
    )
    public static var fluidOunce = Unit (
        symbol: "fl_oz",
        dimension: [.Length: 3],
        coefficient: 29.5735295625e-6
    )
    public static var cup = Unit (
        symbol: "cup",
        dimension: [.Length: 3],
        coefficient: 236.5882365e-6
    )
    public static var pint = Unit (
        symbol: "pt",
        dimension: [.Length: 3],
        coefficient: 473.176473e-6
    )
    public static var gallon = Unit (
        symbol: "gal",
        dimension: [.Length: 3],
        coefficient: 0.003785411784
    )
    
    public static var imperialFluidOunce = Unit (
        symbol: "ifl_oz",
        dimension: [.Length: 3],
        coefficient: 28.4130625e-6
    )
    public static var imperialCup = Unit (
        symbol: "icup",
        dimension: [.Length: 3],
        coefficient: 197.15686375-6
    )
    public static var imperialPint = Unit (
        symbol: "ipt",
        dimension: [.Length: 3],
        coefficient: 568.26125e-6
    )
    public static var imperialGallon = Unit (
        symbol: "igal",
        dimension: [.Length: 3],
        coefficient: 0.00454609
    )
    public static var metricCup = Unit (
        symbol: "mcup",
        dimension: [.Length: 3],
        coefficient: 0.00025
    )
}
