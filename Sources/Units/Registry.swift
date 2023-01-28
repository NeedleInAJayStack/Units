/// UnitRegistry defines a structure that contains all defined units. This ensures
/// that we are able to parse to and from unit symbol representations.
internal class Registry {
    // TODO: Should we eliminate this singleton and make clients keep track?
    internal static let instance = Registry()

    // Store units as a dictionary based on symbol for fast access
    // TODO: Change to Unit to avoid creating multiple Units in memory
    private var units: [String: DefinedUnit]
    private init() {
        units = [:]
        for defaultUnit in Registry.defaultUnits {
            // Protect against double-defining symbols
            if units[defaultUnit.symbol] != nil {
                fatalError("Duplicate symbol: \(defaultUnit.symbol)")
            }
            units[defaultUnit.symbol] = defaultUnit
        }
    }
    
    init(inputUnits: [DefinedUnit]) {
        units = [:]
        for inputUnit in inputUnits {
            // Protect against double-defining symbols
            if units[inputUnit.symbol] != nil {
                fatalError("Duplicate symbol: \(inputUnit.symbol)")
            }
            units[inputUnit.symbol] = inputUnit
        }
    }

    /// Returns a list of defined units and their exponents, given a composite unit symbol. It is expected that the caller has
    /// verified that this is a composite unit.
    internal func compositeUnitsFromSymbol(symbol: String) throws -> [DefinedUnit: Int] {
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
        return compositeUnits
    }

    /// Returns a defined unit given a defined unit symbol. It is expected that the caller has
    /// verified that this is not a composite unit.
    internal func definedUnitFromSymbol(symbol: String) throws -> DefinedUnit {
        guard let definedUnit = units[symbol] else {
            throw UnitError.unitNotFound(message: "Symbol '\(symbol)' not recognized")
        }
        return definedUnit
    }

    /// Define a new unit to add to the registry
    /// - parameter name: The string name of the unit.
    /// - parameter symbol: The string symbol of the unit. Symbols may not contain the characters `*`, `/`, or `^`.
    /// - parameter dimension: The unit dimensionality as a dictionary of quantities and their respective exponents.
    /// - parameter coefficient: The value to multiply a base unit of this dimension when converting it to this unit. For base units, this is 1.
    /// - parameter constant: The value to add to a base unit when converting it to this unit. This is added after the coefficient is multiplied according to order-of-operations.
    internal func addUnit(
        name: String,
        symbol: String,
        dimension: [Quantity: Int],
        coefficient: Double = 1,
        constant: Double = 0
    ) throws {
        let newUnit = try DefinedUnit(
            name: name,
            symbol: symbol,
            dimension: dimension,
            coefficient: coefficient,
            constant: constant
        )
        // Protect against double-defining symbols
        if units[symbol] != nil {
            throw UnitError.invalidSymbol(message: "Duplicate symbol: \(symbol)")
        }
        units[symbol] = newUnit
    }

    /// Returns all units currently defined by the registry
    internal func allUnits() -> [Unit] {
        var allUnits = [Unit]()
        for (_, unit) in units {
            allUnits.append(Unit(definedBy: unit))
        }
        return allUnits
    }

