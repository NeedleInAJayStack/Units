// TODO: Make more
// - Concentration Mass
// - Dispersion
// - Information Storage: https://developer.apple.com/documentation/foundation/unitinformationstorage

extension Unit {
    // Provided as easy access to UnitRegistry default units
    
    // MARK: Acceleration
    public static let standardGravity = Unit(definedBy: DefaultUnits.standardGravity)
    
    // MARK: Amount
    public static let mole = Unit(definedBy: DefaultUnits.mole)
    public static let millimole = Unit(definedBy: DefaultUnits.millimole)
    public static let particle = Unit(definedBy: DefaultUnits.particle)
    
    // MARK: Angle
    public static let radian = Unit(definedBy: DefaultUnits.radian)
    public static let degree = Unit(definedBy: DefaultUnits.degree)
    
    // MARK: Area
    public static let acre = Unit(definedBy: DefaultUnits.acre)
    public static let are = Unit(definedBy: DefaultUnits.are)
    public static let hectare = Unit(definedBy: DefaultUnits.hectare)
    
    // MARK: Capacitance
    public static let farad = Unit(definedBy: DefaultUnits.farad)
    
    // MARK: Charge
    public static let coulomb = Unit(definedBy: DefaultUnits.coulomb)
    
    // MARK: Current
    public static let ampere = Unit(definedBy: DefaultUnits.ampere)
    public static let microampere = Unit(definedBy: DefaultUnits.microampere)
    public static let milliampere = Unit(definedBy: DefaultUnits.milliampere)
    public static let kiloampere = Unit(definedBy: DefaultUnits.kiloampere)
    public static let megaampere = Unit(definedBy: DefaultUnits.megaampere)
    
    // MARK: Data
    public static let bit = Unit(definedBy: DefaultUnits.bit)
    public static let byte = Unit(definedBy: DefaultUnits.byte)
    public static let kilobyte = Unit(definedBy: DefaultUnits.kilobyte)
    public static let megabyte = Unit(definedBy: DefaultUnits.megabyte)
    public static let gigabyte = Unit(definedBy: DefaultUnits.gigabyte)
    public static let petabyte = Unit(definedBy: DefaultUnits.petabyte)
    
    // MARK: Electric Potential Difference
    public static let volt = Unit(definedBy: DefaultUnits.volt)
    public static let microvolt = Unit(definedBy: DefaultUnits.microvolt)
    public static let millivolt = Unit(definedBy: DefaultUnits.millivolt)
    public static let kilovolt = Unit(definedBy: DefaultUnits.kilovolt)
    public static let megavolt = Unit(definedBy: DefaultUnits.megavolt)
    
    // MARK: Energy
    public static let joule = Unit(definedBy: DefaultUnits.joule)
    public static let kilojoule = Unit(definedBy: DefaultUnits.kilojoule)
    public static let calorie = Unit(definedBy: DefaultUnits.calorie)
    public static let kilocalorie = Unit(definedBy: DefaultUnits.kilocalorie)
    public static let btu = Unit(definedBy: DefaultUnits.btu)
    public static let kilobtu = Unit(definedBy: DefaultUnits.kilobtu)
    public static let megabtu = Unit(definedBy: DefaultUnits.megabtu)
    public static let therm = Unit(definedBy: DefaultUnits.therm)
    public static let electronVolt = Unit(definedBy: DefaultUnits.electronVolt)
    
    // MARK: Force
    public static let newton = Unit(definedBy: DefaultUnits.newton)
    public static let poundForce = Unit(definedBy: DefaultUnits.poundForce)
    
    // MARK: Frequency
    public static let hertz = Unit(definedBy: DefaultUnits.hertz)
    public static let nanohertz = Unit(definedBy: DefaultUnits.nanohertz)
    public static let microhertz = Unit(definedBy: DefaultUnits.microhertz)
    public static let millihertz = Unit(definedBy: DefaultUnits.millihertz)
    public static let kilohertz = Unit(definedBy: DefaultUnits.kilohertz)
    public static let megahertz = Unit(definedBy: DefaultUnits.megahertz)
    public static let gigahertz = Unit(definedBy: DefaultUnits.gigahertz)
    public static let terahertz = Unit(definedBy: DefaultUnits.terahertz)
    
