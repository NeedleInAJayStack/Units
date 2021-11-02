// TODO: Make more
// - Concentration Mass
// - Dispersion
// - Information Storage: https://developer.apple.com/documentation/foundation/unitinformationstorage

extension Unit {
    // Provided as easy access to UnitRegistry default units
    // TODO: clean up force-try. Consider moving to UnitRegistry
    
    // MARK: Acceleration
    public static let standardGravity = try! UnitRegistry.instance.fromSymbol("g")
    
    // MARK: Amount
    public static let mole = try! UnitRegistry.instance.fromSymbol("mol")
    public static let millimole = try! UnitRegistry.instance.fromSymbol("mmol")
    public static let particle = try! UnitRegistry.instance.fromSymbol("particle")
    
    // MARK: Angle
    public static let radian = try! UnitRegistry.instance.fromSymbol("rad")
    public static let degree = try! UnitRegistry.instance.fromSymbol("°")
    
    // MARK: Area
    public static let acre = try! UnitRegistry.instance.fromSymbol("ac")
    public static let are = try! UnitRegistry.instance.fromSymbol("a")
    public static let hectare = try! UnitRegistry.instance.fromSymbol("ha")
    
    // MARK: Capacitance
    public static let farad = try! UnitRegistry.instance.fromSymbol("F")
    
    // MARK: Charge
    public static let coulomb = try! UnitRegistry.instance.fromSymbol("C")
    
    // MARK: Current
    public static let ampere = try! UnitRegistry.instance.fromSymbol("A")
    public static let microampere = try! UnitRegistry.instance.fromSymbol("μA")
    public static let milliampere = try! UnitRegistry.instance.fromSymbol("mA")
    public static let kiloampere = try! UnitRegistry.instance.fromSymbol("kA")
    public static let megaampere = try! UnitRegistry.instance.fromSymbol("MA")
    
    // MARK: Data
    public static let bit = try! UnitRegistry.instance.fromSymbol("bit")
    public static let byte = try! UnitRegistry.instance.fromSymbol("byte")
    public static let kilobyte = try! UnitRegistry.instance.fromSymbol("kB")
    public static let megabyte = try! UnitRegistry.instance.fromSymbol("MB")
    public static let gigabyte = try! UnitRegistry.instance.fromSymbol("GB")
    public static let petabyte = try! UnitRegistry.instance.fromSymbol("PB")
    
    // MARK: Electric Potential Difference
    public static let volt = try! UnitRegistry.instance.fromSymbol("V")
    public static let microvolt = try! UnitRegistry.instance.fromSymbol("μV")
    public static let millivolt = try! UnitRegistry.instance.fromSymbol("mV")
    public static let kilovolt = try! UnitRegistry.instance.fromSymbol("kV")
    public static let megavolt = try! UnitRegistry.instance.fromSymbol("MV")
    
    // MARK: Energy
    public static let joule = try! UnitRegistry.instance.fromSymbol("J")
    public static let kilojoule = try! UnitRegistry.instance.fromSymbol("kJ")
    public static let calorie = try! UnitRegistry.instance.fromSymbol("cal")
    public static let kilocalorie = try! UnitRegistry.instance.fromSymbol("kCal")
    public static let btu = try! UnitRegistry.instance.fromSymbol("BTU")
    public static let kilobtu = try! UnitRegistry.instance.fromSymbol("kBTU")
    public static let megabtu = try! UnitRegistry.instance.fromSymbol("MBTU")
    public static let therm = try! UnitRegistry.instance.fromSymbol("therm")
    public static let electronVolt = try! UnitRegistry.instance.fromSymbol("eV")
    
    // MARK: Force
    public static let newton = try! UnitRegistry.instance.fromSymbol("N")
    public static let poundForce = try! UnitRegistry.instance.fromSymbol("lbf")
    
    // MARK: Frequency
    public static let hertz = try! UnitRegistry.instance.fromSymbol("Hz")
    public static let nanohertz = try! UnitRegistry.instance.fromSymbol("nHz")
    public static let microhertz = try! UnitRegistry.instance.fromSymbol("μHz")
    public static let millihertz = try! UnitRegistry.instance.fromSymbol("mHz")
    public static let kilohertz = try! UnitRegistry.instance.fromSymbol("mHz")
    public static let megahertz = try! UnitRegistry.instance.fromSymbol("MHz")
    public static let gigahertz = try! UnitRegistry.instance.fromSymbol("GHz")
    public static let terahertz = try! UnitRegistry.instance.fromSymbol("THz")
    
