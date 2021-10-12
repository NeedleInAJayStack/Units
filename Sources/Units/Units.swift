
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
    
    static func * (lhs: Unit, rhs: Unit) -> Unit {
        var newDimension: [BaseQuantity: Int] = [:]
        // TODO: Optimize this. Can we avoid going through every BaseQuantity case?
        for base in BaseQuantity.allValues {
            if let expL = lhs.dimension[base], let expR = rhs.dimension[base] {
                newDimension[base] = expL + expR
            } else if let expL = lhs.dimension[base] {
                newDimension[base] = expL
            } else if let expR = rhs.dimension[base] {
                newDimension[base] = expR
            }
        }
        
        return Unit(dimension: newDimension)
    }
    
    static func / (lhs: Unit, rhs: Unit) -> Unit {
        var newDimension: [BaseQuantity: Int] = [:]
        for base in BaseQuantity.allValues {
            if let exp1 = lhs.dimension[base], let exp2 = rhs.dimension[base] {
                let newExp = exp1 - exp2
                if newExp != 0 {
                    newDimension[base] = newExp
                }
                // Don't add to newDimension at all if it zeros out
            } else if let exp1 = lhs.dimension[base] {
                newDimension[base] = exp1
            } else if let exp2 = rhs.dimension[base] {
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

// Predefined units
// TODO: Make more
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
    
    static func + (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        guard lhs.unit.dimension == rhs.unit.dimension else {
            throw UnitError.incompatibleUnits(message: "Incompatible units")
        }
        
        return Measurement(
            value: lhs.value + rhs.value,
            unit: lhs.unit
        )
    }
    
    static func - (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        guard lhs.unit.dimension == rhs.unit.dimension else {
            throw UnitError.incompatibleUnits(message: "Incompatible units")
        }
        
        return Measurement(
            value: lhs.value - rhs.value,
            unit: lhs.unit
        )
    }
    
    static func * (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value * rhs.value,
            unit: lhs.unit * rhs.unit
        )
    }
    
    static func / (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value / rhs.value,
            unit: lhs.unit / rhs.unit
        )
    }
}

enum UnitError: Error {
    case incompatibleUnits(message: String)
}