    // MARK: Illuminance
    public static let lux = Unit(definedBy: DefaultUnits.lux)
    public static let footCandle = Unit(definedBy: DefaultUnits.footCandle)
    public static let phot = Unit(definedBy: DefaultUnits.phot)
    
    // MARK: Inductance
    public static let henry = Unit(definedBy: DefaultUnits.henry)
    
    // MARK: Length
    public static let meter = Unit(definedBy: DefaultUnits.meter)
    public static let picometer = Unit(definedBy: DefaultUnits.picometer)
    public static let nanoometer = Unit(definedBy: DefaultUnits.nanoometer)
    public static let micrometer = Unit(definedBy: DefaultUnits.micrometer)
    public static let millimeter = Unit(definedBy: DefaultUnits.millimeter)
    public static let centimeter = Unit(definedBy: DefaultUnits.centimeter)
    public static let decameter = Unit(definedBy: DefaultUnits.decameter)
    public static let hectometer = Unit(definedBy: DefaultUnits.hectometer)
    public static let kilometer = Unit(definedBy: DefaultUnits.kilometer)
    public static let megameter = Unit(definedBy: DefaultUnits.megameter)
    public static let inch = Unit(definedBy: DefaultUnits.inch)
    public static let foot = Unit(definedBy: DefaultUnits.foot)
    public static let yard = Unit(definedBy: DefaultUnits.yard)
    public static let mile = Unit(definedBy: DefaultUnits.mile)
    public static let scandanavianMile = Unit(definedBy: DefaultUnits.scandanavianMile)
    public static let nauticalMile = Unit(definedBy: DefaultUnits.nauticalMile)
    public static let fathom = Unit(definedBy: DefaultUnits.fathom)
    public static let furlong = Unit(definedBy: DefaultUnits.furlong)
    public static let astronomicalUnit = Unit(definedBy: DefaultUnits.astronomicalUnit)
    public static let lightyear = Unit(definedBy: DefaultUnits.lightyear)
    public static let parsec = Unit(definedBy: DefaultUnits.parsec)
    
    // MARK: Luminous Intensity
    public static let candela = Unit(definedBy: DefaultUnits.candela)
    
    // MARK: Magnetic Flux
    public static let weber = Unit(definedBy: DefaultUnits.weber)
    
    // MARK: Magnetic Flux Density
    public static let tesla = Unit(definedBy: DefaultUnits.tesla)
    
    // MARK: Mass
    public static let kilogram = Unit(definedBy: DefaultUnits.kilogram)
    public static let picogram = Unit(definedBy: DefaultUnits.picogram)
    public static let nanogram = Unit(definedBy: DefaultUnits.nanogram)
    public static let microgram = Unit(definedBy: DefaultUnits.microgram)
    public static let milligram = Unit(definedBy: DefaultUnits.milligram)
    public static let centigram = Unit(definedBy: DefaultUnits.centigram)
    public static let decigram = Unit(definedBy: DefaultUnits.decigram)
    public static let gram = Unit(definedBy: DefaultUnits.gram)
    public static let metricTon = Unit(definedBy: DefaultUnits.metricTon)
    public static let carat = Unit(definedBy: DefaultUnits.carat)
    public static let ounce = Unit(definedBy: DefaultUnits.ounce)
    public static let pound = Unit(definedBy: DefaultUnits.pound)
    public static let stone = Unit(definedBy: DefaultUnits.stone)
    public static let shortTon = Unit(definedBy: DefaultUnits.shortTon)
    public static let troyOunces = Unit(definedBy: DefaultUnits.troyOunces)
    public static let slug = Unit(definedBy: DefaultUnits.slug)
    
    // MARK: Power
    public static let watt = Unit(definedBy: DefaultUnits.watt)
    public static let femptowatt = Unit(definedBy: DefaultUnits.femptowatt)
    public static let picowatt = Unit(definedBy: DefaultUnits.picowatt)
    public static let nanowatt = Unit(definedBy: DefaultUnits.nanowatt)
    public static let microwatt = Unit(definedBy: DefaultUnits.microwatt)
    public static let milliwatt = Unit(definedBy: DefaultUnits.milliwatt)
    public static let kilowatt = Unit(definedBy: DefaultUnits.kilowatt)
    public static let megawatt = Unit(definedBy: DefaultUnits.megawatt)
    public static let gigawatt = Unit(definedBy: DefaultUnits.gigawatt)
    public static let terawatt = Unit(definedBy: DefaultUnits.terawatt)
    public static let horsepower = Unit(definedBy: DefaultUnits.horsepower)
    public static let tonRefrigeration = Unit(definedBy: DefaultUnits.tonRefrigeration)
    
