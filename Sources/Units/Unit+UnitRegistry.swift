// TODO: Make more
// - Concentration Mass
// - Dispersion
// - Information Storage: https://developer.apple.com/documentation/foundation/unitinformationstorage

extension Unit {
    // Provided as easy access to UnitRegistry default units
    
    // MARK: Acceleration
    public static let standardGravity = Unit(definedBy: DefinedUnits.standardGravity)
    
    // MARK: Amount
    public static let mole = Unit(definedBy: DefinedUnits.mole)
    public static let millimole = Unit(definedBy: DefinedUnits.millimole)
    public static let particle = Unit(definedBy: DefinedUnits.particle)
    
    // MARK: Angle
    public static let radian = Unit(definedBy: DefinedUnits.radian)
    public static let degree = Unit(definedBy: DefinedUnits.degree)
    
    // MARK: Area
    public static let acre = Unit(definedBy: DefinedUnits.acre)
    public static let are = Unit(definedBy: DefinedUnits.are)
    public static let hectare = Unit(definedBy: DefinedUnits.hectare)
    
    // MARK: Capacitance
    public static let farad = Unit(definedBy: DefinedUnits.farad)
    
    // MARK: Charge
    public static let coulomb = Unit(definedBy: DefinedUnits.coulomb)
    
    // MARK: Current
    public static let ampere = Unit(definedBy: DefinedUnits.ampere)
    public static let microampere = Unit(definedBy: DefinedUnits.microampere)
    public static let milliampere = Unit(definedBy: DefinedUnits.milliampere)
    public static let kiloampere = Unit(definedBy: DefinedUnits.kiloampere)
    public static let megaampere = Unit(definedBy: DefinedUnits.megaampere)
    
    // MARK: Data
    public static let bit = Unit(definedBy: DefinedUnits.bit)
    public static let byte = Unit(definedBy: DefinedUnits.byte)
    public static let kilobyte = Unit(definedBy: DefinedUnits.kilobyte)
    public static let megabyte = Unit(definedBy: DefinedUnits.megabyte)
    public static let gigabyte = Unit(definedBy: DefinedUnits.gigabyte)
    public static let petabyte = Unit(definedBy: DefinedUnits.petabyte)
    
    // MARK: Electric Potential Difference
    public static let volt = Unit(definedBy: DefinedUnits.volt)
    public static let microvolt = Unit(definedBy: DefinedUnits.microvolt)
    public static let millivolt = Unit(definedBy: DefinedUnits.millivolt)
    public static let kilovolt = Unit(definedBy: DefinedUnits.kilovolt)
    public static let megavolt = Unit(definedBy: DefinedUnits.megavolt)
    
    // MARK: Energy
    public static let joule = Unit(definedBy: DefinedUnits.joule)
    public static let kilojoule = Unit(definedBy: DefinedUnits.kilojoule)
    public static let calorie = Unit(definedBy: DefinedUnits.calorie)
    public static let kilocalorie = Unit(definedBy: DefinedUnits.kilocalorie)
    public static let btu = Unit(definedBy: DefinedUnits.btu)
    public static let kilobtu = Unit(definedBy: DefinedUnits.kilobtu)
    public static let megabtu = Unit(definedBy: DefinedUnits.megabtu)
    public static let therm = Unit(definedBy: DefinedUnits.therm)
    public static let electronVolt = Unit(definedBy: DefinedUnits.electronVolt)
    
    // MARK: Force
    public static let newton = Unit(definedBy: DefinedUnits.newton)
    public static let poundForce = Unit(definedBy: DefinedUnits.poundForce)
    
    // MARK: Frequency
    public static let hertz = Unit(definedBy: DefinedUnits.hertz)
    public static let nanohertz = Unit(definedBy: DefinedUnits.nanohertz)
    public static let microhertz = Unit(definedBy: DefinedUnits.microhertz)
    public static let millihertz = Unit(definedBy: DefinedUnits.millihertz)
    public static let kilohertz = Unit(definedBy: DefinedUnits.kilohertz)
    public static let megahertz = Unit(definedBy: DefinedUnits.megahertz)
    public static let gigahertz = Unit(definedBy: DefinedUnits.gigahertz)
    public static let terahertz = Unit(definedBy: DefinedUnits.terahertz)
    
