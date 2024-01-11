import Foundation

/// Unit models a unit of measure. Each unit must specify a name, symbol, dimension, and conversion factors.
///
/// A unit can compute a conversion to any other unit of its dimension using its specified conversion factors.
/// Units may be multiplied and divided, resulting in "composite" units, which retain all the characteristics
/// of a basic, predefined unit.
///
/// This type is backed by a global registry that allows units to be encoded and decoded using their symbol.
/// It also is given a large number of static members for easy access to this package's predefined units.
public struct Unit {
    private let type: UnitType

    /// Singleton representing the lack of a unit
    public static var none: Unit {
        Unit(type: .none)
    }

    /// Create a unit from the symbol. This symbol is compared to the global registry, decomposed if necessary,
    /// and the relevant unit is initialized.
    /// - Parameter symbol: A string defining the unit to retrieve. This can be the symbol of a defined unit
    /// or a complex unit symbol that combines basic units with `*`, `/`, or `^`.
    public init(fromSymbol symbol: String) throws {
        let symbolContainsOperator = OperatorSymbols.allCases.contains { arithSymbol in
            symbol.contains(arithSymbol.rawValue)
        }
        if symbolContainsOperator {
            let compositeUnits = try Registry.instance.compositeUnitsFromSymbol(symbol: symbol)
            if compositeUnits.isEmpty {
                self = .none
            } else {
                self.init(composedOf: compositeUnits)
            }
        } else {
            let definedUnit = try Registry.instance.getUnit(bySymbol: symbol)
            self.init(definedBy: definedUnit)
        }
    }

    /// Retrieve a unit by name. This name is compared to the global registry and the relevant unit is initialized.
    /// Only defined units are returned - complex unit name equations are not supported.
    ///
    /// - Parameter symbol: A string name of the unit to retrieve. This cannot be a complex equation of names.
    public init(fromName name: String) throws {
        let definedUnit = try Registry.instance.getUnit(byName: name)
        self.init(definedBy: definedUnit)
    }

    /// Create a unit from the defined unit object.
    /// - Parameter definedBy: A defined unit to wrap
    internal init(definedBy: DefinedUnit) {
        type = .defined(definedBy)
    }

    /// Create a new from the sub-unit dictionary.
    /// - Parameter subUnits: A dictionary of defined units and exponents. If this dictionary has only a single unit with an exponent of one,
    /// we return that defined unit directly.
    internal init(composedOf subUnits: [DefinedUnit: Fraction]) {
        if subUnits.count == 1, let subUnit = subUnits.first, subUnit.value == 1 {
            type = .defined(subUnit.key)
        } else {
            type = .composite(subUnits)
        }
    }

    private init(type: UnitType) {
        self.type = type
    }

    /// Define a unit extension without adding it to the registry. The resulting unit object should be retained
    /// and passed to the callers that may want to use it.
    ///
    /// This unit can be used for arithmatic, conversions, and is encoded correctly. However, since it is
    /// not part of the global registry it will not be decoded, will not be included in the `allDefined()`
    /// method, and cannot not be retrieved using `Unit(fromSymbol:)`.
    ///
    /// This method is considered "safe" because it does not modify the global unit registry.
    ///
    /// - Parameters:
    ///   - name: The string name of the unit.
    ///   - symbol: The string symbol of the unit. Symbols may not contain the characters `*`, `/`, or `^`.
    ///   - dimension: The unit dimensionality as a dictionary of quantities and their respective exponents.
    ///   - coefficient: The value to multiply a base unit of this dimension when converting it to this unit.
    ///   For base units, this is 1.
    ///   - constant: The value to add to a base unit when converting it to this unit. For units without scaling
    ///   differences, this is 0. This is added after the coefficient is multiplied according to order-of-operations.
    /// - Returns: The unit that was defined.
    public static func define(
        name: String,
        symbol: String,
        dimension: [Quantity: Fraction],
        coefficient: Double = 1,
        constant: Double = 0
    ) throws -> Unit {
        return try Unit(
            definedBy: .init(
                name: name,
                symbol: symbol,
                dimension: dimension,
                coefficient: coefficient,
                constant: constant
            )
        )
    }

