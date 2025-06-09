/// UnitRegistry defines a structure that contains all defined units. This ensures
/// that we are able to parse to and from unit symbol representations.
public final class Registry: Sendable {
    public static let `default`: Registry = RegistryBuilder().registry()

    // Quick access based on symbol
    private let symbolMap: [String: DefinedUnit]
    // Quick access based on name
    private let nameMap: [String: DefinedUnit]

    /// Internal - use the RegistryBuilder to create a new registry.
    init(symbolMap: [String: DefinedUnit], nameMap: [String: DefinedUnit]) {
        self.symbolMap = symbolMap
        self.nameMap = nameMap
    }

    /// Returns a list of defined units and their exponents, given a composite unit symbol. It is expected that the caller has
    /// verified that this is a composite unit.
    func compositeUnitsFromSymbol(symbol: String) throws -> [DefinedUnit: Int] {
        let symbolsAndExponents = try deserializeSymbolicEquation(symbol)

        var compositeUnits = [DefinedUnit: Int]()
        for (definedUnitSymbol, exponent) in symbolsAndExponents {
            guard exponent != 0 else {
                continue
            }
            let definedUnit = try getUnit(bySymbol: definedUnitSymbol)
            compositeUnits[definedUnit] = exponent
        }
        return compositeUnits
    }

    /// Returns a defined unit given a defined unit symbol. It is expected that the caller has
    /// verified that this is not a composite unit.
    func getUnit(bySymbol symbol: String) throws -> DefinedUnit {
        guard let definedUnit = symbolMap[symbol] else {
            throw UnitError.unitNotFound(message: "Symbol '\(symbol)' not recognized")
        }
        return definedUnit
    }

    /// Returns a defined unit given a defined unit name. It is expected that the caller has
    /// verified that this is not a composite unit.
    func getUnit(byName name: String) throws -> DefinedUnit {
        guard let definedUnit = nameMap[name] else {
            throw UnitError.unitNotFound(message: "Name '\(name)' not recognized")
        }
        return definedUnit
    }

    /// Returns all units currently defined by the registry
    public func allUnits() -> [Unit] {
        var allUnits = [Unit]()
        for (_, unit) in symbolMap {
            allUnits.append(Unit(definedBy: unit))
        }
        return allUnits
    }
}
