// TODO: Make more
// - Concentration Mass
// - Dispersion
// - Information Storage: https://developer.apple.com/documentation/foundation/unitinformationstorage

extension Unit {
    // Provided as easy access to UnitRegistry default units
    // TODO: clean up force-try. Consider moving to UnitRegistry
    
    // MARK: Acceleration
    public static var gravitationalAcceleration = try! UnitRegistry.instance.fromSymbol("g")
    
    // MARK: Amount
    public static var mole = try! UnitRegistry.instance.fromSymbol("mol")
    public static var millimole = try! UnitRegistry.instance.fromSymbol("mmol")
    public static var particle = try! UnitRegistry.instance.fromSymbol("particle")
    
    // MARK: Angle
    public static var radian = try! UnitRegistry.instance.fromSymbol("rad")
    public static var degree = try! UnitRegistry.instance.fromSymbol("°")
    
    // MARK: Area
    public static var acre = try! UnitRegistry.instance.fromSymbol("ac")
    public static var are = try! UnitRegistry.instance.fromSymbol("a")
    public static var hectare = try! UnitRegistry.instance.fromSymbol("ha")
    
    // MARK: Capacitance
    public static var farad = try! UnitRegistry.instance.fromSymbol("F")
    
    // MARK: Charge
    public static var coulomb = try! UnitRegistry.instance.fromSymbol("C")
    
    // MARK: Current
    public static var ampere = try! UnitRegistry.instance.fromSymbol("A")
    public static var microampere = try! UnitRegistry.instance.fromSymbol("μA")
    public static var milliampere = try! UnitRegistry.instance.fromSymbol("mA")
    public static var kiloampere = try! UnitRegistry.instance.fromSymbol("kA")
    public static var megaampere = try! UnitRegistry.instance.fromSymbol("MA")
    
    // MARK: Data
    public static var bit = try! UnitRegistry.instance.fromSymbol("bit")
    public static var byte = try! UnitRegistry.instance.fromSymbol("byte")
    public static var kilobyte = try! UnitRegistry.instance.fromSymbol("kB")
    public static var megabyte = try! UnitRegistry.instance.fromSymbol("MB")
    public static var gigabyte = try! UnitRegistry.instance.fromSymbol("GB")
    public static var petabyte = try! UnitRegistry.instance.fromSymbol("PB")
    
    // MARK: Electric Potential Difference
    public static var volt = try! UnitRegistry.instance.fromSymbol("V")
    public static var microvolt = try! UnitRegistry.instance.fromSymbol("μV")
    public static var millivolt = try! UnitRegistry.instance.fromSymbol("mV")
    public static var kilovolt = try! UnitRegistry.instance.fromSymbol("kV")
    public static var megavolt = try! UnitRegistry.instance.fromSymbol("MV")
    
    // MARK: Energy
    public static var joule = try! UnitRegistry.instance.fromSymbol("J")
    public static var kilojoule = try! UnitRegistry.instance.fromSymbol("kJ")
    public static var calorie = try! UnitRegistry.instance.fromSymbol("cal")
    public static var kilocalorie = try! UnitRegistry.instance.fromSymbol("kCal")
    public static var btu = try! UnitRegistry.instance.fromSymbol("BTU")
    public static var kilobtu = try! UnitRegistry.instance.fromSymbol("kBTU")
    public static var megabtu = try! UnitRegistry.instance.fromSymbol("MBTU")
    public static var therm = try! UnitRegistry.instance.fromSymbol("therm")
    public static var electronVolt = try! UnitRegistry.instance.fromSymbol("eV")
    
    // MARK: Force
    public static var newton = try! UnitRegistry.instance.fromSymbol("N")
    public static var poundForce = try! UnitRegistry.instance.fromSymbol("lbf")
    
    // MARK: Frequency
    public static var hertz = try! UnitRegistry.instance.fromSymbol("Hz")
    public static var nanohertz = try! UnitRegistry.instance.fromSymbol("nHz")
    public static var microhertz = try! UnitRegistry.instance.fromSymbol("μHz")
    public static var millihertz = try! UnitRegistry.instance.fromSymbol("mHz")
    public static var kilohertz = try! UnitRegistry.instance.fromSymbol("mHz")
    public static var megahertz = try! UnitRegistry.instance.fromSymbol("MHz")
    public static var gigahertz = try! UnitRegistry.instance.fromSymbol("GHz")
    public static var terahertz = try! UnitRegistry.instance.fromSymbol("THz")
    
