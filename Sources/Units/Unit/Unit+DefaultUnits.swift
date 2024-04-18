// TODO: Make more
// - Concentration Mass
// - Dispersion
// - Information Storage: https://developer.apple.com/documentation/foundation/unitinformationstorage

public extension Unit {
    // Provided as easy access to UnitRegistry default units

    // MARK: Acceleration

    static let standardGravity = Unit(definedBy: DefaultUnits.standardGravity)

    // MARK: Amount

    static let mole = Unit(definedBy: DefaultUnits.mole)
    static let millimole = Unit(definedBy: DefaultUnits.millimole)
    static let particle = Unit(definedBy: DefaultUnits.particle)

    // MARK: Angle

    static let radian = Unit(definedBy: DefaultUnits.radian)
    static let degree = Unit(definedBy: DefaultUnits.degree)
    static let revolution = Unit(definedBy: DefaultUnits.revolution)

    // MARK: Area

    static let acre = Unit(definedBy: DefaultUnits.acre)
    static let are = Unit(definedBy: DefaultUnits.are)
    static let hectare = Unit(definedBy: DefaultUnits.hectare)

    // MARK: Capacitance

    static let farad = Unit(definedBy: DefaultUnits.farad)

    // MARK: Charge

    static let coulomb = Unit(definedBy: DefaultUnits.coulomb)

    // MARK: Current

    static let ampere = Unit(definedBy: DefaultUnits.ampere)
    static let microampere = Unit(definedBy: DefaultUnits.microampere)
    static let milliampere = Unit(definedBy: DefaultUnits.milliampere)
    static let kiloampere = Unit(definedBy: DefaultUnits.kiloampere)
    static let megaampere = Unit(definedBy: DefaultUnits.megaampere)

    // MARK: Data

    static let bit = Unit(definedBy: DefaultUnits.bit)
    static let byte = Unit(definedBy: DefaultUnits.byte)
    static let kilobyte = Unit(definedBy: DefaultUnits.kilobyte)
    static let megabyte = Unit(definedBy: DefaultUnits.megabyte)
    static let gigabyte = Unit(definedBy: DefaultUnits.gigabyte)
    static let petabyte = Unit(definedBy: DefaultUnits.petabyte)

    // MARK: Electric Potential Difference

    static let volt = Unit(definedBy: DefaultUnits.volt)
    static let microvolt = Unit(definedBy: DefaultUnits.microvolt)
    static let millivolt = Unit(definedBy: DefaultUnits.millivolt)
    static let kilovolt = Unit(definedBy: DefaultUnits.kilovolt)
    static let megavolt = Unit(definedBy: DefaultUnits.megavolt)

    // MARK: Energy

    static let joule = Unit(definedBy: DefaultUnits.joule)
    static let kilojoule = Unit(definedBy: DefaultUnits.kilojoule)
    static let megajoule = Unit(definedBy: DefaultUnits.megajoule)
    static let calorie = Unit(definedBy: DefaultUnits.calorie)
    static let kilocalorie = Unit(definedBy: DefaultUnits.kilocalorie)
    static let btu = Unit(definedBy: DefaultUnits.btu)
    static let kilobtu = Unit(definedBy: DefaultUnits.kilobtu)
    static let megabtu = Unit(definedBy: DefaultUnits.megabtu)
    static let therm = Unit(definedBy: DefaultUnits.therm)
    static let electronVolt = Unit(definedBy: DefaultUnits.electronVolt)

    // MARK: Force

    static let newton = Unit(definedBy: DefaultUnits.newton)
    static let poundForce = Unit(definedBy: DefaultUnits.poundForce)

    // MARK: Frequency

    static let hertz = Unit(definedBy: DefaultUnits.hertz)
    static let nanohertz = Unit(definedBy: DefaultUnits.nanohertz)
    static let microhertz = Unit(definedBy: DefaultUnits.microhertz)
    static let millihertz = Unit(definedBy: DefaultUnits.millihertz)
    static let kilohertz = Unit(definedBy: DefaultUnits.kilohertz)
    static let megahertz = Unit(definedBy: DefaultUnits.megahertz)
    static let gigahertz = Unit(definedBy: DefaultUnits.gigahertz)
    static let terahertz = Unit(definedBy: DefaultUnits.terahertz)

    // MARK: Illuminance

    static let lux = Unit(definedBy: DefaultUnits.lux)
    static let footCandle = Unit(definedBy: DefaultUnits.footCandle)
    static let phot = Unit(definedBy: DefaultUnits.phot)

