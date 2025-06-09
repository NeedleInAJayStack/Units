public class RegistryBuilder {
    // Quick access based on symbol
    private var symbolMap: [String: DefinedUnit]
    // Quick access based on name
    private var nameMap: [String: DefinedUnit]

    /// Create a new registry builder. The default units defined by this package are always included.
    public init() {
        symbolMap = [:]
        nameMap = [:]
        for defaultUnit in Self.defaultUnits {
            // Protect against double-defining symbols
            if symbolMap[defaultUnit.symbol] != nil {
                fatalError("Duplicate symbol: \(defaultUnit.symbol)")
            }
            symbolMap[defaultUnit.symbol] = defaultUnit

            // Protect against double-defining names
            if nameMap[defaultUnit.name] != nil {
                fatalError("Duplicate name: \(defaultUnit.name)")
            }
            nameMap[defaultUnit.name] = defaultUnit
        }
    }

    /// Build and return a new registry instance from the current state of the builder.
    public func registry() -> Registry {
        return Registry(
            symbolMap: symbolMap,
            nameMap: nameMap
        )
    }

    /// Define a new unit to add to the registry
    /// - parameter name: The string name of the unit.
    /// - parameter symbol: The string symbol of the unit. Symbols may not contain the characters `*`, `/`, or `^`.
    /// - parameter dimension: The unit dimensionality as a dictionary of quantities and their respective exponents.
    /// - parameter coefficient: The value to multiply a base unit of this dimension when converting it to this unit. For base units, this is 1.
    /// - parameter constant: The value to add to a base unit when converting it to this unit. This is added after the coefficient is multiplied according to order-of-operations.
    @discardableResult
    public func addUnit(
        name: String,
        symbol: String,
        dimension: [Quantity: Int],
        coefficient: Double = 1,
        constant: Double = 0
    ) throws -> RegistryBuilder {
        let newUnit = try DefinedUnit(
            name: name,
            symbol: symbol,
            dimension: dimension,
            coefficient: coefficient,
            constant: constant
        )
        // Protect against double-defining symbols
        if symbolMap[symbol] != nil {
            throw UnitError.invalidSymbol(message: "Duplicate symbol: \(symbol)")
        }
        symbolMap[symbol] = newUnit

        // Protect against double-defining names
        if nameMap[name] != nil {
            fatalError("Duplicate name: \(name)")
        }
        nameMap[name] = newUnit

        return self
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
        DefaultUnits.revolution,

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
        DefaultUnits.kilobit,
        DefaultUnits.megabit,
        DefaultUnits.gigabit,
        DefaultUnits.terabit,
        DefaultUnits.petabit,
        DefaultUnits.exabit,
        DefaultUnits.zetabit,
        DefaultUnits.yottabit,
        DefaultUnits.kibibit,
        DefaultUnits.mebibit,
        DefaultUnits.gibibit,
        DefaultUnits.tebibit,
        DefaultUnits.pebibit,
        DefaultUnits.exbibit,
        DefaultUnits.zebibit,
        DefaultUnits.yobibit,
        DefaultUnits.byte,
        DefaultUnits.kilobyte,
        DefaultUnits.megabyte,
        DefaultUnits.gigabyte,
        DefaultUnits.terabyte,
        DefaultUnits.petabyte,
        DefaultUnits.exabyte,
        DefaultUnits.zetabyte,
        DefaultUnits.yottabyte,
        DefaultUnits.kibibyte,
        DefaultUnits.mebibyte,
        DefaultUnits.gibibyte,
        DefaultUnits.tebibyte,
        DefaultUnits.pebibyte,
        DefaultUnits.exbibyte,
        DefaultUnits.zebibyte,
        DefaultUnits.yobibyte,

        // MARK: Electric Potential Difference

        DefaultUnits.volt,
        DefaultUnits.microvolt,
        DefaultUnits.millivolt,
        DefaultUnits.kilovolt,
        DefaultUnits.megavolt,

        // MARK: Energy

        DefaultUnits.joule,
        DefaultUnits.kilojoule,
        DefaultUnits.megajoule,
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

        // MARK: Luminous Flux

        DefaultUnits.lumen,

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
        DefaultUnits.day,
        DefaultUnits.week,
        DefaultUnits.year,

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
        DefaultUnits.teaspoon,
        DefaultUnits.tablespoon,
        DefaultUnits.fluidOunce,
        DefaultUnits.cup,
        DefaultUnits.pint,
        DefaultUnits.quart,
        DefaultUnits.gallon,
        DefaultUnits.dryPint,
        DefaultUnits.dryQuart,
        DefaultUnits.peck,
        DefaultUnits.bushel,
        DefaultUnits.imperialFluidOunce,
        DefaultUnits.imperialCup,
        DefaultUnits.imperialPint,
        DefaultUnits.imperialQuart,
        DefaultUnits.imperialGallon,
        DefaultUnits.imperialPeck,
        DefaultUnits.metricCup,
    ]
}
