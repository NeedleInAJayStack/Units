
// Defines the possible base quantities, as defined by the SI units: https://en.wikipedia.org/wiki/International_System_of_Units#Overview_of_the_units
enum BaseQuantity {
    case Time
    case Length
    case Mass
    case Current
    case Temperature
    case Amount
    case LuminousIntensity
    
    static let allValues = [
        Time,
        Length,
        Mass,
        Current,
        Temperature,
        Amount,
        LuminousIntensity,
    ]
}

class Unit {
    let dimension: [BaseQuantity: Int]
    
    init(dimension: [BaseQuantity: Int]) {
        self.dimension = dimension
    }
    
    func multiply(by: Unit) -> Unit {
        let dimension1 = self.dimension
        let dimension2 = by.dimension
        
        var newDimension: [BaseQuantity: Int] = [:]
        for base in BaseQuantity.allValues {
            if let exp1 = dimension1[base], let exp2 = dimension2[base] {
                newDimension[base] = exp1 + exp2
            } else if let exp1 = dimension1[base] {
                newDimension[base] = exp1
            } else if let exp2 = dimension2[base] {
                newDimension[base] = exp2
            }
        }
        
        return Unit(dimension: newDimension)
    }
    
    func divide(by: Unit) -> Unit {
        let dimension1 = self.dimension
        let dimension2 = by.dimension
        
        var newDimension: [BaseQuantity: Int] = [:]
        for base in BaseQuantity.allValues {
            if let exp1 = dimension1[base], let exp2 = dimension2[base] {
                let newExp = exp1 - exp2
                if newExp != 0 {
                    newDimension[base] = newExp
                }
                // Don't add to newDimension at all if it zeros out
            } else if let exp1 = dimension1[base] {
                newDimension[base] = exp1
            } else if let exp2 = dimension2[base] {
                newDimension[base] = -1 * exp2
            }
        }
        
        return Unit(dimension: newDimension)
    }
}

// Hard-coded symbols are for predefined units.
class DefinedUnit: Unit {
    let symbol: String
    
    init(symbol: String, dimension: [BaseQuantity: Int]) {
        self.symbol = symbol
        super.init(dimension: dimension)
    }
}

// TODO: Organize units into a nice enum or a static class vars (like Foundation)
class UnitLength {
    static var meter = DefinedUnit (
        symbol: "m",
        dimension: [.Length: 1]
    )
    static var foot = DefinedUnit (
        symbol: "ft",
        dimension: [.Length: 1]
    )
}
class UnitTime {
    static var second = DefinedUnit (
        symbol: "s",
        dimension: [.Time: 1]
    )
}
class UnitForce {
    static var newton = DefinedUnit (
        symbol: "N",
        dimension: [.Mass: 1, .Length: 1, .Time: -2]
    )
}

// TODO: Computed units should auto-calculate their symbol...
//class CompositeUnit: Unit {
//    let composedOf: [String: Int]
//
//    init(dimension: [BaseQuantity: Int]) {
//        super.init(dimension: dimension)
//    }
//}

/// Measurement models a value with a unit
struct Measurement {
    let value: Double
    let unit: Unit
    
    func multiply(by: Measurement) -> Measurement {
        return Measurement(
            value: self.value * by.value,
            unit: self.unit.multiply(by: by.unit)
        )
    }
    
    func divide(by: Measurement) -> Measurement {
        return Measurement(
            value: self.value / by.value,
            unit: self.unit.divide(by: by.unit)
        )
    }
}
