import Foundation

class Unit {
    // Populated only on predefined units
    private let dimension: [BaseQuantity: Int]?
    private let symbol: String?
    let coefficient: Double?
    let constant: Double?
    
    // Populated only on composite units
    // TODO: Consider changing to a list of unit/exp pairs
    let subUnits: [Unit: Int]?
    
    private init(
        dimension: [BaseQuantity: Int]? = nil,
        symbol: String? = nil,
        coefficient: Double? = nil,
        constant: Double? = nil,
        subUnits: [Unit: Int]? = nil
    ) {
        self.dimension = dimension
        self.symbol = symbol
        self.coefficient = coefficient
        self.constant = constant
        self.subUnits = subUnits
    }
    
    /// Define a new Unit
    /// - parameter symbol: The string symbol of the unit. This should be globally unique
    /// - parameter dimension: The unit dimensionality as a map of base quantities and their respective exponents.
    /// - parameter coefficient: The value to multiply a base unit of this dimension when converting it to this unit. For base units, this is 1.
    /// - parameter constant: The value to add to a base unit when converting it to this unit. This is added after the coefficient is multiplied according to order-of-operations.
    convenience init(symbol: String, dimension: [BaseQuantity: Int], coefficient: Double = 1, constant: Double = 0) {
        self.init(dimension: dimension, symbol: symbol, coefficient: coefficient, constant: constant)
    }
    
    /// Create a new composite Unit
    /// - parameter composedOf: A list of units and exponents that define this composite unit. The units used as keys must be defined units.
    private convenience init(composedOf: [Unit: Int]) {
        self.init(subUnits: composedOf)
    }
    
    /// Boolean indicating whether this unit and the input unit are of the same dimension
    public func isDimensionallyEquivalent(to: Unit) -> Bool {
        return self.getDimension() == to.getDimension()
    }
    
    func toBaseUnit(_ number: Double) -> Double {
        // TODO: Remove fatalErrors
        if let coefficient = coefficient {
            return number * coefficient
        } else if let subUnits = subUnits {
            var product = 1.0
            for (subUnit, exponent) in subUnits {
                guard let coefficient = subUnit.coefficient else {
                    fatalError() // subUnits must be defined units
                }
                product = product * Foundation.pow(coefficient, Double(exponent))
            }
            return number * product
        } else {
            fatalError() // Unit must be either defined or composite
        }
    }
    
    func fromBaseUnit(_ number: Double) -> Double {
        // TODO: Remove fatalErrors
        if let coefficient = coefficient {
            return number / coefficient
        } else if let subUnits = subUnits {
            var product = 1.0
            for (subUnit, exponent) in subUnits {
                guard let coefficient = subUnit.coefficient else {
                    fatalError() // subUnits must be defined units
                }
                product = product * Foundation.pow(coefficient, Double(exponent))
            }
            return number / product
        } else {
            fatalError() // Unit must be either defined or composite
        }
    }
    