    /// **Careful!** Register a new unit to the global registry. Unless you need deserialization support for this unit,
    /// or support to look up this unit from a different memory-space, we suggest that `define` is used instead.
    ///
    /// By using this method, the unit is added to the global registry so it will be deserialized correctly, will be included
    /// in the `allDefined()` and `Unit(fromSymbol)` methods, and will be available to everyone accessing
    /// this package in your runtime environment.
    ///
    /// - Parameters:
    ///   - name: The string name of the unit.
    ///   - symbol: The string symbol of the unit. Symbols may not contain the characters `*`, `/`, or `^`.
    ///   - dimension: The unit dimensionality as a dictionary of quantities and their respective exponents.
    ///   - coefficient: The value to multiply a base unit of this dimension when converting it to this unit.
    ///   For base units, this is 1.
    ///   - constant: The value to add to a base unit when converting it to this unit. For units without scaling
    ///   differences, this is 0. This is added after the coefficient is multiplied according to order-of-operations.
    /// - Returns: The unit definition that now exists in the registry.
    @discardableResult
    public static func register(
        name: String,
        symbol: String,
        dimension: [Quantity: Fraction],
        coefficient: Double = 1,
        constant: Double = 0
    ) throws -> Unit {
        try Registry.instance.addUnit(
            name: name,
            symbol: symbol,
            dimension: dimension,
            coefficient: coefficient,
            constant: constant
        )
        return try Unit(fromSymbol: symbol)
    }

    /// Get all defined units
    /// - Returns: A list of units representing all that are defined in the registry
    public static func allDefined() -> [Unit] {
        Registry.instance.allUnits()
    }

    /// The dimension of the unit in terms of base quanties
    public var dimension: [Quantity: Fraction] {
        switch type {
        case .none:
            return [:]
        case let .defined(definition):
            return definition.dimension
        case let .composite(subUnits):
            var dimensions: [Quantity: Fraction] = [:]
            for (subUnit, exp) in subUnits {
                let subDimensions = subUnit.dimension.mapValues { value in
                    exp * value
                }
                dimensions.merge(subDimensions) { existingExp, subDimensionExp in
                    existingExp + subDimensionExp
                }
            }
            return dimensions.filter { _, value in
                value != 0
            }
        }
    }

    /// The string symbol of the unit
    public var symbol: String {
        switch type {
        case .none:
            return "none"
        case let .defined(definition):
            return definition.symbol
        case let .composite(subUnits):
            return serializeSymbolicEquation(
                of: subUnits,
                symbolPath: \DefinedUnit.symbol
            )
        }
    }

    /// The string name of the unit
    public var name: String {
        switch type {
        case .none:
            return "no unit"
        case let .defined(definition):
            return definition.name
        case let .composite(subUnits):
            return serializeSymbolicEquation(
                of: subUnits,
                symbolPath: \DefinedUnit.name,
                spaceAroundOperators: true
            )
        }
    }

    public func dimensionDescription() -> String {
        return serializeSymbolicEquation(
            of: dimension,
            symbolPath: \Quantity.rawValue
        )
    }

    // MARK: - Arithmatic

    /// Multiply the units.
    /// - Parameters:
    ///   - lhs: The left-hand-side unit
    ///   - rhs: The right-hand-side unit
    /// - Returns: A unit modeling the product of the left-hand-side and right-hand-side units
    public static func * (lhs: Unit, rhs: Unit) -> Unit {
        let lhsUnits = lhs.subUnits
        let rhsUnits = rhs.subUnits

        var subUnits = lhsUnits
        subUnits.merge(rhsUnits) { lhsUnitExp, rhsUnitExp in
            lhsUnitExp + rhsUnitExp
        }
        subUnits = subUnits.filter { _, value in
            value != 0
        }
        if subUnits.isEmpty {
            return Unit.none
        } else {
            return Unit(composedOf: subUnits)
        }
    }

    /// Divide the units.
    /// - Parameters:
    ///   - lhs: The left-hand-side unit
    ///   - rhs: The right-hand-side unit
    /// - Returns: A unit modeling the left-hand-side unit divided by the right-hand-side unit.
    public static func / (lhs: Unit, rhs: Unit) -> Unit {
        let lhsUnits = lhs.subUnits
        let rhsUnits = rhs.subUnits

        let negRhsUnits = rhsUnits.mapValues { rhsUnitExp in
            -1 * rhsUnitExp
        }

        var subUnits = lhsUnits
        subUnits.merge(negRhsUnits) { lhsUnitExp, negRhsUnitExp in
            lhsUnitExp + negRhsUnitExp
        }
        subUnits = subUnits.filter { _, value in
            value != 0
        }
        if subUnits.isEmpty {
            return Unit.none
        } else {
            return Unit(composedOf: subUnits)
        }
    }

