/// Static type containing this package's pre-defined units
enum DefaultUnits {
    // MARK: If adding units to this list, add corresponding entries in the `Unit+DefaultUnits.swift` & `Registry.swift` files

    // MARK: Acceleration

    // Base unit: meter / second^2

    static let standardGravity = try! DefinedUnit(
        name: "standardGravity",
        symbol: "ɡ",
        dimension: [.Length: 1, .Time: -2],
        coefficient: 9.80665
    )

    // MARK: Amount

    // Base unit: mole

    static let mole = try! DefinedUnit(
        name: "mole",
        symbol: "mol",
        dimension: [.Amount: 1]
    )
    static let millimole = try! DefinedUnit(
        name: "millimole",
        symbol: "mmol",
        dimension: [.Amount: 1],
        coefficient: 0.001
    )
    static let particle = try! DefinedUnit(
        name: "particle",
        symbol: "particle",
        dimension: [.Amount: 1],
        coefficient: 6.02214076e-23
    )

    // MARK: Angle

    // Base unit: radian

    static let radian = try! DefinedUnit(
        name: "radian",
        symbol: "rad",
        dimension: [.Angle: 1]
    )
    static let degree = try! DefinedUnit(
        name: "degree",
        symbol: "°",
        dimension: [.Angle: 1],
        coefficient: 180 / Double.pi
    )
    static let revolution = try! DefinedUnit(
        name: "revolution",
        symbol: "rev",
        dimension: [.Angle: 1],
        coefficient: 2 * Double.pi
    )

    // MARK: Area

    // Base unit: meter^2

    static let acre = try! DefinedUnit(
        name: "acre",
        symbol: "ac",
        dimension: [.Length: 2],
        coefficient: 4046.8564224
    )
    static let are = try! DefinedUnit(
        name: "are",
        symbol: "a",
        dimension: [.Length: 2],
        coefficient: 100
    )
    static let hectare = try! DefinedUnit(
        name: "hectare",
        symbol: "ha",
        dimension: [.Length: 2],
        coefficient: 10000
    )

    // MARK: Capacitance

    // Base unit: farad

    static let farad = try! DefinedUnit(
        name: "farad",
        symbol: "F",
        dimension: [.Current: 2, .Time: 4, .Length: -2, .Mass: -1]
    )

    // MARK: Charge

    // Base unit: coloumb

    static let coulomb = try! DefinedUnit(
        name: "coulomb",
        symbol: "C",
        dimension: [.Current: 1, .Time: 1]
    )

    // MARK: Current

    // Base unit: ampere

    static let ampere = try! DefinedUnit(
        name: "ampere",
        symbol: "A",
        dimension: [.Current: 1]
    )
    static let microampere = try! DefinedUnit(
        name: "microampere",
        symbol: "μA",
        dimension: [.Current: 1],
        coefficient: 1e-6
    )
    static let milliampere = try! DefinedUnit(
        name: "milliampere",
        symbol: "mA",
        dimension: [.Current: 1],
        coefficient: 0.001
    )
    static let kiloampere = try! DefinedUnit(
        name: "kiloampere",
        symbol: "kA",
        dimension: [.Current: 1],
        coefficient: 1000
    )
    static let megaampere = try! DefinedUnit(
        name: "megaampere",
        symbol: "MA",
        dimension: [.Current: 1],
        coefficient: 1e6
    )

    // MARK: Data

    // Base unit: bit

