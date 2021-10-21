import Foundation

public struct Unit {
    // Populated only on predefined units
    private let definedUnit: DefinedUnit?
    
    // Populated only on composite units
    // TODO: Consider changing to a list of unit/exp pairs
    private let subUnits: [DefinedUnit: Int]?
    
    private init(
        definedUnit: DefinedUnit? = nil,
        subUnits: [DefinedUnit: Int]? = nil
    ) {
        self.definedUnit = definedUnit
        self.subUnits = subUnits
    }
    
    /// Define a new Unit
    /// - parameter symbol: The string symbol of the unit. This should be globally unique
    /// - parameter dimension: The unit dimensionality as a map of base quantities and their respective exponents.
    /// - parameter coefficient: The value to multiply a base unit of this dimension when converting it to this unit. For base units, this is 1.
    /// - parameter constant: The value to add to a base unit when converting it to this unit. This is added after the coefficient is multiplied according to order-of-operations.
    public init(symbol: String, dimension: [Quantity: Int], coefficient: Double = 1, constant: Double = 0) {
        self.init(definedUnit: DefinedUnit(dimension: dimension, symbol: symbol, coefficient: coefficient, constant: constant))
    }
    
    /// Create a new composite Unit
    /// - parameter composedOf: A list of units and exponents that define this composite unit. The units used as keys must be defined units.
    private init(composedOf: [DefinedUnit: Int]) {
        self.init(subUnits: composedOf)
    }
    
    /// Return the dimension of the unit in terms of base quanties
    public func getDimension() -> [Quantity: Int] {
        // TODO: Remove fatalErrors
        if let defined = definedUnit {
            return defined.dimension
        } else if let subUnits = self.subUnits {
            var computedDimension: [Quantity: Int] = [:]
            for (subUnit, exp) in subUnits {
                // multiply subDimensions by unit exponent
                let subDimensions = subUnit.dimension.mapValues { value in
                    exp * value
                }
                // Append or sum values into computed dimension
                for (subDimension, dimExp) in subDimensions {
                    if let computedDimensionExp = computedDimension[subDimension] {
                        let newExp = computedDimensionExp + dimExp
                        if newExp == 0 {
                            computedDimension.removeValue(forKey: subDimension)
                        } else {
                            computedDimension[subDimension] = newExp
                        }
                    } else {
                        computedDimension[subDimension] = dimExp
                    }
                }
            }
            return computedDimension
        } else {
            // We should either be a defined or composed unit
            fatalError()
        }
    }
    
    /// Return a string symbol representing the unit
    public func getSymbol() -> String {
        if let defined = definedUnit {
            return defined.symbol
        } else {
            let unitList = self.sortedUnits()
            var computedSymbol = ""
            for (subUnit, exp) in unitList {
                if exp != 0 {
                    var prefix = ""
                    if computedSymbol == "" {
                        if exp >= 0 {
                            prefix = ""
                        } else {
                            prefix = "1/"
                        }
                    } else {
                        if exp >= 0 {
                            prefix = "*"
                        } else {
                            prefix = "/"
                        }
                    }
                    let symbol = subUnit.symbol
                    var expStr = ""
                    if abs(exp) > 1 {
                        expStr = "^\(abs(exp))"
                    }
                    
                    computedSymbol += "\(prefix)\(symbol)\(expStr)"
                }
            }
            return computedSymbol
        }
    }
    
    // MARK: - Arithmatic
    
    /// Multiply one unit by another and return the resulting unit
    public static func * (lhs: Unit, rhs: Unit) -> Unit {
        var subUnits: [DefinedUnit: Int] = [:]
        
        if let lhsSubUnits = lhs.subUnits {
            for (lhsSubUnit, lhsExp) in lhsSubUnits {
                subUnits[lhsSubUnit] = lhsExp
            }
        } else if let lhsDefined = lhs.definedUnit {
            subUnits[lhsDefined] = 1
        } else {
            fatalError()
        }
        
        if let rhsSubUnits = rhs.subUnits {
            for (rhsSubUnit, rhsExp) in rhsSubUnits {
                if let lhsExp = subUnits[rhsSubUnit] {
                    let newExp = lhsExp + rhsExp
                    if newExp == 0 {
                        subUnits.removeValue(forKey: rhsSubUnit)
                    } else {
                        subUnits[rhsSubUnit] = newExp
                    }
                } else {
                    subUnits[rhsSubUnit] = rhsExp
                }
            }
        } else if let rhsDefined = rhs.definedUnit {
            if let lhsExp = subUnits[rhsDefined] {
                let newExp = lhsExp + 1
                if newExp == 0 {
                    subUnits.removeValue(forKey: rhsDefined)
                } else {
                    subUnits[rhsDefined] = newExp
                }
            } else {
                subUnits[rhsDefined] = 1
            }
        } else {
            fatalError()
        }
        
        return Unit(composedOf: subUnits)
    }
    
