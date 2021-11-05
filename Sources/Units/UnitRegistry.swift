/// UnitRegistry defines a structure that contains all defined units. This ensures
/// that we are able to parse to and from unit symbol representations.
internal class UnitRegistry {
    
    // TODO: Should we eliminate this singleton and make clients keep track?
    internal static let instance = UnitRegistry()
    
    // Store units as a dictionary based on symbol for fast access
    // TODO: Change to Unit to avoid creating multiple Units in memory
    private var units: [String: DefinedUnit]
    private init() {
        self.units = [:]
        for defaultUnit in UnitRegistry.defaultUnits {
            // Protect against double-defining symbols
            if self.units[defaultUnit.symbol] != nil {
                fatalError("Duplicate symbol: \(defaultUnit.symbol)")
            }
            self.units[defaultUnit.symbol] = defaultUnit
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
        if self.units[symbol] != nil {
            throw UnitError.invalidSymbol(message: "Duplicate symbol: \(symbol)")
        }
        self.units[symbol] = newUnit
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
        DefinedUnits.standardGravity,
        
        // MARK: Amount
        DefinedUnits.mole,
        DefinedUnits.millimole,
        DefinedUnits.particle,
        
        // MARK: Angle
        DefinedUnits.radian,
        DefinedUnits.degree,
        
        // MARK: Area
        DefinedUnits.acre,
        DefinedUnits.are,
        DefinedUnits.hectare,
        
        // MARK: Capacitance
        DefinedUnits.farad,
        
        // MARK: Charge
        DefinedUnits.coulomb,
        
        // MARK: Current
        DefinedUnits.ampere,
        DefinedUnits.microampere,
        DefinedUnits.milliampere,
        DefinedUnits.kiloampere,
        DefinedUnits.megaampere,
        
        // MARK: Data
        DefinedUnits.bit,
        DefinedUnits.byte,
        DefinedUnits.kilobyte,
        DefinedUnits.megabyte,
        DefinedUnits.gigabyte,
        DefinedUnits.petabyte,
        
        // MARK: Electric Potential Difference
        DefinedUnits.volt,
        DefinedUnits.microvolt,
        DefinedUnits.millivolt,
        DefinedUnits.kilovolt,
        DefinedUnits.megavolt,
        
        // MARK: Energy
        DefinedUnits.joule,
        DefinedUnits.kilojoule,
        DefinedUnits.calorie,
        DefinedUnits.kilocalorie,
        DefinedUnits.btu,
        DefinedUnits.kilobtu,
        DefinedUnits.megabtu,
        DefinedUnits.therm,
        DefinedUnits.electronVolt,
        
        // MARK: Force
        DefinedUnits.newton,
        DefinedUnits.poundForce,
        
        // MARK: Frequency
        DefinedUnits.hertz,
        DefinedUnits.nanohertz,
        DefinedUnits.microhertz,
        DefinedUnits.millihertz,
        DefinedUnits.kilohertz,
        DefinedUnits.megahertz,
        DefinedUnits.gigahertz,
        DefinedUnits.terahertz,
        
        // MARK: Illuminance
        DefinedUnits.lux,
        DefinedUnits.footCandle,
        DefinedUnits.phot,
        
        // MARK: Inductance
        DefinedUnits.henry,
        
        // MARK: Length
        DefinedUnits.meter,
        DefinedUnits.picometer,
        DefinedUnits.nanoometer,
        DefinedUnits.micrometer,
        DefinedUnits.millimeter,
        DefinedUnits.centimeter,
        DefinedUnits.decameter,
        DefinedUnits.hectometer,
        DefinedUnits.kilometer,
        DefinedUnits.megameter,
        DefinedUnits.inch,
        DefinedUnits.foot,
        DefinedUnits.yard,
        DefinedUnits.mile,
        DefinedUnits.scandanavianMile,
        DefinedUnits.nauticalMile,
        DefinedUnits.fathom,
        DefinedUnits.furlong,
        DefinedUnits.astronomicalUnit,
        DefinedUnits.lightyear,
        DefinedUnits.parsec,
        
        // MARK: Luminous Intensity
        DefinedUnits.candela,
        
        // MARK: Magnetic Flux
        DefinedUnits.weber,
        
        // MARK: Magnetic Flux Density
        DefinedUnits.tesla,
        
        // MARK: Mass
        DefinedUnits.kilogram,
        DefinedUnits.picogram,
        DefinedUnits.nanogram,
        DefinedUnits.microgram,
        DefinedUnits.milligram,
        DefinedUnits.centigram,
        DefinedUnits.decigram,
        DefinedUnits.gram,
        DefinedUnits.metricTon,
        DefinedUnits.carat,
        DefinedUnits.ounce,
        DefinedUnits.pound,
        DefinedUnits.stone,
        DefinedUnits.shortTon,
        DefinedUnits.troyOunces,
        DefinedUnits.slug,
        
        // MARK: Power
        DefinedUnits.watt,
        DefinedUnits.femptowatt,
        DefinedUnits.picowatt,
        DefinedUnits.nanowatt,
        DefinedUnits.microwatt,
        DefinedUnits.milliwatt,
        DefinedUnits.kilowatt,
        DefinedUnits.megawatt,
        DefinedUnits.gigawatt,
        DefinedUnits.terawatt,
        DefinedUnits.horsepower,
        DefinedUnits.tonRefrigeration,
        
        // MARK: Pressure
        DefinedUnits.pascal,
        DefinedUnits.hectopascal,
        DefinedUnits.kilopascal,
        DefinedUnits.megapascal,
        DefinedUnits.gigapascal,
        DefinedUnits.bar,
        DefinedUnits.millibar,
        DefinedUnits.atmosphere,
        DefinedUnits.millimeterOfMercury,
        DefinedUnits.centimeterOfMercury,
        DefinedUnits.inchOfMercury,
        DefinedUnits.centimeterOfWater,
        DefinedUnits.inchOfWater,
        
        // MARK: Resistance
        DefinedUnits.ohm,
        DefinedUnits.microohm,
        DefinedUnits.milliohm,
        DefinedUnits.kiloohm,
        DefinedUnits.megaohm,
        
        // MARK: Solid Angle
        DefinedUnits.steradian,
        
        // MARK: Temperature
        DefinedUnits.kelvin,
        DefinedUnits.celsius,
        DefinedUnits.fahrenheit,
        DefinedUnits.rankine,
        
        // MARK: Time
        DefinedUnits.second,
        DefinedUnits.nanosecond,
        DefinedUnits.microsecond,
        DefinedUnits.millisecond,
        DefinedUnits.minute,
        DefinedUnits.hour,
        
        // MARK: Velocity
        // Base unit is m/s
        DefinedUnits.knots,
        
        // MARK: Volume
        // Base unit is meter^3
        DefinedUnits.liter,
        DefinedUnits.milliliter,
        DefinedUnits.centiliter,
        DefinedUnits.deciliter,
        DefinedUnits.kiloliter,
        DefinedUnits.megaliter,
        DefinedUnits.bushel,
        DefinedUnits.teaspoon,
        DefinedUnits.tablespoon,
        DefinedUnits.fluidOunce,
        DefinedUnits.cup,
        DefinedUnits.pint,
        DefinedUnits.gallon,
        DefinedUnits.imperialFluidOunce,
        DefinedUnits.imperialCup,
        DefinedUnits.imperialPint,
        DefinedUnits.imperialGallon,
        DefinedUnits.metricCup
    ]
}
