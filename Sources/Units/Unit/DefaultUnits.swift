import Foundation

/// Static type containing this package's pre-defined units
enum DefaultUnits {
    // If adding units to this list, add corresponding entries to the following files:
    // - Unit+DefaultUnits.swift
    // - RegistryBuilder.swift
    // - DefinitionTests.swift

    // MARK: Acceleration

    // Base unit: meter / second^2

    static let standardGravity = try! DefinedUnit(
        name: "standardGravity",
        symbol: "ɡ",
        dimension: [.length: 1, .time: -2],
        coefficient: 9.80665
    )

    // MARK: Amount

    // Base unit: mole

    static let mole = try! DefinedUnit(
        name: "mole",
        symbol: "mol",
        dimension: [.amount: 1]
    )
    static let millimole = try! DefinedUnit(
        name: "millimole",
        symbol: "mmol",
        dimension: [.amount: 1],
        coefficient: 0.001
    )
    static let particle = try! DefinedUnit(
        name: "particle",
        symbol: "particle",
        dimension: [.amount: 1],
        coefficient: 6.02214076e-23
    )

    // MARK: Angle

    // Base unit: radian

    static let radian = try! DefinedUnit(
        name: "radian",
        symbol: "rad",
        dimension: [.angle: 1]
    )
    static let degree = try! DefinedUnit(
        name: "degree",
        symbol: "°",
        dimension: [.angle: 1],
        coefficient: 180 / Double.pi
    )
    static let revolution = try! DefinedUnit(
        name: "revolution",
        symbol: "rev",
        dimension: [.angle: 1],
        coefficient: 2 * Double.pi
    )

    // MARK: Area

    // Base unit: meter^2

    static let acre = try! DefinedUnit(
        name: "acre",
        symbol: "ac",
        dimension: [.length: 2],
        coefficient: 4046.8564224
    )
    static let are = try! DefinedUnit(
        name: "are",
        symbol: "a",
        dimension: [.length: 2],
        coefficient: 100
    )
    static let hectare = try! DefinedUnit(
        name: "hectare",
        symbol: "ha",
        dimension: [.length: 2],
        coefficient: 10000
    )

    // MARK: Capacitance

    // Base unit: farad

    static let farad = try! DefinedUnit(
        name: "farad",
        symbol: "F",
        dimension: [.current: 2, .time: 4, .length: -2, .mass: -1]
    )

    // MARK: Charge

    // Base unit: coloumb

    static let coulomb = try! DefinedUnit(
        name: "coulomb",
        symbol: "C",
        dimension: [.current: 1, .time: 1]
    )

    // MARK: Current

    // Base unit: ampere

    static let ampere = try! DefinedUnit(
        name: "ampere",
        symbol: "A",
        dimension: [.current: 1]
    )
    static let microampere = try! DefinedUnit(
        name: "microampere",
        symbol: "μA",
        dimension: [.current: 1],
        coefficient: 1e-6
    )
    static let milliampere = try! DefinedUnit(
        name: "milliampere",
        symbol: "mA",
        dimension: [.current: 1],
        coefficient: 0.001
    )
    static let kiloampere = try! DefinedUnit(
        name: "kiloampere",
        symbol: "kA",
        dimension: [.current: 1],
        coefficient: 1000
    )
    static let megaampere = try! DefinedUnit(
        name: "megaampere",
        symbol: "MA",
        dimension: [.current: 1],
        coefficient: 1e6
    )

    // MARK: Data

    // Base unit: bit