    // MARK: Illuminance
    public static let lux = try! UnitRegistry.instance.fromSymbol("lx")
    public static let footCandle = try! UnitRegistry.instance.fromSymbol("fc")
    public static let phot = try! UnitRegistry.instance.fromSymbol("phot")
    
    // MARK: Inductance
    public static let henry = try! UnitRegistry.instance.fromSymbol("H")
    
    // MARK: Length
    public static let meter = try! UnitRegistry.instance.fromSymbol("m")
    public static let picometer = try! UnitRegistry.instance.fromSymbol("pm")
    public static let nanoometer = try! UnitRegistry.instance.fromSymbol("nm")
    public static let micrometer = try! UnitRegistry.instance.fromSymbol("μm")
    public static let millimeter = try! UnitRegistry.instance.fromSymbol("mm")
    public static let centimeter = try! UnitRegistry.instance.fromSymbol("cm")
    public static let decameter = try! UnitRegistry.instance.fromSymbol("dm")
    public static let hectometer = try! UnitRegistry.instance.fromSymbol("hm")
    public static let kilometer = try! UnitRegistry.instance.fromSymbol("km")
    public static let megameter = try! UnitRegistry.instance.fromSymbol("Mm")
    public static let inch = try! UnitRegistry.instance.fromSymbol("in")
    public static let foot = try! UnitRegistry.instance.fromSymbol("ft")
    public static let yard = try! UnitRegistry.instance.fromSymbol("yd")
    public static let mile = try! UnitRegistry.instance.fromSymbol("mi")
    public static let scandanavianMile = try! UnitRegistry.instance.fromSymbol("smi")
    public static let nauticalMile = try! UnitRegistry.instance.fromSymbol("NM")
    public static let fathom = try! UnitRegistry.instance.fromSymbol("fathom")
    public static let furlong = try! UnitRegistry.instance.fromSymbol("furlong")
    public static let astronomicalUnit = try! UnitRegistry.instance.fromSymbol("au")
    public static let lightyear = try! UnitRegistry.instance.fromSymbol("ly")
    public static let parsec = try! UnitRegistry.instance.fromSymbol("pc")
    
    // MARK: Luminous Intensity
    public static let candela = try! UnitRegistry.instance.fromSymbol("cd")
    
    // MARK: Magnetic Flux
    public static let weber = try! UnitRegistry.instance.fromSymbol("Wb")
    
    // MARK: Magnetic Flux Density
    public static let tesla = try! UnitRegistry.instance.fromSymbol("T")
    
    // MARK: Mass
    public static let kilogram = try! UnitRegistry.instance.fromSymbol("kg")
    public static let picogram = try! UnitRegistry.instance.fromSymbol("pg")
    public static let nanogram = try! UnitRegistry.instance.fromSymbol("ng")
    public static let microgram = try! UnitRegistry.instance.fromSymbol("μg")
    public static let milligram = try! UnitRegistry.instance.fromSymbol("mg")
    public static let centigram = try! UnitRegistry.instance.fromSymbol("cg")
    public static let decigram = try! UnitRegistry.instance.fromSymbol("dg")
    public static let gram = try! UnitRegistry.instance.fromSymbol("g")
    public static let metricTon = try! UnitRegistry.instance.fromSymbol("t")
    public static let carat = try! UnitRegistry.instance.fromSymbol("ct")
    public static let ounce = try! UnitRegistry.instance.fromSymbol("oz")
    public static let pound = try! UnitRegistry.instance.fromSymbol("lb")
    public static let stone = try! UnitRegistry.instance.fromSymbol("st")
    public static let shortTon = try! UnitRegistry.instance.fromSymbol("ton")
    public static let troyOunces = try! UnitRegistry.instance.fromSymbol("troyOunces")
    public static let slug = try! UnitRegistry.instance.fromSymbol("slug")
    
    // MARK: Power
    public static let watt = try! UnitRegistry.instance.fromSymbol("W")
    public static let femptowatt = try! UnitRegistry.instance.fromSymbol("fW")
    public static let picowatt = try! UnitRegistry.instance.fromSymbol("pW")
    public static let nanowatt = try! UnitRegistry.instance.fromSymbol("nW")
    public static let microwatt = try! UnitRegistry.instance.fromSymbol("μW")
    public static let milliwatt = try! UnitRegistry.instance.fromSymbol("mW")
    public static let kilowatt = try! UnitRegistry.instance.fromSymbol("kW")
    public static let megawatt = try! UnitRegistry.instance.fromSymbol("MW")
    public static let gigawatt = try! UnitRegistry.instance.fromSymbol("GW")
    public static let terawatt = try! UnitRegistry.instance.fromSymbol("TW")
    public static let horsepower = try! UnitRegistry.instance.fromSymbol("hp")
    public static let tonRefrigeration = try! UnitRegistry.instance.fromSymbol("TR")
    