    // MARK: Illuminance
    public static var lux = try! UnitRegistry.instance.fromSymbol("lx")
    public static var footCandle = try! UnitRegistry.instance.fromSymbol("fc")
    public static var phot = try! UnitRegistry.instance.fromSymbol("phot")
    
    // MARK: Inductance
    public static var henry = try! UnitRegistry.instance.fromSymbol("H")
    
    // MARK: Length
    public static var meter = try! UnitRegistry.instance.fromSymbol("m")
    public static var picometer = try! UnitRegistry.instance.fromSymbol("pm")
    public static var nanoometer = try! UnitRegistry.instance.fromSymbol("nm")
    public static var micrometer = try! UnitRegistry.instance.fromSymbol("μm")
    public static var millimeter = try! UnitRegistry.instance.fromSymbol("mm")
    public static var centimeter = try! UnitRegistry.instance.fromSymbol("cm")
    public static var decameter = try! UnitRegistry.instance.fromSymbol("dm")
    public static var hectometer = try! UnitRegistry.instance.fromSymbol("hm")
    public static var kilometer = try! UnitRegistry.instance.fromSymbol("km")
    public static var megameter = try! UnitRegistry.instance.fromSymbol("Mm")
    public static var inch = try! UnitRegistry.instance.fromSymbol("in")
    public static var foot = try! UnitRegistry.instance.fromSymbol("ft")
    public static var yard = try! UnitRegistry.instance.fromSymbol("yd")
    public static var mile = try! UnitRegistry.instance.fromSymbol("mi")
    public static var scandanavianMile = try! UnitRegistry.instance.fromSymbol("smi")
    public static var nauticalMile = try! UnitRegistry.instance.fromSymbol("NM")
    public static var fathom = try! UnitRegistry.instance.fromSymbol("fathom")
    public static var furlong = try! UnitRegistry.instance.fromSymbol("furlong")
    public static var astronomicalUnit = try! UnitRegistry.instance.fromSymbol("au")
    public static var lightyear = try! UnitRegistry.instance.fromSymbol("ly")
    public static var parsec = try! UnitRegistry.instance.fromSymbol("pc")
    
    // MARK: Luminous Intensity
    public static var candela = try! UnitRegistry.instance.fromSymbol("cd")
    
    // MARK: Magnetic Flux
    public static var weber = try! UnitRegistry.instance.fromSymbol("Wb")
    
    // MARK: Magnetic Flux Density
    public static var tesla = try! UnitRegistry.instance.fromSymbol("T")
    
    // MARK: Mass
    public static var kilogram = try! UnitRegistry.instance.fromSymbol("kg")
    public static var picogram = try! UnitRegistry.instance.fromSymbol("pg")
    public static var nanogram = try! UnitRegistry.instance.fromSymbol("ng")
    public static var microgram = try! UnitRegistry.instance.fromSymbol("μg")
    public static var milligram = try! UnitRegistry.instance.fromSymbol("mg")
    public static var centigram = try! UnitRegistry.instance.fromSymbol("cg")
    public static var decigram = try! UnitRegistry.instance.fromSymbol("dg")
    public static var gram = try! UnitRegistry.instance.fromSymbol("g")
    public static var metricTon = try! UnitRegistry.instance.fromSymbol("t")
    public static var carat = try! UnitRegistry.instance.fromSymbol("ct")
    public static var ounce = try! UnitRegistry.instance.fromSymbol("oz")
    public static var pound = try! UnitRegistry.instance.fromSymbol("lb")
    public static var stone = try! UnitRegistry.instance.fromSymbol("st")
    public static var shortTon = try! UnitRegistry.instance.fromSymbol("ton")
    public static var troyOunces = try! UnitRegistry.instance.fromSymbol("troyOunces")
    public static var slug = try! UnitRegistry.instance.fromSymbol("slug")
    
    // MARK: Power
    public static var watt = try! UnitRegistry.instance.fromSymbol("W")
    public static var femptowatt = try! UnitRegistry.instance.fromSymbol("fW")
    public static var picowatt = try! UnitRegistry.instance.fromSymbol("pW")
    public static var nanowatt = try! UnitRegistry.instance.fromSymbol("nW")
    public static var microwatt = try! UnitRegistry.instance.fromSymbol("μW")
    public static var milliwatt = try! UnitRegistry.instance.fromSymbol("mW")
    public static var kilowatt = try! UnitRegistry.instance.fromSymbol("kW")
    public static var megawatt = try! UnitRegistry.instance.fromSymbol("MW")
    public static var gigawatt = try! UnitRegistry.instance.fromSymbol("GW")
    public static var terawatt = try! UnitRegistry.instance.fromSymbol("TW")
    public static var horsepower = try! UnitRegistry.instance.fromSymbol("hp")
    public static var tonRefrigeration = try! UnitRegistry.instance.fromSymbol("TR")
    