    // MARK: Pressure
    public static let pascal = Unit(definedBy: DefaultUnits.pascal)
    public static let hectopascal = Unit(definedBy: DefaultUnits.hectopascal)
    public static let kilopascal = Unit(definedBy: DefaultUnits.kilopascal)
    public static let megapascal = Unit(definedBy: DefaultUnits.megapascal)
    public static let gigapascal = Unit(definedBy: DefaultUnits.gigapascal)
    public static let bar = Unit(definedBy: DefaultUnits.bar)
    public static let millibar = Unit(definedBy: DefaultUnits.millibar)
    public static let atmosphere = Unit(definedBy: DefaultUnits.atmosphere)
    public static let millimeterOfMercury = Unit(definedBy: DefaultUnits.millimeterOfMercury)
    public static let centimeterOfMercury = Unit(definedBy: DefaultUnits.centimeterOfMercury)
    public static let inchOfMercury = Unit(definedBy: DefaultUnits.inchOfMercury)
    public static let centimeterOfWater = Unit(definedBy: DefaultUnits.centimeterOfWater)
    public static let inchOfWater = Unit(definedBy: DefaultUnits.inchOfWater)
    
    // MARK: Resistance
    public static let ohm = Unit(definedBy: DefaultUnits.ohm)
    public static let microohm = Unit(definedBy: DefaultUnits.microohm)
    public static let milliohm = Unit(definedBy: DefaultUnits.milliohm)
    public static let kiloohm = Unit(definedBy: DefaultUnits.kiloohm)
    public static let megaohm = Unit(definedBy: DefaultUnits.megaohm)
    
    // MARK: Solid Angle
    public static let steradian = Unit(definedBy: DefaultUnits.steradian)
    
    // MARK: Temperature
    public static let kelvin = Unit(definedBy: DefaultUnits.kelvin)
    public static let celsius = Unit(definedBy: DefaultUnits.celsius)
    public static let fahrenheit = Unit(definedBy: DefaultUnits.fahrenheit)
    public static let rankine = Unit(definedBy: DefaultUnits.rankine)
    
    // MARK: Time
    public static let second = Unit(definedBy: DefaultUnits.second)
    public static let nanosecond = Unit(definedBy: DefaultUnits.nanosecond)
    public static let microsecond = Unit(definedBy: DefaultUnits.microsecond)
    public static let millisecond = Unit(definedBy: DefaultUnits.millisecond)
    public static let minute = Unit(definedBy: DefaultUnits.minute)
    public static let hour = Unit(definedBy: DefaultUnits.hour)
    
    // MARK: Velocity
    public static let knots = Unit(definedBy: DefaultUnits.knots)
    
    // MARK: Volume
    public static let liter = Unit(definedBy: DefaultUnits.liter)
    public static let milliliter = Unit(definedBy: DefaultUnits.milliliter)
    public static let centiliter = Unit(definedBy: DefaultUnits.centiliter)
    public static let deciliter = Unit(definedBy: DefaultUnits.deciliter)
    public static let kiloliter = Unit(definedBy: DefaultUnits.kiloliter)
    public static let megaliter = Unit(definedBy: DefaultUnits.megaliter)
    public static let bushel = Unit(definedBy: DefaultUnits.bushel)
    public static let teaspoon = Unit(definedBy: DefaultUnits.teaspoon)
    public static let tablespoon = Unit(definedBy: DefaultUnits.tablespoon)
    public static let fluidOunce = Unit(definedBy: DefaultUnits.fluidOunce)
    public static let cup = Unit(definedBy: DefaultUnits.cup)
    public static let pint = Unit(definedBy: DefaultUnits.pint)
    public static let gallon = Unit(definedBy: DefaultUnits.gallon)
    public static let imperialFluidOunce = Unit(definedBy: DefaultUnits.imperialFluidOunce)
    public static let imperialCup = Unit(definedBy: DefaultUnits.imperialCup)
    public static let imperialPint = Unit(definedBy: DefaultUnits.imperialPint)
    public static let imperialGallon = Unit(definedBy: DefaultUnits.imperialGallon)
    public static let metricCup = Unit(definedBy: DefaultUnits.metricCup)
}