    // MARK: Pressure
    public static let pascal = try! UnitRegistry.instance.fromSymbol("Pa")
    public static let hectopascal = try! UnitRegistry.instance.fromSymbol("hPa")
    public static let kilopascal = try! UnitRegistry.instance.fromSymbol("kPa")
    public static let megapascal = try! UnitRegistry.instance.fromSymbol("MPa")
    public static let gigapascal = try! UnitRegistry.instance.fromSymbol("GPa")
    public static let bar = try! UnitRegistry.instance.fromSymbol("bar")
    public static let millibar = try! UnitRegistry.instance.fromSymbol("mbar")
    public static let atmosphere = try! UnitRegistry.instance.fromSymbol("atm")
    public static let millimeterOfMercury = try! UnitRegistry.instance.fromSymbol("mmhg")
    public static let centimeterOfMercury = try! UnitRegistry.instance.fromSymbol("cmhg")
    public static let inchOfMercury = try! UnitRegistry.instance.fromSymbol("inhg")
    public static let centimeterOfWater = try! UnitRegistry.instance.fromSymbol("mmH₂0")
    public static let inchOfWater = try! UnitRegistry.instance.fromSymbol("inH₂0")
    
    // MARK: Resistance
    public static let ohm = try! UnitRegistry.instance.fromSymbol("Ω")
    public static let microohm = try! UnitRegistry.instance.fromSymbol("μΩ")
    public static let milliohm = try! UnitRegistry.instance.fromSymbol("mΩ")
    public static let kiloohm = try! UnitRegistry.instance.fromSymbol("kΩ")
    public static let megaohm = try! UnitRegistry.instance.fromSymbol("MΩ")
    
    // MARK: Solid Angle
    public static let steradian = try! UnitRegistry.instance.fromSymbol("sr")
    
    // MARK: Temperature
    public static let kelvin = try! UnitRegistry.instance.fromSymbol("K")
    public static let celsius = try! UnitRegistry.instance.fromSymbol("°C")
    public static let fahrenheit = try! UnitRegistry.instance.fromSymbol("°F")
    public static let rankine = try! UnitRegistry.instance.fromSymbol("°R")
    
    // MARK: Time
    public static let second = try! UnitRegistry.instance.fromSymbol("s")
    public static let nanosecond = try! UnitRegistry.instance.fromSymbol("ns")
    public static let microsecond = try! UnitRegistry.instance.fromSymbol("μs")
    public static let millisecond = try! UnitRegistry.instance.fromSymbol("ms")
    public static let minute = try! UnitRegistry.instance.fromSymbol("min")
    public static let hour = try! UnitRegistry.instance.fromSymbol("hr")
    
    // MARK: Velocity
    public static let knots = try! UnitRegistry.instance.fromSymbol("knot")
    
    // MARK: Volume
    public static let liter = try! UnitRegistry.instance.fromSymbol("L")
    public static let milliliter = try! UnitRegistry.instance.fromSymbol("mL")
    public static let centiliter = try! UnitRegistry.instance.fromSymbol("cL")
    public static let deciliter = try! UnitRegistry.instance.fromSymbol("dL")
    public static let kiloliter = try! UnitRegistry.instance.fromSymbol("kL")
    public static let megaliter = try! UnitRegistry.instance.fromSymbol("ML")
    public static let bushel = try! UnitRegistry.instance.fromSymbol("bushel")
    public static let teaspoon = try! UnitRegistry.instance.fromSymbol("tsp")
    public static let tablespoon = try! UnitRegistry.instance.fromSymbol("tbsp")
    public static let fluidOunce = try! UnitRegistry.instance.fromSymbol("fl_oz")
    public static let cup = try! UnitRegistry.instance.fromSymbol("cup")
    public static let pint = try! UnitRegistry.instance.fromSymbol("pt")
    public static let gallon = try! UnitRegistry.instance.fromSymbol("gal")
    public static let imperialFluidOunce = try! UnitRegistry.instance.fromSymbol("ifl_oz")
    public static let imperialCup = try! UnitRegistry.instance.fromSymbol("icup")
    public static let imperialPint = try! UnitRegistry.instance.fromSymbol("ipt")
    public static let imperialGallon = try! UnitRegistry.instance.fromSymbol("igal")
    public static let metricCup = try! UnitRegistry.instance.fromSymbol("mcup")
}