    // MARK: Pressure
    public static var pascal = try! UnitRegistry.instance.fromSymbol("Pa")
    public static var hectopascal = try! UnitRegistry.instance.fromSymbol("hPa")
    public static var kilopascal = try! UnitRegistry.instance.fromSymbol("kPa")
    public static var megapascal = try! UnitRegistry.instance.fromSymbol("MPa")
    public static var gigapascal = try! UnitRegistry.instance.fromSymbol("GPa")
    public static var bar = try! UnitRegistry.instance.fromSymbol("bar")
    public static var millibar = try! UnitRegistry.instance.fromSymbol("mbar")
    public static var atmosphere = try! UnitRegistry.instance.fromSymbol("atm")
    public static var millimeterOfMercury = try! UnitRegistry.instance.fromSymbol("mmhg")
    public static var centimeterOfMercury = try! UnitRegistry.instance.fromSymbol("cmhg")
    public static var inchOfMercury = try! UnitRegistry.instance.fromSymbol("inhg")
    public static var centimeterOfWater = try! UnitRegistry.instance.fromSymbol("mmH₂0")
    public static var inchOfWater = try! UnitRegistry.instance.fromSymbol("inH₂0")
    
    // MARK: Resistance
    public static var ohm = try! UnitRegistry.instance.fromSymbol("Ω")
    public static var microohm = try! UnitRegistry.instance.fromSymbol("μΩ")
    public static var milliohm = try! UnitRegistry.instance.fromSymbol("mΩ")
    public static var kiloohm = try! UnitRegistry.instance.fromSymbol("kΩ")
    public static var megaohm = try! UnitRegistry.instance.fromSymbol("MΩ")
    
    // MARK: Solid Angle
    public static var steradian = try! UnitRegistry.instance.fromSymbol("sr")
    
    // MARK: Temperature
    public static var kelvin = try! UnitRegistry.instance.fromSymbol("K")
    public static var celsius = try! UnitRegistry.instance.fromSymbol("°C")
    public static var fahrenheit = try! UnitRegistry.instance.fromSymbol("°F")
    public static var rankine = try! UnitRegistry.instance.fromSymbol("°R")
    
    // MARK: Time
    public static var second = try! UnitRegistry.instance.fromSymbol("s")
    public static var nanosecond = try! UnitRegistry.instance.fromSymbol("ns")
    public static var microsecond = try! UnitRegistry.instance.fromSymbol("μs")
    public static var millisecond = try! UnitRegistry.instance.fromSymbol("ms")
    public static var minute = try! UnitRegistry.instance.fromSymbol("min")
    public static var hour = try! UnitRegistry.instance.fromSymbol("hr")
    
    // MARK: Velocity
    public static var knots = try! UnitRegistry.instance.fromSymbol("knot")
    
    // MARK: Volume
    public static var liter = try! UnitRegistry.instance.fromSymbol("L")
    public static var milliliter = try! UnitRegistry.instance.fromSymbol("mL")
    public static var centiliter = try! UnitRegistry.instance.fromSymbol("cL")
    public static var deciliter = try! UnitRegistry.instance.fromSymbol("dL")
    public static var kiloliter = try! UnitRegistry.instance.fromSymbol("kL")
    public static var megaliter = try! UnitRegistry.instance.fromSymbol("ML")
    public static var bushel = try! UnitRegistry.instance.fromSymbol("bushel")
    public static var teaspoon = try! UnitRegistry.instance.fromSymbol("tsp")
    public static var tablespoon = try! UnitRegistry.instance.fromSymbol("tbsp")
    public static var fluidOunce = try! UnitRegistry.instance.fromSymbol("fl_oz")
    public static var cup = try! UnitRegistry.instance.fromSymbol("cup")
    public static var pint = try! UnitRegistry.instance.fromSymbol("pt")
    public static var gallon = try! UnitRegistry.instance.fromSymbol("gal")
    public static var imperialFluidOunce = try! UnitRegistry.instance.fromSymbol("ifl_oz")
    public static var imperialCup = try! UnitRegistry.instance.fromSymbol("icup")
    public static var imperialPint = try! UnitRegistry.instance.fromSymbol("ipt")
    public static var imperialGallon = try! UnitRegistry.instance.fromSymbol("igal")
    public static var metricCup = try! UnitRegistry.instance.fromSymbol("mcup")
}