    static let bit = try! DefinedUnit(
        name: "bit",
        symbol: "bit",
        dimension: [.data: 1]
    )
    static let kilobit = try! DefinedUnit(
        name: "kilobit",
        symbol: "kbit",
        dimension: [.data: 1],
        coefficient: 1000
    )
    static let megabit = try! DefinedUnit(
        name: "megabit",
        symbol: "Mbit",
        dimension: [.data: 1],
        coefficient: 1e6
    )
    static let gigabit = try! DefinedUnit(
        name: "gigabit",
        symbol: "Gbit",
        dimension: [.data: 1],
        coefficient: 1e9
    )
    static let terabit = try! DefinedUnit(
        name: "terabit",
        symbol: "Tbit",
        dimension: [.data: 1],
        coefficient: 1e12
    )
    static let petabit = try! DefinedUnit(
        name: "petabit",
        symbol: "Pbit",
        dimension: [.data: 1],
        coefficient: 1e15
    )
    static let exabit = try! DefinedUnit(
        name: "exabit",
        symbol: "Ebit",
        dimension: [.data: 1],
        coefficient: 1e18
    )
    static let zetabit = try! DefinedUnit(
        name: "zetabit",
        symbol: "Zbit",
        dimension: [.data: 1],
        coefficient: 1e21
    )
    static let yottabit = try! DefinedUnit(
        name: "yottabit",
        symbol: "Ybit",
        dimension: [.data: 1],
        coefficient: 1e24
    )
    static let kibibit = try! DefinedUnit(
        name: "kibibit",
        symbol: "Kibit",
        dimension: [.data: 1],
        coefficient: 1024
    )
    static let mebibit = try! DefinedUnit(
        name: "mebibit",
        symbol: "Mibit",
        dimension: [.data: 1],
        coefficient: pow(1024, 2)
    )
    static let gibibit = try! DefinedUnit(
        name: "gibibit",
        symbol: "Gibit",
        dimension: [.data: 1],
        coefficient: pow(1024, 3)
    )
    static let tebibit = try! DefinedUnit(
        name: "tebibit",
        symbol: "Tibit",
        dimension: [.data: 1],
        coefficient: pow(1024, 4)
    )
    static let pebibit = try! DefinedUnit(
        name: "pebibit",
        symbol: "Pibit",
        dimension: [.data: 1],
        coefficient: pow(1024, 5)
    )
    static let exbibit = try! DefinedUnit(
        name: "exbibit",
        symbol: "Eibit",
        dimension: [.data: 1],
        coefficient: pow(1024, 6)
    )
    static let zebibit = try! DefinedUnit(
        name: "zebibit",
        symbol: "Zibit",
        dimension: [.data: 1],
        coefficient: pow(1024, 7)
    )
    static let yobibit = try! DefinedUnit(
        name: "yobibit",
        symbol: "Yibit",
        dimension: [.data: 1],
        coefficient: pow(1024, 8)
    )
    static let byte = try! DefinedUnit(
        name: "byte",
        symbol: "byte",
        dimension: [.data: 1],
        coefficient: 8
    )
    static let kilobyte = try! DefinedUnit(
        name: "kilobyte",
        symbol: "kB",
        dimension: [.data: 1],
        coefficient: 8000
    )
    static let megabyte = try! DefinedUnit(
        name: "megabyte",
        symbol: "MB",
        dimension: [.data: 1],
        coefficient: 8e6
    )
    static let gigabyte = try! DefinedUnit(
        name: "gigabyte",
        symbol: "GB",
        dimension: [.data: 1],
        coefficient: 8e9
    )
    static let terabyte = try! DefinedUnit(
        name: "terabyte",
        symbol: "TB",
        dimension: [.data: 1],
        coefficient: 8e12
    )
    static let petabyte = try! DefinedUnit(
        name: "petabyte",
        symbol: "PB",
        dimension: [.data: 1],
        coefficient: 8e15
    )
    static let exabyte = try! DefinedUnit(
        name: "exabyte",
        symbol: "EB",
        dimension: [.data: 1],
        coefficient: 8e18
    )
    static let zetabyte = try! DefinedUnit(
        name: "zetabyte",
        symbol: "ZB",
        dimension: [.data: 1],
        coefficient: 8e21
    )
    static let yottabyte = try! DefinedUnit(
        name: "yottabyte",
        symbol: "YB",
        dimension: [.data: 1],
        coefficient: 8e24
    )
    static let kibibyte = try! DefinedUnit(
        name: "kibibyte",
        symbol: "KiB",
        dimension: [.data: 1],
        coefficient: 8 * 1024
    )
    static let mebibyte = try! DefinedUnit(
        name: "mebibyte",
        symbol: "MiB",
        dimension: [.data: 1],
        coefficient: 8 * pow(1024, 2)
    )
    static let gibibyte = try! DefinedUnit(
        name: "gibibyte",
        symbol: "GiB",
        dimension: [.data: 1],
        coefficient: 8 * pow(1024, 3)
    )
    static let tebibyte = try! DefinedUnit(
        name: "tebibyte",
        symbol: "TiB",
        dimension: [.data: 1],
        coefficient: 8 * pow(1024, 4)
    )
    static let pebibyte = try! DefinedUnit(
        name: "pebibyte",
        symbol: "PiB",
        dimension: [.data: 1],
        coefficient: 8 * pow(1024, 5)
    )
    static let exbibyte = try! DefinedUnit(
        name: "exbibyte",
        symbol: "EiB",
        dimension: [.data: 1],
        coefficient: 8 * pow(1024, 6)
    )
    static let zebibyte = try! DefinedUnit(
        name: "zebibyte",
        symbol: "ZiB",
        dimension: [.data: 1],
        coefficient: 8 * pow(1024, 7)
    )
    static let yobibyte = try! DefinedUnit(
        name: "yobibyte",
        symbol: "YiB",
        dimension: [.data: 1],
        coefficient: 8 * pow(1024, 8)
    )

