import Foundation

/// Unit models a unit of measure. Each unit must specify a name, symbol, dimension, and conversion factors.
///
/// A unit can compute a conversion to any other unit of its dimension using its specified conversion factors.
/// Units may be multiplied and divided, resulting in "composite" units, which retain all the characteristics
/// of a basic, predefined unit.
///
/// It also is given a large number of static members for easy access to this package's predefined units.
public struct Unit: Sendable {
    private let type: UnitType

    /// Singleton representing the lack of a unit
    public static var none: Unit {
        Unit(type: .none)
    }

    /// Create a unit from the symbol. This symbol is compared to the registry, decomposed if necessary,
    /// and the relevant unit is initialized.
    /// - Parameter symbol: A string defining the unit to retrieve. This can be the symbol of a defined unit
    /// or a complex unit symbol that combines basic units with `*`, `/`, or `^`.
    public init(fromSymbol symbol: String, registry: Registry = .default) throws {
        let symbolContainsOperator = OperatorSymbols.allCases.contains { arithSymbol in
            symbol.contains(arithSymbol.rawValue)
        }
        if symbolContainsOperator {
            let compositeUnits = try registry.compositeUnitsFromSymbol(symbol: symbol)
            if compositeUnits.isEmpty {
                self = .none
            } else {
                self.init(composedOf: compositeUnits)
            }
        } else {
            let definedUnit = try registry.getUnit(bySymbol: symbol)
            self.init(definedBy: definedUnit)
        }
    }

    /// Retrieve a unit by name. This name is compared to the registry and the relevant unit is initialized.
    /// Only defined units are returned - complex unit name equations are not supported.
    ///
    /// - Parameter symbol: A string name of the unit to retrieve. This cannot be a complex equation of names.
    public init(fromName name: String, registry: Registry = .default) throws {
        let definedUnit = try registry.getUnit(byName: name)
        self.init(definedBy: definedUnit)
    }

    /// Create a unit from the defined unit object.
    /// - Parameter definedBy: A defined unit to wrap
    init(definedBy: DefinedUnit) {
        type = .defined(definedBy)
    }

    /// Create a new from the sub-unit dictionary.
    /// - Parameter subUnits: A dictionary of defined units and exponents. If this dictionary has only a single unit with an exponent of one,
    /// we return that defined unit directly.
    init(composedOf subUnits: [DefinedUnit: Int]) {
        if subUnits.count == 1, let subUnit = subUnits.first, subUnit.value == 1 {
            type = .defined(subUnit.key)
        } else {
            type = .composite(subUnits)
        }
    }

    private init(type: UnitType) {
        self.type = type
    }

    /// The dimension of the unit in terms of base quanties
    public var dimension: [Quantity: Int] {
        switch type {
        case .none:
            return [:]
        case let .defined(definition):
            return definition.dimension
        case let .composite(subUnits):
            var dimensions: [Quantity: Int] = [:]
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
    public func pow(_ raiseTo: Int) -> Unit {
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
                totalCoefficient *= Foundation.pow(subUnit.coefficient, Double(exponent))
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
                totalCoefficient *= Foundation.pow(subUnit.coefficient, Double(exponent))
            }
            return number / totalCoefficient
        }
    }

    // MARK: - Helpers

    /// Returns a dictionary that represents the unique defined units and their exponents. For a
    /// composite unit, this is simply the `subUnits`, but for a defined unit, this is `[self: 1]`
    private var subUnits: [DefinedUnit: Int] {
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
        case composite([DefinedUnit: Int])
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

public extension Unit {
    /// Initialize a unit from the provided string. This checks the input against the symbols stored
    /// in the registry. If no match is found, nil is returned.
    init?(_ description: String, registry _: Registry = .default) {
        if description == "none" {
            self = .none
        } else {
            guard let unit = try? Unit(fromSymbol: description, registry: .default) else {
                return nil
            }
            self = unit
        }
    }
}

extension Unit: Codable {
    public static var registryUserInfoKey: CodingUserInfoKey {
        return CodingUserInfoKey(rawValue: "registry")!
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(symbol)
    }

    public init(from: Decoder) throws {
        let symbol = try from.singleValueContainer().decode(String.self)
        let registry = from.userInfo[Self.registryUserInfoKey] as? Registry ?? .default
        try self.init(fromSymbol: symbol, registry: registry)
    }
}