    static let bit = try! DefinedUnit(
        name: "bit",
        symbol: "bit",
        dimension: [.Data: 1]
    )
    static let kilobit = try! DefinedUnit(
        name: "kilobit",
        symbol: "kbit",
        dimension: [.Data: 1],
        coefficient: 1000
    )
    static let megabit = try! DefinedUnit(
        name: "megabit",
        symbol: "Mbit",
        dimension: [.Data: 1],
        coefficient: 1e6
    )
    static let gigabit = try! DefinedUnit(
        name: "gigabit",
        symbol: "Gbit",
        dimension: [.Data: 1],
        coefficient: 1e9
    )
    static let terabit = try! DefinedUnit(
        name: "terabit",
        symbol: "Tbit",
        dimension: [.Data: 1],
        coefficient: 1e12
    )
    static let petabit = try! DefinedUnit(
        name: "petabit",
        symbol: "Pbit",
        dimension: [.Data: 1],
        coefficient: 1e15
    )
    static let exabit = try! DefinedUnit(
        name: "exabit",
        symbol: "Ebit",
        dimension: [.Data: 1],
        coefficient: 1e18
    )
    static let zetabit = try! DefinedUnit(
        name: "zetabit",
        symbol: "Zbit",
        dimension: [.Data: 1],
        coefficient: 1e21
    )
    static let yottabit = try! DefinedUnit(
        name: "yottabit",
        symbol: "Ybit",
        dimension: [.Data: 1],
        coefficient: 1e24
    )
    static let byte = try! DefinedUnit(
        name: "byte",
        symbol: "byte",
        dimension: [.Data: 1],
        coefficient: 8
    )
    static let kilobyte = try! DefinedUnit(
        name: "kilobyte",
        symbol: "kB",
        dimension: [.Data: 1],
        coefficient: 8000
    )
    static let megabyte = try! DefinedUnit(
        name: "megabyte",
        symbol: "MB",
        dimension: [.Data: 1],
        coefficient: 8e6
    )
    static let gigabyte = try! DefinedUnit(
        name: "gigabyte",
        symbol: "GB",
        dimension: [.Data: 1],
        coefficient: 8e9
    )
    static let terabyte = try! DefinedUnit(
        name: "terabyte",
        symbol: "TB",
        dimension: [.Data: 1],
        coefficient: 8e12
    )
    static let petabyte = try! DefinedUnit(
        name: "petabyte",
        symbol: "PB",
        dimension: [.Data: 1],
        coefficient: 8e15
    )
    static let exabyte = try! DefinedUnit(
        name: "exabyte",
        symbol: "EB",
        dimension: [.Data: 1],
        coefficient: 8e18
    )
    static let zetabyte = try! DefinedUnit(
        name: "zetabyte",
        symbol: "ZB",
        dimension: [.Data: 1],
        coefficient: 8e21
    )
    static let yottabyte = try! DefinedUnit(
        name: "yottabyte",
        symbol: "YB",
        dimension: [.Data: 1],
        coefficient: 8e24
    )
    static let kibibyte = try! DefinedUnit(
        name: "kibibyte",
        symbol: "KiB",
        dimension: [.Data: 1],
        coefficient: 8 * 1024
    )
    static let mebibyte = try! DefinedUnit(
        name: "mebibyte",
        symbol: "MiB",
        dimension: [.Data: 1],
        coefficient: 8 * pow(1024, 2)
    )
    static let gibibyte = try! DefinedUnit(
        name: "gibibyte",
        symbol: "GiB",
        dimension: [.Data: 1],
        coefficient: 8 * pow(1024, 3)
    )
    static let tebibyte = try! DefinedUnit(
        name: "tebibyte",
        symbol: "TiB",
        dimension: [.Data: 1],
        coefficient: 8 * pow(1024, 4)
    )
    static let pebibyte = try! DefinedUnit(
        name: "pebibyte",
        symbol: "PiB",
        dimension: [.Data: 1],
        coefficient: 8 * pow(1024, 5)
    )
    static let exbibyte = try! DefinedUnit(
        name: "exbibyte",
        symbol: "EiB",
        dimension: [.Data: 1],
        coefficient: 8 * pow(1024, 6)
    )
    static let zebibyte = try! DefinedUnit(
        name: "zebibyte",
        symbol: "ZiB",
        dimension: [.Data: 1],
        coefficient: 8 * pow(1024, 7)
    )
    static let yobibyte = try! DefinedUnit(
        name: "yobibyte",
        symbol: "YiB",
        dimension: [.Data: 1],
        coefficient: 8 * pow(1024, 8)
    )