    // MARK: Electric Potential Difference

    // Base unit: volt

    static let volt = try! DefinedUnit(
        name: "volt",
        symbol: "V",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -1]
    )
    static let microvolt = try! DefinedUnit(
        name: "microvolt",
        symbol: "μV",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -1],
        coefficient: 1e-6
    )
    static let millivolt = try! DefinedUnit(
        name: "millivolt",
        symbol: "mV",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -1],
        coefficient: 0.001
    )
    static let kilovolt = try! DefinedUnit(
        name: "kilovolt",
        symbol: "kV",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -1],
        coefficient: 1000
    )
    static let megavolt = try! DefinedUnit(
        name: "megavolt",
        symbol: "MV",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -1],
        coefficient: 1e6
    )

    // MARK: Energy

    // Base unit: joule

    static let joule = try! DefinedUnit(
        name: "joule",
        symbol: "J",
        dimension: [.mass: 1, .length: 2, .time: -2]
    )
    static let kilojoule = try! DefinedUnit(
        name: "kilojoule",
        symbol: "kJ",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 1000
    )
    static let megajoule = try! DefinedUnit(
        name: "megajoule",
        symbol: "MJ",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 1_000_000
    )
    static let calorie = try! DefinedUnit(
        name: "calorie",
        symbol: "cal",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 4.184
    )
    static let kilocalorie = try! DefinedUnit(
        name: "kilocalorie",
        symbol: "kCal",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 4184
    )
    // Thermochemical BTU: https://en.wikipedia.org/wiki/British_thermal_unit#Definitions
    static let btu = try! DefinedUnit(
        name: "btu",
        symbol: "BTU",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 1054.35
    )
    static let kilobtu = try! DefinedUnit(
        name: "kilobtu",
        symbol: "kBTU",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 1.05435e6
    )
    static let megabtu = try! DefinedUnit(
        name: "megabtu",
        symbol: "MBTU",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 1.05435e9
    )
    static let therm = try! DefinedUnit(
        name: "therm",
        symbol: "therm",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 1.05435e8
    )
    static let electronVolt = try! DefinedUnit(
        name: "electronVolt",
        symbol: "eV",
        dimension: [.mass: 1, .length: 2, .time: -2],
        coefficient: 1.602176634e-19
    )

    // MARK: Force

    // Base unit: newton

    static let newton = try! DefinedUnit(
        name: "newton",
        symbol: "N",
        dimension: [.mass: 1, .length: 1, .time: -2]
    )
    static let poundForce = try! DefinedUnit(
        name: "poundForce",
        symbol: "lbf",
        dimension: [.mass: 1, .length: 1, .time: -2],
        coefficient: 4.448222
    )

    // MARK: Frequency

    // Base unit: hertz

    static let hertz = try! DefinedUnit(
        name: "hertz",
        symbol: "Hz",
        dimension: [.time: -1]
    )
    static let nanohertz = try! DefinedUnit(
        name: "nanohertz",
        symbol: "nHz",
        dimension: [.time: -1],
        coefficient: 1e-9
    )
    static let microhertz = try! DefinedUnit(
        name: "microhertz",
        symbol: "μHz",
        dimension: [.time: -1],
        coefficient: 1e-6
    )
    static let millihertz = try! DefinedUnit(
        name: "millihertz",
        symbol: "mHz",
        dimension: [.time: -1],
        coefficient: 0.001
    )
    static let kilohertz = try! DefinedUnit(
        name: "kilohertz",
        symbol: "kHz",
        dimension: [.time: -1],
        coefficient: 1000
    )
    static let megahertz = try! DefinedUnit(
        name: "megahertz",
        symbol: "MHz",
        dimension: [.time: -1],
        coefficient: 1e6
    )
    static let gigahertz = try! DefinedUnit(
        name: "gigahertz",
        symbol: "GHz",
        dimension: [.time: -1],
        coefficient: 1e9
    )
    static let terahertz = try! DefinedUnit(
        name: "terahertz",
        symbol: "THz",
        dimension: [.time: -1],
        coefficient: 1e12
    )

    // MARK: Illuminance

    // Base unit: lux

    static let lux = try! DefinedUnit(
        name: "lux",
        symbol: "lx",
        dimension: [.luminousIntensity: 1, .length: -2]
    )
    static let footCandle = try! DefinedUnit(
        name: "footCandle",
        symbol: "fc",
        dimension: [.luminousIntensity: 1, .length: -2],
        coefficient: 10.76
    )
    static let phot = try! DefinedUnit(
        name: "phot",
        symbol: "phot",
        dimension: [.luminousIntensity: 1, .length: -2],
        coefficient: 10000
    )

    // MARK: Inductance

    // Base unit: henry

    static let henry = try! DefinedUnit(
        name: "henry",
        symbol: "H",
        dimension: [.length: 2, .mass: 1, .current: -2]
    )

    // MARK: Length

    // Base unit: meter

    static let meter = try! DefinedUnit(
        name: "meter",
        symbol: "m",
        dimension: [.length: 1]
    )
    static let picometer = try! DefinedUnit(
        name: "picometer",
        symbol: "pm",
        dimension: [.length: 1],
        coefficient: 1e-12
    )
    static let nanoometer = try! DefinedUnit(
        name: "nanoometer",
        symbol: "nm",
        dimension: [.length: 1],
        coefficient: 1e-9
    )
    static let micrometer = try! DefinedUnit(
        name: "micrometer",
        symbol: "μm",
        dimension: [.length: 1],
        coefficient: 1e-6
    )
    static let millimeter = try! DefinedUnit(
        name: "millimeter",
        symbol: "mm",
        dimension: [.length: 1],
        coefficient: 0.001
    )
    static let centimeter = try! DefinedUnit(
        name: "centimeter",
        symbol: "cm",
        dimension: [.length: 1],
        coefficient: 0.01
    )
    static let decameter = try! DefinedUnit(
        name: "decameter",
        symbol: "dm",
        dimension: [.length: 1],
        coefficient: 10
    )
    static let hectometer = try! DefinedUnit(
        name: "hectometer",
        symbol: "hm",
        dimension: [.length: 1],
        coefficient: 100
    )
    static let kilometer = try! DefinedUnit(
        name: "kilometer",
        symbol: "km",
        dimension: [.length: 1],
        coefficient: 1000
    )
    static let megameter = try! DefinedUnit(
        name: "megameter",
        symbol: "Mm",
        dimension: [.length: 1],
        coefficient: 1e6
    )
    static let inch = try! DefinedUnit(
        name: "inch",
        symbol: "in",
        dimension: [.length: 1],
        coefficient: 0.0254
    )
    static let foot = try! DefinedUnit(
        name: "foot",
        symbol: "ft",
        dimension: [.length: 1],
        coefficient: 0.3048
    )
    // International yard: https://en.wikipedia.org/wiki/Yard
    static let yard = try! DefinedUnit(
        name: "yard",
        symbol: "yd",
        dimension: [.length: 1],
        coefficient: 0.9144
    )
    static let mile = try! DefinedUnit(
        name: "mile",
        symbol: "mi",
        dimension: [.length: 1],
        coefficient: 1609.344
    )
    static let scandanavianMile = try! DefinedUnit(
        name: "scandanavianMile",
        symbol: "smi",
        dimension: [.length: 1],
        coefficient: 10000
    )
    static let nauticalMile = try! DefinedUnit(
        name: "nauticalMile",
        symbol: "NM",
        dimension: [.length: 1],
        coefficient: 1852
    )
    static let fathom = try! DefinedUnit(
        name: "fathom",
        symbol: "fathom",
        dimension: [.length: 1],
        coefficient: 1.8288
    )
    static let furlong = try! DefinedUnit(
        name: "furlong",
        symbol: "furlong",
        dimension: [.length: 1],
        coefficient: 201.168
    )
    static let astronomicalUnit = try! DefinedUnit(
        name: "astronomicalUnit",
        symbol: "au",
        dimension: [.length: 1],
        coefficient: 1.495978707e11
    )
    static let lightyear = try! DefinedUnit(
        name: "lightyear",
        symbol: "ly",
        dimension: [.length: 1],
        coefficient: 9.4607304725808e15
    )
    static let parsec = try! DefinedUnit(
        name: "parsec",
        symbol: "pc",
        dimension: [.length: 1],
        coefficient: 3.0856775814913673e16
    )

    // MARK: Luminous Intensity

    // Base unit: candela

    static let candela = try! DefinedUnit(
        name: "candela",
        symbol: "cd",
        dimension: [.luminousIntensity: 1]
    )

    // MARK: Luminous Flux

    // Base unit: lumen

    static let lumen = try! DefinedUnit(
        name: "lumen",
        symbol: "lm",
        dimension: [.angle: 2, .luminousIntensity: 1]
    )

    // MARK: Magnetic Flux

    // Base unit: weber

    static let weber = try! DefinedUnit(
        name: "weber",
        symbol: "Wb",
        dimension: [.mass: 1, .length: 2, .time: -2, .current: -1]
    )

    // MARK: Magnetic Flux Density

    // Base unit: tesla

    static let tesla = try! DefinedUnit(
        name: "tesla",
        symbol: "T",
        dimension: [.mass: 1, .time: -2, .current: -1]
    )

    // MARK: Mass

    // Base unit: kilogram

    static let kilogram = try! DefinedUnit(
        name: "kilogram",
        symbol: "kg",
        dimension: [.mass: 1]
    )
    static let picogram = try! DefinedUnit(
        name: "picogram",
        symbol: "pg",
        dimension: [.mass: 1],
        coefficient: 1e-15
    )
    static let nanogram = try! DefinedUnit(
        name: "nanogram",
        symbol: "ng",
        dimension: [.mass: 1],
        coefficient: 1e-12
    )
    static let microgram = try! DefinedUnit(
        name: "microgram",
        symbol: "μg",
        dimension: [.mass: 1],
        coefficient: 1e-9
    )
    static let milligram = try! DefinedUnit(
        name: "milligram",
        symbol: "mg",
        dimension: [.mass: 1],
        coefficient: 1e-6
    )
    static let centigram = try! DefinedUnit(
        name: "centigram",
        symbol: "cg",
        dimension: [.mass: 1],
        coefficient: 0.00001
    )
    static let decigram = try! DefinedUnit(
        name: "decigram",
        symbol: "dg",
        dimension: [.mass: 1],
        coefficient: 0.0001
    )
    static let gram = try! DefinedUnit(
        name: "gram",
        symbol: "g",
        dimension: [.mass: 1],
        coefficient: 0.001
    )
    static let metricTon = try! DefinedUnit(
        name: "metricTon",
        symbol: "t",
        dimension: [.mass: 1],
        coefficient: 1000
    )
    static let carat = try! DefinedUnit(
        name: "carat",
        symbol: "ct",
        dimension: [.mass: 1],
        coefficient: 0.0002
    )
    static let ounce = try! DefinedUnit(
        name: "ounce",
        symbol: "oz",
        dimension: [.mass: 1],
        coefficient: 0.028349523125
    )
    // pound-mass: https://en.wikipedia.org/wiki/Pound_(mass)
    static let pound = try! DefinedUnit(
        name: "pound",
        symbol: "lb",
        dimension: [.mass: 1],
        coefficient: 0.45359237
    )
    static let stone = try! DefinedUnit(
        name: "stone",
        symbol: "st",
        dimension: [.mass: 1],
        coefficient: 6.35029318
    )
    static let shortTon = try! DefinedUnit(
        name: "shortTon",
        symbol: "ton",
        dimension: [.mass: 1],
        coefficient: 907.18474
    )
    static let troyOunces = try! DefinedUnit(
        name: "troyOunces",
        symbol: "troyOunces",
        dimension: [.mass: 1],
        coefficient: 0.0311034768
    )
    static let slug = try! DefinedUnit(
        name: "slug",
        symbol: "slug",
        dimension: [.mass: 1],
        coefficient: 14.5939
    )

    // MARK: Percent

    static let percent = try! DefinedUnit(
        name: "percent",
        symbol: "%",
        dimension: [:],
        coefficient: 0.01
    )

    // MARK: Power

    // Base unit: watt

    static let watt = try! DefinedUnit(
        name: "watt",
        symbol: "W",
        dimension: [.mass: 1, .length: 2, .time: -3]
    )
    static let femptowatt = try! DefinedUnit(
        name: "femptowatt",
        symbol: "fW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 1e-15
    )
    static let picowatt = try! DefinedUnit(
        name: "picowatt",
        symbol: "pW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 1e-12
    )
    static let nanowatt = try! DefinedUnit(
        name: "nanowatt",
        symbol: "nW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 1e-9
    )
    static let microwatt = try! DefinedUnit(
        name: "microwatt",
        symbol: "μW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 1e-6
    )
    static let milliwatt = try! DefinedUnit(
        name: "milliwatt",
        symbol: "mW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 0.001
    )
    static let kilowatt = try! DefinedUnit(
        name: "kilowatt",
        symbol: "kW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 1000
    )
    static let megawatt = try! DefinedUnit(
        name: "megawatt",
        symbol: "MW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 1e6
    )
    static let gigawatt = try! DefinedUnit(
        name: "gigawatt",
        symbol: "GW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 1e9
    )
    static let terawatt = try! DefinedUnit(
        name: "terawatt",
        symbol: "TW",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 1e12
    )
    static let horsepower = try! DefinedUnit(
        name: "horsepower",
        symbol: "hp",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 745.6998715822702
    )
    static let tonRefrigeration = try! DefinedUnit(
        name: "tonRefrigeration",
        symbol: "TR",
        dimension: [.mass: 1, .length: 2, .time: -3],
        coefficient: 3500
    )

    // MARK: Pressure

    // Base unit: pascal

    static let pascal = try! DefinedUnit(
        name: "pascal",
        symbol: "Pa",
        dimension: [.mass: 1, .length: -1, .time: -2]
    )
    static let hectopascal = try! DefinedUnit(
        name: "hectopascal",
        symbol: "hPa",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 100
    )
    static let kilopascal = try! DefinedUnit(
        name: "kilopascal",
        symbol: "kPa",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 1000
    )
    static let megapascal = try! DefinedUnit(
        name: "megapascal",
        symbol: "MPa",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 1e6
    )
    static let gigapascal = try! DefinedUnit(
        name: "gigapascal",
        symbol: "GPa",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 1e9
    )
    static let bar = try! DefinedUnit(
        name: "bar",
        symbol: "bar",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 100_000
    )
    static let millibar = try! DefinedUnit(
        name: "millibar",
        symbol: "mbar",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 100
    )
    static let atmosphere = try! DefinedUnit(
        name: "atmosphere",
        symbol: "atm",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 101_317.1
    )
    static let millimeterOfMercury = try! DefinedUnit(
        name: "millimeterOfMercury",
        symbol: "mmhg",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 133.322387415
    )
    static let centimeterOfMercury = try! DefinedUnit(
        name: "centimeterOfMercury",
        symbol: "cmhg",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 1333.22387415
    )
    static let inchOfMercury = try! DefinedUnit(
        name: "inchOfMercury",
        symbol: "inhg",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 3386.389
    )
    static let centimeterOfWater = try! DefinedUnit(
        name: "centimeterOfWater",
        symbol: "cmH₂0",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 98.0665
    )
    static let inchOfWater = try! DefinedUnit(
        name: "inchOfWater",
        symbol: "inH₂0",
        dimension: [.mass: 1, .length: -1, .time: -2],
        coefficient: 249.082
    )

    // MARK: Resistance

    // Base unit: ohm

    static let ohm = try! DefinedUnit(
        name: "ohm",
        symbol: "Ω",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -2]
    )
    static let microohm = try! DefinedUnit(
        name: "microohm",
        symbol: "μΩ",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -2],
        coefficient: 1e-6
    )
    static let milliohm = try! DefinedUnit(
        name: "milliohm",
        symbol: "mΩ",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -2],
        coefficient: 0.001
    )
    static let kiloohm = try! DefinedUnit(
        name: "kiloohm",
        symbol: "kΩ",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -2],
        coefficient: 1000
    )
    static let megaohm = try! DefinedUnit(
        name: "megaohm",
        symbol: "MΩ",
        dimension: [.mass: 1, .length: 2, .time: -3, .current: -2],
        coefficient: 1e6
    )

    // MARK: Solid Angle

    // Base unit: steridian

    static let steradian = try! DefinedUnit(
        name: "steradian",
        symbol: "sr",
        dimension: [.angle: 2]
    )

    // MARK: Temperature

    // Base unit: kelvin

    static let kelvin = try! DefinedUnit(
        name: "kelvin",
        symbol: "K",
        dimension: [.temperature: 1]
    )
    static let celsius = try! DefinedUnit(
        name: "celsius",
        symbol: "°C",
        dimension: [.temperature: 1],
        constant: 273.15
    )
    static let fahrenheit = try! DefinedUnit(
        name: "fahrenheit",
        symbol: "°F",
        dimension: [.temperature: 1],
        coefficient: 5.0 / 9.0,
        constant: 273.15 - (32 * 5.0 / 9.0)
    )
    static let rankine = try! DefinedUnit(
        name: "rankine",
        symbol: "°R",
        dimension: [.temperature: 1],
        coefficient: 5.0 / 9.0
    )

    // MARK: Time

    // Base unit: second

    static let second = try! DefinedUnit(
        name: "second",
        symbol: "s",
        dimension: [.time: 1]
    )
    static let nanosecond = try! DefinedUnit(
        name: "nanosecond",
        symbol: "ns",
        dimension: [.time: 1],
        coefficient: 1e-9
    )
    static let microsecond = try! DefinedUnit(
        name: "microsecond",
        symbol: "μs",
        dimension: [.time: 1],
        coefficient: 1e-6
    )
    static let millisecond = try! DefinedUnit(
        name: "millisecond",
        symbol: "ms",
        dimension: [.time: 1],
        coefficient: 0.001
    )
    static let minute = try! DefinedUnit(
        name: "minute",
        symbol: "min",
        dimension: [.time: 1],
        coefficient: 60
    )
    static let hour = try! DefinedUnit(
        name: "hour",
        symbol: "hr",
        dimension: [.time: 1],
        coefficient: 3600
    )
    static let day = try! DefinedUnit(
        name: "day",
        symbol: "d",
        dimension: [.time: 1],
        coefficient: 86400
    )
    static let week = try! DefinedUnit(
        name: "week",
        symbol: "week",
        dimension: [.time: 1],
        coefficient: 604_800
    )
    // Julian year: https://en.wikipedia.org/wiki/Julian_year_%28astronomy%29
    static let year = try! DefinedUnit(
        name: "year",
        symbol: "yr",
        dimension: [.time: 1],
        coefficient: 31_557_600
    )

    // MARK: Velocity

    // Base unit: meter / second

    static let knots = try! DefinedUnit(
        name: "knots",
        symbol: "knot",
        dimension: [.length: 1, .time: -1],
        coefficient: 0.514444
    )

    // MARK: Volume

    // Base unit: meter^3

    static let liter = try! DefinedUnit(
        name: "liter",
        symbol: "L",
        dimension: [.length: 3],
        coefficient: 0.001
    )
    static let milliliter = try! DefinedUnit(
        name: "milliliter",
        symbol: "mL",
        dimension: [.length: 3],
        coefficient: 1e-6
    )
    static let centiliter = try! DefinedUnit(
        name: "centiliter",
        symbol: "cL",
        dimension: [.length: 3],
        coefficient: 1e-5
    )
    static let deciliter = try! DefinedUnit(
        name: "deciliter",
        symbol: "dL",
        dimension: [.length: 3],
        coefficient: 1e-4
    )
    static let kiloliter = try! DefinedUnit(
        name: "kiloliter",
        symbol: "kL",
        dimension: [.length: 3],
        coefficient: 1
    )
    static let megaliter = try! DefinedUnit(
        name: "megaliter",
        symbol: "ML",
        dimension: [.length: 3],
        coefficient: 1000
    )
    // Liquid measures
    static let teaspoon = try! DefinedUnit(
        name: "teaspoon",
        symbol: "tsp",
        dimension: [.length: 3],
        coefficient: 4.92892159375e-6
    )
    static let tablespoon = try! DefinedUnit(
        name: "tablespoon",
        symbol: "tbsp",
        dimension: [.length: 3],
        coefficient: 14.7867647812e-6
    )
    static let fluidOunce = try! DefinedUnit(
        name: "fluidOunce",
        symbol: "fl_oz",
        dimension: [.length: 3],
        coefficient: 29.5735295625e-6
    )
    static let cup = try! DefinedUnit(
        name: "cup",
        symbol: "cup",
        dimension: [.length: 3],
        coefficient: 236.5882365e-6
    )
    static let pint = try! DefinedUnit(
        name: "pint",
        symbol: "pt",
        dimension: [.length: 3],
        coefficient: 473.176473e-6
    )
    static let quart = try! DefinedUnit(
        name: "quart",
        symbol: "qt",
        dimension: [.length: 3],
        coefficient: 9.46352946e-4
    )
    static let gallon = try! DefinedUnit(
        name: "gallon",
        symbol: "gal",
        dimension: [.length: 3],
        coefficient: 0.003785411784
    )
    // Dry measures: https://en.wikipedia.org/wiki/Dry_measure
    static let dryPint: DefinedUnit = try! DefinedUnit(
        name: "dryPint",
        symbol: "drypt",
        dimension: [.length: 3],
        coefficient: 5.506104713575e-4
    )
    static let dryQuart: DefinedUnit = try! DefinedUnit(
        name: "dryQuart",
        symbol: "dryqt",
        dimension: [.length: 3],
        coefficient: 1.101220942715e-3
    )
    static let peck: DefinedUnit = try! DefinedUnit(
        name: "peck",
        symbol: "pk",
        dimension: [.length: 3],
        coefficient: 8.80976754172e-3
    )
    static let bushel = try! DefinedUnit(
        name: "bushel",
        symbol: "bu",
        dimension: [.length: 3],
        coefficient: 0.035239070167
    )
    // Imperial measures
    static let imperialFluidOunce = try! DefinedUnit(
        name: "imperialFluidOunce",
        symbol: "ifl_oz",
        dimension: [.length: 3],
        coefficient: 28.4130625e-6
    )
    static let imperialCup = try! DefinedUnit(
        name: "imperialCup",
        symbol: "icup",
        dimension: [.length: 3],
        coefficient: 197.15686375e-6
    )
    static let imperialPint = try! DefinedUnit(
        name: "imperialPint",
        symbol: "ipt",
        dimension: [.length: 3],
        coefficient: 568.26125e-6
    )
    static let imperialQuart = try! DefinedUnit(
        name: "imperialQuart",
        symbol: "iqt",
        dimension: [.length: 3],
        coefficient: 1.1365225e-3
    )
    static let imperialGallon = try! DefinedUnit(
        name: "imperialGallon",
        symbol: "igal",
        dimension: [.length: 3],
        coefficient: 0.00454609
    )
    static let imperialPeck: DefinedUnit = try! DefinedUnit(
        name: "imperialPeck",
        symbol: "ipk",
        dimension: [.length: 3],
        coefficient: 9.09218e-3
    )
    static let metricCup = try! DefinedUnit(
        name: "metricCup",
        symbol: "mcup",
        dimension: [.length: 3],
        coefficient: 0.00025
    )
}