    /// Divide one unit by another and return the resulting unit
    public static func / (lhs: Unit, rhs: Unit) -> Unit {
        var subUnits: [DefinedUnit: Int] = [:]
        
        if let lhsSubUnits = lhs.subUnits {
            for (lhsSubUnit, lhsExp) in lhsSubUnits {
                subUnits[lhsSubUnit] = lhsExp
            }
        } else if let lhsDefined = lhs.definedUnit {
            subUnits[lhsDefined] = 1
        } else {
            fatalError()
        }
        
        if let rhsSubUnits = rhs.subUnits {
            for (rhsSubUnit, rhsExp) in rhsSubUnits {
                if let lhsExp = subUnits[rhsSubUnit] {
                    let newExp = lhsExp - rhsExp
                    if newExp == 0 {
                        subUnits.removeValue(forKey: rhsSubUnit)
                    } else {
                        subUnits[rhsSubUnit] = newExp
                    }
                } else {
                    subUnits[rhsSubUnit] = -1 * rhsExp
                }
            }
        } else if let rhsDefined = rhs.definedUnit {
            if let lhsExp = subUnits[rhsDefined] {
                let newExp = lhsExp - 1
                if newExp == 0 {
                    subUnits.removeValue(forKey: rhsDefined)
                } else {
                    subUnits[rhsDefined] = newExp
                }
            } else {
                subUnits[rhsDefined] = -1
            }
        } else {
            fatalError()
        }
        
        return Unit(composedOf: subUnits)
    }
    
    /// Raise this unit to the given power
    public func pow(_ raiseTo: Int) -> Unit {
        var subUnits: [DefinedUnit: Int] = [:]
        
        if let lhsSubUnits = self.subUnits {
            subUnits = lhsSubUnits.mapValues { subExp in
                subExp * raiseTo
            }
        } else if let defined = self.definedUnit {
            subUnits[defined] = raiseTo
        } else {
            fatalError()
        }
        
        return Unit(composedOf: subUnits)
    }
    
    // MARK: - Conversions
    
    /// Boolean indicating whether this unit and the input unit are of the same dimension
    public func isDimensionallyEquivalent(to: Unit) -> Bool {
        return self.getDimension() == to.getDimension()
    }
    
    /// Convert a number to its base value, as defined by the coefficient and constant
    func toBaseUnit(_ number: Double) throws -> Double {
        // TODO: Remove fatalErrors
        if let defined = definedUnit {
            return number * defined.coefficient + defined.constant
        } else if let subUnits = subUnits {
            var product = 1.0
            for (subUnit, exponent) in subUnits {
                guard subUnit.constant == 0 else { // subUnit must not have constant
                    throw UnitsError.invalidCompositeUnit(message: "Nonlinear unit prevents conversion: \(subUnit)")
                }
                product = product * Foundation.pow(subUnit.coefficient, Double(exponent))
            }
            return number * product
        } else {
            fatalError() // Unit must be either defined or composite
        }
    }
    
    /// Convert a number from its base value, as defined by the coefficient and constant
    func fromBaseUnit(_ number: Double) throws -> Double {
        // TODO: Remove fatalErrors
        if let defined = definedUnit {
            return (number - defined.constant) / defined.coefficient
        } else if let subUnits = subUnits {
            var product = 1.0
            for (subUnit, exponent) in subUnits {
                guard subUnit.constant == 0 else { // subUnit must not have constant
                    throw UnitsError.invalidCompositeUnit(message: "Nonlinear unit prevents conversion: \(subUnit)")
                }
                product = product * Foundation.pow(subUnit.coefficient, Double(exponent))
            }
            return number / product
        } else {
            fatalError() // Unit must be either defined or composite
        }
    }
    
    // MARK: - Private helpers
    
    /// Sort units into positive and negative groups, each going from smallest to largest exponent,
    /// with each in alphabetical order by symbol
    private func sortedUnits() -> [(DefinedUnit, Int)] {
        if let defined = definedUnit {
            return [(defined, 1)]
        } else if let subUnits = self.subUnits {
            var unitList = [(DefinedUnit, Int)]()
            for (subUnit, exp) in subUnits {
                unitList.append((subUnit, exp))
            }
            unitList.sort { lhs, rhs in
                if lhs.1 > 0 && rhs.1 > 0 {
                    if lhs.1 == rhs.1 {
                        return lhs.0.symbol < rhs.0.symbol
                    } else {
                        return lhs.1 < rhs.1
                    }
                } else if lhs.1 > 0 && rhs.1 < 0 {
                    return true
                } else if lhs.1 < 0 && rhs.1 > 0 {
                    return false
                } else { // lhs.1 < 0 && rhs.1 > 0
                    if lhs.1 == rhs.1 {
                        return lhs.0.symbol < rhs.0.symbol
                    } else {
                        return lhs.1 > rhs.1
                    }
                }
            }
            return unitList
        } else {
            fatalError()
        }
    }
}

extension Unit: CustomStringConvertible {
    public var description: String {
        return getSymbol()
    }
}

extension Unit: Equatable {
    public static func == (lhs: Unit, rhs: Unit) -> Bool {
        if let lhsDefined = lhs.definedUnit, let rhsDefined = rhs.definedUnit {
            return lhsDefined.symbol == rhsDefined.symbol
        } else if let lhsSubUnits = lhs.subUnits, let rhsSubUnits = rhs.subUnits { // Both composite units
            return lhsSubUnits == rhsSubUnits
        } else {
            return lhs.getSymbol() == rhs.getSymbol()
        }
    }
}

extension Unit: Hashable {
    // TODO: We assume that symbol is completely unique. Perhaps create a unit registry to ensure this?
    public func hash(into hasher: inout Hasher) {
        hasher.combine(getSymbol())
    }
}

private struct DefinedUnit {
    let dimension: [Quantity: Int]
    let symbol: String
    let coefficient: Double
    let constant: Double
}

extension DefinedUnit: Hashable {
    // TODO: We assume that symbol is completely unique. Perhaps create a unit registry to ensure this?
    public func hash(into hasher: inout Hasher) {
        hasher.combine(symbol)
    }
}