    // MARK: Illuminance
    public static let lux = Unit(definedBy: DefinedUnits.lux)
    public static let footCandle = Unit(definedBy: DefinedUnits.footCandle)
    public static let phot = Unit(definedBy: DefinedUnits.phot)
    
    // MARK: Inductance
    public static let henry = Unit(definedBy: DefinedUnits.henry)
    
    // MARK: Length
    public static let meter = Unit(definedBy: DefinedUnits.meter)
    public static let picometer = Unit(definedBy: DefinedUnits.picometer)
    public static let nanoometer = Unit(definedBy: DefinedUnits.nanoometer)
    public static let micrometer = Unit(definedBy: DefinedUnits.micrometer)
    public static let millimeter = Unit(definedBy: DefinedUnits.millimeter)
    public static let centimeter = Unit(definedBy: DefinedUnits.centimeter)
    public static let decameter = Unit(definedBy: DefinedUnits.decameter)
    public static let hectometer = Unit(definedBy: DefinedUnits.hectometer)
    public static let kilometer = Unit(definedBy: DefinedUnits.kilometer)
    public static let megameter = Unit(definedBy: DefinedUnits.megameter)
    public static let inch = Unit(definedBy: DefinedUnits.inch)
    public static let foot = Unit(definedBy: DefinedUnits.foot)
    public static let yard = Unit(definedBy: DefinedUnits.yard)
    public static let mile = Unit(definedBy: DefinedUnits.mile)
    public static let scandanavianMile = Unit(definedBy: DefinedUnits.scandanavianMile)
    public static let nauticalMile = Unit(definedBy: DefinedUnits.nauticalMile)
    public static let fathom = Unit(definedBy: DefinedUnits.fathom)
    public static let furlong = Unit(definedBy: DefinedUnits.furlong)
    public static let astronomicalUnit = Unit(definedBy: DefinedUnits.astronomicalUnit)
    public static let lightyear = Unit(definedBy: DefinedUnits.lightyear)
    public static let parsec = Unit(definedBy: DefinedUnits.parsec)
    
    // MARK: Luminous Intensity
    public static let candela = Unit(definedBy: DefinedUnits.candela)
    
    // MARK: Magnetic Flux
    public static let weber = Unit(definedBy: DefinedUnits.weber)
    
    // MARK: Magnetic Flux Density
    public static let tesla = Unit(definedBy: DefinedUnits.tesla)
    
    // MARK: Mass
    public static let kilogram = Unit(definedBy: DefinedUnits.kilogram)
    public static let picogram = Unit(definedBy: DefinedUnits.picogram)
    public static let nanogram = Unit(definedBy: DefinedUnits.nanogram)
    public static let microgram = Unit(definedBy: DefinedUnits.microgram)
    public static let milligram = Unit(definedBy: DefinedUnits.milligram)
    public static let centigram = Unit(definedBy: DefinedUnits.centigram)
    public static let decigram = Unit(definedBy: DefinedUnits.decigram)
    public static let gram = Unit(definedBy: DefinedUnits.gram)
    public static let metricTon = Unit(definedBy: DefinedUnits.metricTon)
    public static let carat = Unit(definedBy: DefinedUnits.carat)
    public static let ounce = Unit(definedBy: DefinedUnits.ounce)
    public static let pound = Unit(definedBy: DefinedUnits.pound)
    public static let stone = Unit(definedBy: DefinedUnits.stone)
    public static let shortTon = Unit(definedBy: DefinedUnits.shortTon)
    public static let troyOunces = Unit(definedBy: DefinedUnits.troyOunces)
    public static let slug = Unit(definedBy: DefinedUnits.slug)
    
    // MARK: Power
    public static let watt = Unit(definedBy: DefinedUnits.watt)
    public static let femptowatt = Unit(definedBy: DefinedUnits.femptowatt)
    public static let picowatt = Unit(definedBy: DefinedUnits.picowatt)
    public static let nanowatt = Unit(definedBy: DefinedUnits.nanowatt)
    public static let microwatt = Unit(definedBy: DefinedUnits.microwatt)
    public static let milliwatt = Unit(definedBy: DefinedUnits.milliwatt)
    public static let kilowatt = Unit(definedBy: DefinedUnits.kilowatt)
    public static let megawatt = Unit(definedBy: DefinedUnits.megawatt)
    public static let gigawatt = Unit(definedBy: DefinedUnits.gigawatt)
    public static let terawatt = Unit(definedBy: DefinedUnits.terawatt)
    public static let horsepower = Unit(definedBy: DefinedUnits.horsepower)
    public static let tonRefrigeration = Unit(definedBy: DefinedUnits.tonRefrigeration)
    