    /// Return the dimension of the unit in terms of base quanties
    func getDimension() -> [BaseQuantity: Int] {
        // TODO: Remove fatalErrors
        if let dimension = self.dimension {
            return dimension
        } else if let subUnits = self.subUnits {
            var computedDimension: [BaseQuantity: Int] = [:]
            for (subUnit, exp) in subUnits {
                // multiply subDimensions by unit exponent
                let subDimensions = subUnit.getDimension().mapValues { value in
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
    func getSymbol() -> String {
        if let symbol = self.symbol {
            return symbol
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
                    let symbol = subUnit.getSymbol()
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
    
    // MARK: Arithmatic
    
    /// Raise this unit to the given power
    func pow(_ raiseTo: Int) -> Unit {
        var subUnits: [Unit: Int] = [:]
        
        if let lhsSubUnits = self.subUnits {
            subUnits = lhsSubUnits.mapValues { subExp in
                subExp * raiseTo
            }
        } else {
            subUnits[self] = raiseTo
        }
        
        return Unit(composedOf: subUnits)
    }
    
    /// Multiply one unit by another and return the resulting unit
    static func * (lhs: Unit, rhs: Unit) -> Unit {
        var subUnits: [Unit: Int] = [:]
        
        if let lhsSubUnits = lhs.subUnits {
            for (lhsSubUnit, lhsExp) in lhsSubUnits {
                subUnits[lhsSubUnit] = lhsExp
            }
        } else {
            subUnits[lhs] = 1
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
        } else {
            if let lhsExp = subUnits[rhs] {
                let newExp = lhsExp + 1
                if newExp == 0 {
                    subUnits.removeValue(forKey: rhs)
                } else {
                    subUnits[rhs] = newExp
                }
            } else {
                subUnits[rhs] = 1
            }
        }
        
        return Unit(composedOf: subUnits)
    }
    
    /// Divide one unit by another and return the resulting unit
    static func / (lhs: Unit, rhs: Unit) -> Unit {
        var subUnits: [Unit: Int] = [:]
        
        if let lhsSubUnits = lhs.subUnits {
            for (lhsSubUnit, lhsExp) in lhsSubUnits {
                subUnits[lhsSubUnit] = lhsExp
            }
        } else {
            subUnits[lhs] = 1
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
        } else {
            if let lhsExp = subUnits[rhs] {
                let newExp = lhsExp - 1
                if newExp == 0 {
                    subUnits.removeValue(forKey: rhs)
                } else {
                    subUnits[rhs] = newExp
                }
            } else {
                subUnits[rhs] = -1
            }
        }
        
        return Unit(composedOf: subUnits)
    }
    
    /// Sort units into positive and negative groups, each going from smallest to largest exponent,
    /// with each in alphabetical order by symbol
    private func sortedUnits() -> [(Unit, Int)] {
        guard let subUnits = self.subUnits else {
            return [(self, 1)]
        }
        
        var unitList = [(Unit, Int)]()
        for (subUnit, exp) in subUnits {
            unitList.append((subUnit, exp))
        }
        unitList.sort { lhs, rhs in
            if lhs.1 > 0 && rhs.1 > 0 {
                if lhs.1 == rhs.1 {
                    if let lhsSymbol = lhs.0.symbol, let rhsSymbol = rhs.0.symbol {
                        return lhsSymbol < rhsSymbol
                    }
                    return true
                } else {
                    return lhs.1 < rhs.1
                }
            } else if lhs.1 > 0 && rhs.1 < 0 {
                return true
            } else if lhs.1 < 0 && rhs.1 > 0 {
                return false
            } else { // lhs.1 < 0 && rhs.1 > 0
                if lhs.1 == rhs.1 {
                    if let lhsSymbol = lhs.0.symbol, let rhsSymbol = rhs.0.symbol {
                        return lhsSymbol < rhsSymbol
                    }
                    return true
                } else {
                    return lhs.1 > rhs.1
                }
            }
        }
        return unitList
    }
}

extension Unit: CustomStringConvertible {
    var description: String {
        return getSymbol()
    }
}

extension Unit: Equatable {
    static func == (lhs: Unit, rhs: Unit) -> Bool {
        if let lhsSymbol = lhs.symbol, let rhsSymbol = rhs.symbol { // Both predefined units
            return lhsSymbol == rhsSymbol
        } else if let lhsSubUnits = lhs.subUnits, let rhsSubUnits = rhs.subUnits { // Both composite units
            return lhsSubUnits == rhsSubUnits
        } else {
            return lhs.getSymbol() == rhs.getSymbol()
        }
    }
}

extension Unit: Hashable {
    // TODO: We assume that symbol is completely unique. Perhaps create a unit registry to ensure this?
    func hash(into hasher: inout Hasher) {
        hasher.combine(getSymbol())
    }
}