    // MARK: Inductance

    static let henry = Unit(definedBy: DefaultUnits.henry)

    // MARK: Length

    static let meter = Unit(definedBy: DefaultUnits.meter)
    static let picometer = Unit(definedBy: DefaultUnits.picometer)
    static let nanoometer = Unit(definedBy: DefaultUnits.nanoometer)
    static let micrometer = Unit(definedBy: DefaultUnits.micrometer)
    static let millimeter = Unit(definedBy: DefaultUnits.millimeter)
    static let centimeter = Unit(definedBy: DefaultUnits.centimeter)
    static let decameter = Unit(definedBy: DefaultUnits.decameter)
    static let hectometer = Unit(definedBy: DefaultUnits.hectometer)
    static let kilometer = Unit(definedBy: DefaultUnits.kilometer)
    static let megameter = Unit(definedBy: DefaultUnits.megameter)
    static let inch = Unit(definedBy: DefaultUnits.inch)
    static let foot = Unit(definedBy: DefaultUnits.foot)
    static let yard = Unit(definedBy: DefaultUnits.yard)
    static let mile = Unit(definedBy: DefaultUnits.mile)
    static let scandanavianMile = Unit(definedBy: DefaultUnits.scandanavianMile)
    static let nauticalMile = Unit(definedBy: DefaultUnits.nauticalMile)
    static let fathom = Unit(definedBy: DefaultUnits.fathom)
    static let furlong = Unit(definedBy: DefaultUnits.furlong)
    static let astronomicalUnit = Unit(definedBy: DefaultUnits.astronomicalUnit)
    static let lightyear = Unit(definedBy: DefaultUnits.lightyear)
    static let parsec = Unit(definedBy: DefaultUnits.parsec)

    // MARK: Luminous Intensity

    static let candela = Unit(definedBy: DefaultUnits.candela)

    // MARK: Luminous Flux

    static let lumen = Unit(definedBy: DefaultUnits.lumen)

    // MARK: Magnetic Flux

    static let weber = Unit(definedBy: DefaultUnits.weber)

    // MARK: Magnetic Flux Density

    static let tesla = Unit(definedBy: DefaultUnits.tesla)

    // MARK: Mass

    static let kilogram = Unit(definedBy: DefaultUnits.kilogram)
    static let picogram = Unit(definedBy: DefaultUnits.picogram)
    static let nanogram = Unit(definedBy: DefaultUnits.nanogram)
    static let microgram = Unit(definedBy: DefaultUnits.microgram)
    static let milligram = Unit(definedBy: DefaultUnits.milligram)
    static let centigram = Unit(definedBy: DefaultUnits.centigram)
    static let decigram = Unit(definedBy: DefaultUnits.decigram)
    static let gram = Unit(definedBy: DefaultUnits.gram)
    static let metricTon = Unit(definedBy: DefaultUnits.metricTon)
    static let carat = Unit(definedBy: DefaultUnits.carat)
    static let ounce = Unit(definedBy: DefaultUnits.ounce)
    static let pound = Unit(definedBy: DefaultUnits.pound)
    static let stone = Unit(definedBy: DefaultUnits.stone)
    static let shortTon = Unit(definedBy: DefaultUnits.shortTon)
    static let troyOunces = Unit(definedBy: DefaultUnits.troyOunces)
    static let slug = Unit(definedBy: DefaultUnits.slug)

    // MARK: Power

    static let watt = Unit(definedBy: DefaultUnits.watt)
    static let femptowatt = Unit(definedBy: DefaultUnits.femptowatt)
    static let picowatt = Unit(definedBy: DefaultUnits.picowatt)
    static let nanowatt = Unit(definedBy: DefaultUnits.nanowatt)
    static let microwatt = Unit(definedBy: DefaultUnits.microwatt)
    static let milliwatt = Unit(definedBy: DefaultUnits.milliwatt)
    static let kilowatt = Unit(definedBy: DefaultUnits.kilowatt)
    static let megawatt = Unit(definedBy: DefaultUnits.megawatt)
    static let gigawatt = Unit(definedBy: DefaultUnits.gigawatt)
    static let terawatt = Unit(definedBy: DefaultUnits.terawatt)
    static let horsepower = Unit(definedBy: DefaultUnits.horsepower)
    static let tonRefrigeration = Unit(definedBy: DefaultUnits.tonRefrigeration)

    // MARK: Pressure