    private static let defaultUnits: [DefinedUnit] = [
        // MARK: Acceleration

        DefaultUnits.standardGravity,

        // MARK: Amount

        DefaultUnits.mole,
        DefaultUnits.millimole,
        DefaultUnits.particle,

        // MARK: Angle

        DefaultUnits.radian,
        DefaultUnits.degree,

        // MARK: Area

        DefaultUnits.acre,
        DefaultUnits.are,
        DefaultUnits.hectare,

        // MARK: Capacitance

        DefaultUnits.farad,

        // MARK: Charge

        DefaultUnits.coulomb,

        // MARK: Current

        DefaultUnits.ampere,
        DefaultUnits.microampere,
        DefaultUnits.milliampere,
        DefaultUnits.kiloampere,
        DefaultUnits.megaampere,

        // MARK: Data

        DefaultUnits.bit,
        DefaultUnits.byte,
        DefaultUnits.kilobyte,
        DefaultUnits.megabyte,
        DefaultUnits.gigabyte,
        DefaultUnits.petabyte,

        // MARK: Electric Potential Difference

        DefaultUnits.volt,
        DefaultUnits.microvolt,
        DefaultUnits.millivolt,
        DefaultUnits.kilovolt,
        DefaultUnits.megavolt,

        // MARK: Energy

        DefaultUnits.joule,
        DefaultUnits.kilojoule,
        DefaultUnits.calorie,
        DefaultUnits.kilocalorie,
        DefaultUnits.btu,
        DefaultUnits.kilobtu,
        DefaultUnits.megabtu,
        DefaultUnits.therm,
        DefaultUnits.electronVolt,

        // MARK: Force

        DefaultUnits.newton,
        DefaultUnits.poundForce,

        // MARK: Frequency

        DefaultUnits.hertz,
        DefaultUnits.nanohertz,
        DefaultUnits.microhertz,
        DefaultUnits.millihertz,
        DefaultUnits.kilohertz,
        DefaultUnits.megahertz,
        DefaultUnits.gigahertz,
        DefaultUnits.terahertz,

        // MARK: Illuminance

        DefaultUnits.lux,
        DefaultUnits.footCandle,
        DefaultUnits.phot,

        // MARK: Inductance

        DefaultUnits.henry,

        // MARK: Length

        DefaultUnits.meter,
        DefaultUnits.picometer,
        DefaultUnits.nanoometer,
        DefaultUnits.micrometer,
        DefaultUnits.millimeter,
        DefaultUnits.centimeter,
        DefaultUnits.decameter,
        DefaultUnits.hectometer,
        DefaultUnits.kilometer,
        DefaultUnits.megameter,
        DefaultUnits.inch,
        DefaultUnits.foot,
        DefaultUnits.yard,
        DefaultUnits.mile,
        DefaultUnits.scandanavianMile,
        DefaultUnits.nauticalMile,
        DefaultUnits.fathom,
        DefaultUnits.furlong,
        DefaultUnits.astronomicalUnit,
        DefaultUnits.lightyear,
        DefaultUnits.parsec,

        // MARK: Luminous Intensity

        DefaultUnits.candela,

        // MARK: Magnetic Flux

        DefaultUnits.weber,

        // MARK: Magnetic Flux Density

        DefaultUnits.tesla,

        // MARK: Mass

        DefaultUnits.kilogram,
        DefaultUnits.picogram,
        DefaultUnits.nanogram,
        DefaultUnits.microgram,
        DefaultUnits.milligram,
        DefaultUnits.centigram,
        DefaultUnits.decigram,
        DefaultUnits.gram,
        DefaultUnits.metricTon,
        DefaultUnits.carat,
        DefaultUnits.ounce,
        DefaultUnits.pound,
        DefaultUnits.stone,
        DefaultUnits.shortTon,
        DefaultUnits.troyOunces,
        DefaultUnits.slug,

        // MARK: Power

        DefaultUnits.watt,
        DefaultUnits.femptowatt,
        DefaultUnits.picowatt,
        DefaultUnits.nanowatt,
        DefaultUnits.microwatt,
        DefaultUnits.milliwatt,
        DefaultUnits.kilowatt,
        DefaultUnits.megawatt,
        DefaultUnits.gigawatt,
        DefaultUnits.terawatt,
        DefaultUnits.horsepower,
        DefaultUnits.tonRefrigeration,

        // MARK: Pressure

        DefaultUnits.pascal,
        DefaultUnits.hectopascal,
        DefaultUnits.kilopascal,
        DefaultUnits.megapascal,
        DefaultUnits.gigapascal,
        DefaultUnits.bar,
        DefaultUnits.millibar,
        DefaultUnits.atmosphere,
        DefaultUnits.millimeterOfMercury,
        DefaultUnits.centimeterOfMercury,
        DefaultUnits.inchOfMercury,
        DefaultUnits.centimeterOfWater,
        DefaultUnits.inchOfWater,

        // MARK: Resistance

        DefaultUnits.ohm,
        DefaultUnits.microohm,
        DefaultUnits.milliohm,
        DefaultUnits.kiloohm,
        DefaultUnits.megaohm,

        // MARK: Solid Angle

        DefaultUnits.steradian,

        // MARK: Temperature

        DefaultUnits.kelvin,
        DefaultUnits.celsius,
        DefaultUnits.fahrenheit,
        DefaultUnits.rankine,

        // MARK: Time

        DefaultUnits.second,
        DefaultUnits.nanosecond,
        DefaultUnits.microsecond,
        DefaultUnits.millisecond,
        DefaultUnits.minute,
        DefaultUnits.hour,

        // MARK: Velocity

        // Base unit is m/s
        DefaultUnits.knots,

        // MARK: Volume

        // Base unit is meter^3
        DefaultUnits.liter,
        DefaultUnits.milliliter,
        DefaultUnits.centiliter,
        DefaultUnits.deciliter,
        DefaultUnits.kiloliter,
        DefaultUnits.megaliter,
        DefaultUnits.bushel,
        DefaultUnits.teaspoon,
        DefaultUnits.tablespoon,
        DefaultUnits.fluidOunce,
        DefaultUnits.cup,
        DefaultUnits.pint,
        DefaultUnits.gallon,
        DefaultUnits.imperialFluidOunce,
        DefaultUnits.imperialCup,
        DefaultUnits.imperialPint,
        DefaultUnits.imperialGallon,
        DefaultUnits.metricCup,
    ]
}