    // MARK: Pressure
    public static let pascal = Unit(definedBy: DefinedUnits.pascal)
    public static let hectopascal = Unit(definedBy: DefinedUnits.hectopascal)
    public static let kilopascal = Unit(definedBy: DefinedUnits.kilopascal)
    public static let megapascal = Unit(definedBy: DefinedUnits.megapascal)
    public static let gigapascal = Unit(definedBy: DefinedUnits.gigapascal)
    public static let bar = Unit(definedBy: DefinedUnits.bar)
    public static let millibar = Unit(definedBy: DefinedUnits.millibar)
    public static let atmosphere = Unit(definedBy: DefinedUnits.atmosphere)
    public static let millimeterOfMercury = Unit(definedBy: DefinedUnits.millimeterOfMercury)
    public static let centimeterOfMercury = Unit(definedBy: DefinedUnits.centimeterOfMercury)
    public static let inchOfMercury = Unit(definedBy: DefinedUnits.inchOfMercury)
    public static let centimeterOfWater = Unit(definedBy: DefinedUnits.centimeterOfWater)
    public static let inchOfWater = Unit(definedBy: DefinedUnits.inchOfWater)
    
    // MARK: Resistance
    public static let ohm = Unit(definedBy: DefinedUnits.ohm)
    public static let microohm = Unit(definedBy: DefinedUnits.microohm)
    public static let milliohm = Unit(definedBy: DefinedUnits.milliohm)
    public static let kiloohm = Unit(definedBy: DefinedUnits.kiloohm)
    public static let megaohm = Unit(definedBy: DefinedUnits.megaohm)
    
    // MARK: Solid Angle
    public static let steradian = Unit(definedBy: DefinedUnits.steradian)
    
    // MARK: Temperature
    public static let kelvin = Unit(definedBy: DefinedUnits.kelvin)
    public static let celsius = Unit(definedBy: DefinedUnits.celsius)
    public static let fahrenheit = Unit(definedBy: DefinedUnits.fahrenheit)
    public static let rankine = Unit(definedBy: DefinedUnits.rankine)
    
    // MARK: Time
    public static let second = Unit(definedBy: DefinedUnits.second)
    public static let nanosecond = Unit(definedBy: DefinedUnits.nanosecond)
    public static let microsecond = Unit(definedBy: DefinedUnits.microsecond)
    public static let millisecond = Unit(definedBy: DefinedUnits.millisecond)
    public static let minute = Unit(definedBy: DefinedUnits.minute)
    public static let hour = Unit(definedBy: DefinedUnits.hour)
    
    // MARK: Velocity
    public static let knots = Unit(definedBy: DefinedUnits.knots)
    
    // MARK: Volume
    public static let liter = Unit(definedBy: DefinedUnits.liter)
    public static let milliliter = Unit(definedBy: DefinedUnits.milliliter)
    public static let centiliter = Unit(definedBy: DefinedUnits.centiliter)
    public static let deciliter = Unit(definedBy: DefinedUnits.deciliter)
    public static let kiloliter = Unit(definedBy: DefinedUnits.kiloliter)
    public static let megaliter = Unit(definedBy: DefinedUnits.megaliter)
    public static let bushel = Unit(definedBy: DefinedUnits.bushel)
    public static let teaspoon = Unit(definedBy: DefinedUnits.teaspoon)
    public static let tablespoon = Unit(definedBy: DefinedUnits.tablespoon)
    public static let fluidOunce = Unit(definedBy: DefinedUnits.fluidOunce)
    public static let cup = Unit(definedBy: DefinedUnits.cup)
    public static let pint = Unit(definedBy: DefinedUnits.pint)
    public static let gallon = Unit(definedBy: DefinedUnits.gallon)
    public static let imperialFluidOunce = Unit(definedBy: DefinedUnits.imperialFluidOunce)
    public static let imperialCup = Unit(definedBy: DefinedUnits.imperialCup)
    public static let imperialPint = Unit(definedBy: DefinedUnits.imperialPint)
    public static let imperialGallon = Unit(definedBy: DefinedUnits.imperialGallon)
    public static let metricCup = Unit(definedBy: DefinedUnits.metricCup)
}