    static let pascal = Unit(definedBy: DefaultUnits.pascal)
    static let hectopascal = Unit(definedBy: DefaultUnits.hectopascal)
    static let kilopascal = Unit(definedBy: DefaultUnits.kilopascal)
    static let megapascal = Unit(definedBy: DefaultUnits.megapascal)
    static let gigapascal = Unit(definedBy: DefaultUnits.gigapascal)
    static let bar = Unit(definedBy: DefaultUnits.bar)
    static let millibar = Unit(definedBy: DefaultUnits.millibar)
    static let atmosphere = Unit(definedBy: DefaultUnits.atmosphere)
    static let millimeterOfMercury = Unit(definedBy: DefaultUnits.millimeterOfMercury)
    static let centimeterOfMercury = Unit(definedBy: DefaultUnits.centimeterOfMercury)
    static let inchOfMercury = Unit(definedBy: DefaultUnits.inchOfMercury)
    static let centimeterOfWater = Unit(definedBy: DefaultUnits.centimeterOfWater)
    static let inchOfWater = Unit(definedBy: DefaultUnits.inchOfWater)

    // MARK: Resistance

    static let ohm = Unit(definedBy: DefaultUnits.ohm)
    static let microohm = Unit(definedBy: DefaultUnits.microohm)
    static let milliohm = Unit(definedBy: DefaultUnits.milliohm)
    static let kiloohm = Unit(definedBy: DefaultUnits.kiloohm)
    static let megaohm = Unit(definedBy: DefaultUnits.megaohm)

    // MARK: Solid Angle

    static let steradian = Unit(definedBy: DefaultUnits.steradian)

    // MARK: Temperature

    static let kelvin = Unit(definedBy: DefaultUnits.kelvin)
    static let celsius = Unit(definedBy: DefaultUnits.celsius)
    static let fahrenheit = Unit(definedBy: DefaultUnits.fahrenheit)
    static let rankine = Unit(definedBy: DefaultUnits.rankine)

    // MARK: Time

    static let second = Unit(definedBy: DefaultUnits.second)
    static let nanosecond = Unit(definedBy: DefaultUnits.nanosecond)
    static let microsecond = Unit(definedBy: DefaultUnits.microsecond)
    static let millisecond = Unit(definedBy: DefaultUnits.millisecond)
    static let minute = Unit(definedBy: DefaultUnits.minute)
    static let hour = Unit(definedBy: DefaultUnits.hour)
    static let day = Unit(definedBy: DefaultUnits.day)
    static let week = Unit(definedBy: DefaultUnits.week)
    static let year = Unit(definedBy: DefaultUnits.year)

    // MARK: Velocity

    static let knots = Unit(definedBy: DefaultUnits.knots)

    // MARK: Volume

    static let liter = Unit(definedBy: DefaultUnits.liter)
    static let milliliter = Unit(definedBy: DefaultUnits.milliliter)
    static let centiliter = Unit(definedBy: DefaultUnits.centiliter)
    static let deciliter = Unit(definedBy: DefaultUnits.deciliter)
    static let kiloliter = Unit(definedBy: DefaultUnits.kiloliter)
    static let megaliter = Unit(definedBy: DefaultUnits.megaliter)
    static let teaspoon = Unit(definedBy: DefaultUnits.teaspoon)
    static let tablespoon = Unit(definedBy: DefaultUnits.tablespoon)
    static let fluidOunce = Unit(definedBy: DefaultUnits.fluidOunce)
    static let cup = Unit(definedBy: DefaultUnits.cup)
    static let pint = Unit(definedBy: DefaultUnits.pint)
    static let quart = Unit(definedBy: DefaultUnits.quart)
    static let gallon = Unit(definedBy: DefaultUnits.gallon)
    static let dryPint = Unit(definedBy: DefaultUnits.dryPint)
    static let dryQuart = Unit(definedBy: DefaultUnits.dryQuart)
    static let peck = Unit(definedBy: DefaultUnits.peck)
    static let bushel = Unit(definedBy: DefaultUnits.bushel)
    static let imperialFluidOunce = Unit(definedBy: DefaultUnits.imperialFluidOunce)
    static let imperialCup = Unit(definedBy: DefaultUnits.imperialCup)
    static let imperialPint = Unit(definedBy: DefaultUnits.imperialPint)
    static let imperialQuart = Unit(definedBy: DefaultUnits.imperialQuart)
    static let imperialGallon = Unit(definedBy: DefaultUnits.imperialGallon)
    static let imperialPeck = Unit(definedBy: DefaultUnits.imperialPeck)
    static let metricCup = Unit(definedBy: DefaultUnits.metricCup)
}