    /// Exponentiate the unit. This is equavalent to multiple `*` operations.
    /// - Parameter raiseTo: The exponent to raise the unit to
    /// - Returns: A new unit modeling the original raised to the provided power
    public func pow(_ raiseTo: Fraction) -> Unit {
        switch type {
        case .none:
            return .none
        case let .defined(defined):
            return Unit(composedOf: [defined: raiseTo])
        case let .composite(subUnits):
            let newSubUnits = subUnits.mapValues { subExp in
                subExp * raiseTo
            }
            return Unit(composedOf: newSubUnits)
        }
    }

    // MARK: - Conversions

    /// Tests that two units are of the same dimension
    /// - Parameter to: The unit to compare this one to
    /// - Returns: A bool indicating whether this unit and the input unit are of the same dimension
    public func isDimensionallyEquivalent(to: Unit) -> Bool {
        return dimension == to.dimension
    }

    /// Convert a provided amount of this unit to base dimensional units. This unit's conversion definition is used.
    ///
    /// For example, `Unit.kilometer.toBaseUnit(5)` will return `5000`, since `5km = 5000m`
    ///
    /// - Parameter number: The amount of this unit to convert to the base units.
    /// - Returns: The equivalent amount in terms of the dimensional base units.
    func toBaseUnit(_ number: Double) throws -> Double {
        switch type {
        case .none:
            return number
        case let .defined(defined):
            return number * defined.coefficient + defined.constant
        case let .composite(subUnits):
            var totalCoefficient = 1.0
            for (subUnit, exponent) in subUnits {
                guard subUnit.constant == 0 else { // subUnit must not have constant
                    throw UnitError.invalidCompositeUnit(message: "Nonlinear unit prevents conversion: \(subUnit)")
                }
                totalCoefficient *= Foundation.pow(subUnit.coefficient, exponent.asDouble)
            }
            return number * totalCoefficient
        }
    }

    /// Convert a provided amount of base dimensional units to this unit. This unit's conversion definition is used.
    ///
    /// For example, `Unit.kilometer.fromBaseUnit(5)` will return `0.005`, since `5m = 0.005km`
    ///
    /// - Parameter number: The amount of base units to conver to this unit.
    /// - Returns: The equivalent amount in terms of this unit.
    func fromBaseUnit(_ number: Double) throws -> Double {
        switch type {
        case .none:
            return number
        case let .defined(defined):
            return (number - defined.constant) / defined.coefficient
        case let .composite(subUnits):
            var totalCoefficient = 1.0
            for (subUnit, exponent) in subUnits {
                guard subUnit.constant == 0 else { // subUnit must not have constant
                    throw UnitError.invalidCompositeUnit(message: "Nonlinear unit prevents conversion: \(subUnit)")
                }
                totalCoefficient *= Foundation.pow(subUnit.coefficient, exponent.asDouble)
            }
            return number / totalCoefficient
        }
    }

    // MARK: - Helpers

    /// Returns a dictionary that represents the unique defined units and their exponents. For a
    /// composite unit, this is simply the `subUnits`, but for a defined unit, this is `[self: 1]`
    private var subUnits: [DefinedUnit: Fraction] {
        switch type {
        case .none:
            return [:]
        case let .defined(defined):
            return [defined: 1]
        case let .composite(subUnits):
            return subUnits
        }
    }

    /// The two possible types of unit - defined or composite
    private enum UnitType: Sendable {
        case none
        case defined(DefinedUnit)
        case composite([DefinedUnit: Fraction])
    }
}

extension Unit: Equatable {
    public static func == (lhs: Unit, rhs: Unit) -> Bool {
        switch (lhs.type, rhs.type) {
        case (.none, .none):
            return true
        case let (.defined(lhsDefined), .defined(rhsDefined)):
            return lhsDefined == rhsDefined
        case let (.composite(lhsSubUnits), .composite(rhsSubUnits)):
            return lhsSubUnits == rhsSubUnits
        default:
            return false
        }
    }
}

extension Unit: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
    }
}

extension Unit: CustomStringConvertible {
    public var description: String {
        switch type {
        case .none:
            return "none"
        default:
            return symbol
        }
    }
}

extension Unit: LosslessStringConvertible {
    /// Initialize a unit from the provided string. This checks the input against the symbols stored
    /// in the registry. If no match is found, nil is returned.
    public init?(_ description: String) {
        if description == "none" {
            self = .none
        } else {
            guard let unit = try? Unit(fromSymbol: description) else {
                return nil
            }
            self = unit
        }
    }
}

extension Unit: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(symbol)
    }

    public init(from: Decoder) throws {
        let symbol = try from.singleValueContainer().decode(String.self)
        try self.init(fromSymbol: symbol)
    }
}

extension Unit: Sendable {}