    // MARK: Electric Potential Difference

    // Base unit: volt

    static let volt = try! DefinedUnit(
        name: "volt",
        symbol: "V",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1]
    )
    static let microvolt = try! DefinedUnit(
        name: "microvolt",
        symbol: "μV",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
        coefficient: 1e-6
    )
    static let millivolt = try! DefinedUnit(
        name: "millivolt",
        symbol: "mV",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
        coefficient: 0.001
    )
    static let kilovolt = try! DefinedUnit(
        name: "kilovolt",
        symbol: "kV",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
        coefficient: 1000
    )
    static let megavolt = try! DefinedUnit(
        name: "megavolt",
        symbol: "MV",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -1],
        coefficient: 1e6
    )

    // MARK: Energy

    // Base unit: joule

    static let joule = try! DefinedUnit(
        name: "joule",
        symbol: "J",
        dimension: [.Mass: 1, .Length: 2, .Time: -2]
    )
    static let kilojoule = try! DefinedUnit(
        name: "kilojoule",
        symbol: "kJ",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1000
    )
    static let megajoule = try! DefinedUnit(
        name: "megajoule",
        symbol: "MJ",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1_000_000
    )
    static let calorie = try! DefinedUnit(
        name: "calorie",
        symbol: "cal",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 4.184
    )
    static let kilocalorie = try! DefinedUnit(
        name: "kilocalorie",
        symbol: "kCal",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 4184
    )
    // Thermochemical BTU: https://en.wikipedia.org/wiki/British_thermal_unit#Definitions
    static let btu = try! DefinedUnit(
        name: "btu",
        symbol: "BTU",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1054.35
    )
    static let kilobtu = try! DefinedUnit(
        name: "kilobtu",
        symbol: "kBTU",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1.05435e6
    )
    static let megabtu = try! DefinedUnit(
        name: "megabtu",
        symbol: "MBTU",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1.05435e9
    )
    static let therm = try! DefinedUnit(
        name: "therm",
        symbol: "therm",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1.05435e8
    )
    static let electronVolt = try! DefinedUnit(
        name: "electronVolt",
        symbol: "eV",
        dimension: [.Mass: 1, .Length: 2, .Time: -2],
        coefficient: 1.602176634e-19
    )

    // MARK: Force

    // Base unit: newton

    static let newton = try! DefinedUnit(
        name: "newton",
        symbol: "N",
        dimension: [.Mass: 1, .Length: 1, .Time: -2]
    )
    static let poundForce = try! DefinedUnit(
        name: "poundForce",
        symbol: "lbf",
        dimension: [.Mass: 1, .Length: 1, .Time: -2],
        coefficient: 4.448222
    )

    // MARK: Frequency

    // Base unit: hertz

    static let hertz = try! DefinedUnit(
        name: "hertz",
        symbol: "Hz",
        dimension: [.Time: -1]
    )
    static let nanohertz = try! DefinedUnit(
        name: "nanohertz",
        symbol: "nHz",
        dimension: [.Time: -1],
        coefficient: 1e-9
    )
    static let microhertz = try! DefinedUnit(
        name: "microhertz",
        symbol: "μHz",
        dimension: [.Time: -1],
        coefficient: 1e-6
    )
    static let millihertz = try! DefinedUnit(
        name: "millihertz",
        symbol: "mHz",
        dimension: [.Time: -1],
        coefficient: 0.001
    )
    static let kilohertz = try! DefinedUnit(
        name: "kilohertz",
        symbol: "kHz",
        dimension: [.Time: -1],
        coefficient: 1000
    )
    static let megahertz = try! DefinedUnit(
        name: "megahertz",
        symbol: "MHz",
        dimension: [.Time: -1],
        coefficient: 1e6
    )
    static let gigahertz = try! DefinedUnit(
        name: "gigahertz",
        symbol: "GHz",
        dimension: [.Time: -1],
        coefficient: 1e9
    )
    static let terahertz = try! DefinedUnit(
        name: "terahertz",
        symbol: "THz",
        dimension: [.Time: -1],
        coefficient: 1e12
    )

    // MARK: Illuminance

    // Base unit: lux

    static let lux = try! DefinedUnit(
        name: "lux",
        symbol: "lx",
        dimension: [.LuminousIntensity: 1, .Length: -2]
    )
    static let footCandle = try! DefinedUnit(
        name: "footCandle",
        symbol: "fc",
        dimension: [.LuminousIntensity: 1, .Length: -2],
        coefficient: 10.76
    )
    static let phot = try! DefinedUnit(
        name: "phot",
        symbol: "phot",
        dimension: [.LuminousIntensity: 1, .Length: -2],
        coefficient: 10000
    )

    // MARK: Inductance

    // Base unit: henry

    static let henry = try! DefinedUnit(
        name: "henry",
        symbol: "H",
        dimension: [.Length: 2, .Mass: 1, .Current: -2]
    )

    // MARK: Length

    // Base unit: meter

    static let meter = try! DefinedUnit(
        name: "meter",
        symbol: "m",
        dimension: [.Length: 1]
    )
    static let picometer = try! DefinedUnit(
        name: "picometer",
        symbol: "pm",
        dimension: [.Length: 1],
        coefficient: 1e-12
    )
    static let nanoometer = try! DefinedUnit(
        name: "nanoometer",
        symbol: "nm",
        dimension: [.Length: 1],
        coefficient: 1e-9
    )
    static let micrometer = try! DefinedUnit(
        name: "micrometer",
        symbol: "μm",
        dimension: [.Length: 1],
        coefficient: 1e-6
    )
    static let millimeter = try! DefinedUnit(
        name: "millimeter",
        symbol: "mm",
        dimension: [.Length: 1],
        coefficient: 0.001
    )
    static let centimeter = try! DefinedUnit(
        name: "centimeter",
        symbol: "cm",
        dimension: [.Length: 1],
        coefficient: 0.01
    )
    static let decameter = try! DefinedUnit(
        name: "decameter",
        symbol: "dm",
        dimension: [.Length: 1],
        coefficient: 10
    )
    static let hectometer = try! DefinedUnit(
        name: "hectometer",
        symbol: "hm",
        dimension: [.Length: 1],
        coefficient: 100
    )
    static let kilometer = try! DefinedUnit(
        name: "kilometer",
        symbol: "km",
        dimension: [.Length: 1],
        coefficient: 1000
    )
    static let megameter = try! DefinedUnit(
        name: "megameter",
        symbol: "Mm",
        dimension: [.Length: 1],
        coefficient: 1e6
    )
    static let inch = try! DefinedUnit(
        name: "inch",
        symbol: "in",
        dimension: [.Length: 1],
        coefficient: 0.0254
    )
    static let foot = try! DefinedUnit(
        name: "foot",
        symbol: "ft",
        dimension: [.Length: 1],
        coefficient: 0.3048
    )
    // International yard: https://en.wikipedia.org/wiki/Yard
    static let yard = try! DefinedUnit(
        name: "yard",
        symbol: "yd",
        dimension: [.Length: 1],
        coefficient: 0.9144
    )
    static let mile = try! DefinedUnit(
        name: "mile",
        symbol: "mi",
        dimension: [.Length: 1],
        coefficient: 1609.344
    )
    static let scandanavianMile = try! DefinedUnit(
        name: "scandanavianMile",
        symbol: "smi",
        dimension: [.Length: 1],
        coefficient: 10000
    )
    static let nauticalMile = try! DefinedUnit(
        name: "nauticalMile",
        symbol: "NM",
        dimension: [.Length: 1],
        coefficient: 1852
    )
    static let fathom = try! DefinedUnit(
        name: "fathom",
        symbol: "fathom",
        dimension: [.Length: 1],
        coefficient: 1.8288
    )
    static let furlong = try! DefinedUnit(
        name: "furlong",
        symbol: "furlong",
        dimension: [.Length: 1],
        coefficient: 201.168
    )
    static let astronomicalUnit = try! DefinedUnit(
        name: "astronomicalUnit",
        symbol: "au",
        dimension: [.Length: 1],
        coefficient: 1.495978707e11
    )
    static let lightyear = try! DefinedUnit(
        name: "lightyear",
        symbol: "ly",
        dimension: [.Length: 1],
        coefficient: 9.4607304725808e15
    )
    static let parsec = try! DefinedUnit(
        name: "parsec",
        symbol: "pc",
        dimension: [.Length: 1],
        coefficient: 3.0856775814913673e16
    )

    // MARK: Luminous Intensity

    // Base unit: candela

    static let candela = try! DefinedUnit(
        name: "candela",
        symbol: "cd",
        dimension: [.LuminousIntensity: 1]
    )

    // MARK: Luminous Flux

    // Base unit: lumen

    static let lumen = try! DefinedUnit(
        name: "lumen",
        symbol: "lm",
        dimension: [.Angle: 2, .LuminousIntensity: 1]
    )

    // MARK: Magnetic Flux

    // Base unit: weber

    static let weber = try! DefinedUnit(
        name: "weber",
        symbol: "Wb",
        dimension: [.Mass: 1, .Length: 2, .Time: -2, .Current: -1]
    )

    // MARK: Magnetic Flux Density

    // Base unit: tesla

    static let tesla = try! DefinedUnit(
        name: "tesla",
        symbol: "T",
        dimension: [.Mass: 1, .Time: -2, .Current: -1]
    )

    // MARK: Mass

    // Base unit: kilogram

    static let kilogram = try! DefinedUnit(
        name: "kilogram",
        symbol: "kg",
        dimension: [.Mass: 1]
    )
    static let picogram = try! DefinedUnit(
        name: "picogram",
        symbol: "pg",
        dimension: [.Mass: 1],
        coefficient: 1e-15
    )
    static let nanogram = try! DefinedUnit(
        name: "nanogram",
        symbol: "ng",
        dimension: [.Mass: 1],
        coefficient: 1e-12
    )
    static let microgram = try! DefinedUnit(
        name: "microgram",
        symbol: "μg",
        dimension: [.Mass: 1],
        coefficient: 1e-9
    )
    static let milligram = try! DefinedUnit(
        name: "milligram",
        symbol: "mg",
        dimension: [.Mass: 1],
        coefficient: 1e-6
    )
    static let centigram = try! DefinedUnit(
        name: "centigram",
        symbol: "cg",
        dimension: [.Mass: 1],
        coefficient: 0.00001
    )
    static let decigram = try! DefinedUnit(
        name: "decigram",
        symbol: "dg",
        dimension: [.Mass: 1],
        coefficient: 0.0001
    )
    static let gram = try! DefinedUnit(
        name: "gram",
        symbol: "g",
        dimension: [.Mass: 1],
        coefficient: 0.001
    )
    static let metricTon = try! DefinedUnit(
        name: "metricTon",
        symbol: "t",
        dimension: [.Mass: 1],
        coefficient: 1000
    )
    static let carat = try! DefinedUnit(
        name: "carat",
        symbol: "ct",
        dimension: [.Mass: 1],
        coefficient: 0.0002
    )
    static let ounce = try! DefinedUnit(
        name: "ounce",
        symbol: "oz",
        dimension: [.Mass: 1],
        coefficient: 0.028349523125
    )
    // pound-mass: https://en.wikipedia.org/wiki/Pound_(mass)
    static let pound = try! DefinedUnit(
        name: "pound",
        symbol: "lb",
        dimension: [.Mass: 1],
        coefficient: 0.45359237
    )
    static let stone = try! DefinedUnit(
        name: "stone",
        symbol: "st",
        dimension: [.Mass: 1],
        coefficient: 6.35029318
    )
    static let shortTon = try! DefinedUnit(
        name: "shortTon",
        symbol: "ton",
        dimension: [.Mass: 1],
        coefficient: 907.18474
    )
    static let troyOunces = try! DefinedUnit(
        name: "troyOunces",
        symbol: "troyOunces",
        dimension: [.Mass: 1],
        coefficient: 0.0311034768
    )
    static let slug = try! DefinedUnit(
        name: "slug",
        symbol: "slug",
        dimension: [.Mass: 1],
        coefficient: 14.5939
    )

    // MARK: Power

    // Base unit: watt

    static let watt = try! DefinedUnit(
        name: "watt",
        symbol: "W",
        dimension: [.Mass: 1, .Length: 2, .Time: -3]
    )
    static let femptowatt = try! DefinedUnit(
        name: "femptowatt",
        symbol: "fW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e-15
    )
    static let picowatt = try! DefinedUnit(
        name: "picowatt",
        symbol: "pW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e-12
    )
    static let nanowatt = try! DefinedUnit(
        name: "nanowatt",
        symbol: "nW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e-9
    )
    static let microwatt = try! DefinedUnit(
        name: "microwatt",
        symbol: "μW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e-6
    )
    static let milliwatt = try! DefinedUnit(
        name: "milliwatt",
        symbol: "mW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 0.001
    )
    static let kilowatt = try! DefinedUnit(
        name: "kilowatt",
        symbol: "kW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1000
    )
    static let megawatt = try! DefinedUnit(
        name: "megawatt",
        symbol: "MW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e6
    )
    static let gigawatt = try! DefinedUnit(
        name: "gigawatt",
        symbol: "GW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e9
    )
    static let terawatt = try! DefinedUnit(
        name: "terawatt",
        symbol: "TW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1e12
    )
    static let horsepower = try! DefinedUnit(
        name: "horsepower",
        symbol: "hp",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 745.6998715822702
    )
    static let tonRefrigeration = try! DefinedUnit(
        name: "tonRefrigeration",
        symbol: "TR",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 3500
    )

    // MARK: Pressure

    // Base unit: pascal

    static let pascal = try! DefinedUnit(
        name: "pascal",
        symbol: "Pa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2]
    )
    static let hectopascal = try! DefinedUnit(
        name: "hectopascal",
        symbol: "hPa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 100
    )
    static let kilopascal = try! DefinedUnit(
        name: "kilopascal",
        symbol: "kPa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 1000
    )
    static let megapascal = try! DefinedUnit(
        name: "megapascal",
        symbol: "MPa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 1e6
    )
    static let gigapascal = try! DefinedUnit(
        name: "gigapascal",
        symbol: "GPa",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 1e9
    )
    static let bar = try! DefinedUnit(
        name: "bar",
        symbol: "bar",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 100_000
    )
    static let millibar = try! DefinedUnit(
        name: "millibar",
        symbol: "mbar",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 100
    )
    static let atmosphere = try! DefinedUnit(
        name: "atmosphere",
        symbol: "atm",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 101_317.1
    )
    static let millimeterOfMercury = try! DefinedUnit(
        name: "millimeterOfMercury",
        symbol: "mmhg",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 133.322387415
    )
    static let centimeterOfMercury = try! DefinedUnit(
        name: "centimeterOfMercury",
        symbol: "cmhg",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 1333.22387415
    )
    static let inchOfMercury = try! DefinedUnit(
        name: "inchOfMercury",
        symbol: "inhg",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 3386.389
    )
    static let centimeterOfWater = try! DefinedUnit(
        name: "centimeterOfWater",
        symbol: "cmH₂0",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 98.0665
    )
    static let inchOfWater = try! DefinedUnit(
        name: "inchOfWater",
        symbol: "inH₂0",
        dimension: [.Mass: 1, .Length: -1, .Time: -2],
        coefficient: 249.082
    )

    // MARK: Resistance

    // Base unit: ohm

    static let ohm = try! DefinedUnit(
        name: "ohm",
        symbol: "Ω",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2]
    )
    static let microohm = try! DefinedUnit(
        name: "microohm",
        symbol: "μΩ",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
        coefficient: 1e-6
    )
    static let milliohm = try! DefinedUnit(
        name: "milliohm",
        symbol: "mΩ",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
        coefficient: 0.001
    )
    static let kiloohm = try! DefinedUnit(
        name: "kiloohm",
        symbol: "kΩ",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
        coefficient: 1000
    )
    static let megaohm = try! DefinedUnit(
        name: "megaohm",
        symbol: "MΩ",
        dimension: [.Mass: 1, .Length: 2, .Time: -3, .Current: -2],
        coefficient: 1e6
    )

    // MARK: Solid Angle

    // Base unit: steridian

    static let steradian = try! DefinedUnit(
        name: "steradian",
        symbol: "sr",
        dimension: [.Angle: 2]
    )

    // MARK: Temperature

    // Base unit: kelvin

    static let kelvin = try! DefinedUnit(
        name: "kelvin",
        symbol: "K",
        dimension: [.Temperature: 1]
    )
    static let celsius = try! DefinedUnit(
        name: "celsius",
        symbol: "°C",
        dimension: [.Temperature: 1],
        constant: 273.15
    )
    static let fahrenheit = try! DefinedUnit(
        name: "fahrenheit",
        symbol: "°F",
        dimension: [.Temperature: 1],
        coefficient: 5.0 / 9.0,
        constant: 273.15 - (32 * 5.0 / 9.0)
    )
    static let rankine = try! DefinedUnit(
        name: "rankine",
        symbol: "°R",
        dimension: [.Temperature: 1],
        coefficient: 5.0 / 9.0
    )

    // MARK: Time

    // Base unit: second

    static let second = try! DefinedUnit(
        name: "second",
        symbol: "s",
        dimension: [.Time: 1]
    )
    static let nanosecond = try! DefinedUnit(
        name: "nanosecond",
        symbol: "ns",
        dimension: [.Time: 1],
        coefficient: 1e-9
    )
    static let microsecond = try! DefinedUnit(
        name: "microsecond",
        symbol: "μs",
        dimension: [.Time: 1],
        coefficient: 1e-6
    )
    static let millisecond = try! DefinedUnit(
        name: "millisecond",
        symbol: "ms",
        dimension: [.Time: 1],
        coefficient: 0.001
    )
    static let minute = try! DefinedUnit(
        name: "minute",
        symbol: "min",
        dimension: [.Time: 1],
        coefficient: 60
    )
    static let hour = try! DefinedUnit(
        name: "hour",
        symbol: "hr",
        dimension: [.Time: 1],
        coefficient: 3600
    )
    static let day = try! DefinedUnit(
        name: "day",
        symbol: "d",
        dimension: [.Time: 1],
        coefficient: 86400
    )
    static let week = try! DefinedUnit(
        name: "week",
        symbol: "week",
        dimension: [.Time: 1],
        coefficient: 604_800
    )
    // Julian year: https://en.wikipedia.org/wiki/Julian_year_%28astronomy%29
    static let year = try! DefinedUnit(
        name: "year",
        symbol: "yr",
        dimension: [.Time: 1],
        coefficient: 31_557_600
    )

    // MARK: Velocity

    // Base unit: meter / second

    static let knots = try! DefinedUnit(
        name: "knots",
        symbol: "knot",
        dimension: [.Length: 1, .Time: -1],
        coefficient: 0.514444
    )

    // MARK: Volume

    // Base unit: meter^3

    static let liter = try! DefinedUnit(
        name: "liter",
        symbol: "L",
        dimension: [.Length: 3],
        coefficient: 0.001
    )
    static let milliliter = try! DefinedUnit(
        name: "milliliter",
        symbol: "mL",
        dimension: [.Length: 3],
        coefficient: 1e-6
    )
    static let centiliter = try! DefinedUnit(
        name: "centiliter",
        symbol: "cL",
        dimension: [.Length: 3],
        coefficient: 1e-5
    )
    static let deciliter = try! DefinedUnit(
        name: "deciliter",
        symbol: "dL",
        dimension: [.Length: 3],
        coefficient: 1e-4
    )
    static let kiloliter = try! DefinedUnit(
        name: "kiloliter",
        symbol: "kL",
        dimension: [.Length: 3],
        coefficient: 1
    )
    static let megaliter = try! DefinedUnit(
        name: "megaliter",
        symbol: "ML",
        dimension: [.Length: 3],
        coefficient: 1000
    )
    // Liquid measures
    static let teaspoon = try! DefinedUnit(
        name: "teaspoon",
        symbol: "tsp",
        dimension: [.Length: 3],
        coefficient: 4.92892159375e-6
    )
    static let tablespoon = try! DefinedUnit(
        name: "tablespoon",
        symbol: "tbsp",
        dimension: [.Length: 3],
        coefficient: 14.7867647812e-6
    )
    static let fluidOunce = try! DefinedUnit(
        name: "fluidOunce",
        symbol: "fl_oz",
        dimension: [.Length: 3],
        coefficient: 29.5735295625e-6
    )
    static let cup = try! DefinedUnit(
        name: "cup",
        symbol: "cup",
        dimension: [.Length: 3],
        coefficient: 236.5882365e-6
    )
    static let pint = try! DefinedUnit(
        name: "pint",
        symbol: "pt",
        dimension: [.Length: 3],
        coefficient: 473.176473e-6
    )
    static let quart = try! DefinedUnit(
        name: "quart",
        symbol: "qt",
        dimension: [.Length: 3],
        coefficient: 9.46352946e-4
    )
    static let gallon = try! DefinedUnit(
        name: "gallon",
        symbol: "gal",
        dimension: [.Length: 3],
        coefficient: 0.003785411784
    )
    // Dry measures: https://en.wikipedia.org/wiki/Dry_measure
    static let dryPint: DefinedUnit = try! DefinedUnit(
        name: "dryPint",
        symbol: "drypt",
        dimension: [.Length: 3],
        coefficient: 5.506104713575e-4
    )
    static let dryQuart: DefinedUnit = try! DefinedUnit(
        name: "dryQuart",
        symbol: "dryqt",
        dimension: [.Length: 3],
        coefficient: 1.101220942715e-3
    )
    static let peck: DefinedUnit = try! DefinedUnit(
        name: "peck",
        symbol: "pk",
        dimension: [.Length: 3],
        coefficient: 8.80976754172e-3
    )
    static let bushel = try! DefinedUnit(
        name: "bushel",
        symbol: "bu",
        dimension: [.Length: 3],
        coefficient: 0.035239070167
    )
    // Imperial measures
    static let imperialFluidOunce = try! DefinedUnit(
        name: "imperialFluidOunce",
        symbol: "ifl_oz",
        dimension: [.Length: 3],
        coefficient: 28.4130625e-6
    )
    static let imperialCup = try! DefinedUnit(
        name: "imperialCup",
        symbol: "icup",
        dimension: [.Length: 3],
        coefficient: 197.15686375 - 6
    )
    static let imperialPint = try! DefinedUnit(
        name: "imperialPint",
        symbol: "ipt",
        dimension: [.Length: 3],
        coefficient: 568.26125e-6
    )
    static let imperialQuart = try! DefinedUnit(
        name: "imperialQuart",
        symbol: "iqt",
        dimension: [.Length: 3],
        coefficient: 1.1365225e-3
    )
    static let imperialGallon = try! DefinedUnit(
        name: "imperialGallon",
        symbol: "igal",
        dimension: [.Length: 3],
        coefficient: 0.00454609
    )
    static let imperialPeck: DefinedUnit = try! DefinedUnit(
        name: "imperialPeck",
        symbol: "ipk",
        dimension: [.Length: 3],
        coefficient: 9.09218e-3
    )
    static let metricCup = try! DefinedUnit(
        name: "metricCup",
        symbol: "mcup",
        dimension: [.Length: 3],
        coefficient: 0.00025
    )
}
