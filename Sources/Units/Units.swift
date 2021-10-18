import Foundation

class Unit: CustomStringConvertible, Equatable, Hashable {
    
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
    
    // Predefined unit
    convenience init(symbol: String, dimension: [BaseQuantity: Int], coefficient: Double = 1, constant: Double = 0) {
        self.init(dimension: dimension, symbol: symbol, coefficient: coefficient, constant: constant)
    }
    
    // Composite unit
    private convenience init(composedOf: [Unit: Int]) {
        self.init(subUnits: composedOf)
    }
    
    var description: String {
        return getSymbol()
    }
    
    func getDimension() -> [BaseQuantity: Int] {
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
    
    func getSymbol() -> String {
        if let symbol = self.symbol {
            return symbol
        } else if let subUnits = self.subUnits {
            // Sort units into positive and negative groups, each going from smallest to greatest exponent,
            // with each in alphabetical order by symbol
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
        } else {
            // We should either be a defined or composed unit
            fatalError()
        }
    }
    
    static func == (lhs: Unit, rhs: Unit) -> Bool {
        if let lhsSymbol = lhs.symbol, let rhsSymbol = rhs.symbol {
            return lhsSymbol == rhsSymbol
        } else if let lhsSubUnits = lhs.subUnits, let rhsSubUnits = rhs.subUnits {
            return lhsSubUnits == rhsSubUnits
        } else {
            return lhs.getSymbol() == rhs.getSymbol()
        }
    }
    
    // TODO: We assume that symbol is completely unique. Perhaps create a unit registry to ensure this?
    func hash(into hasher: inout Hasher) {
        hasher.combine(getSymbol())
    }
    
    // MARK: Arithmatic
    
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
}
