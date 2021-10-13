
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
    
    func baseUnit() -> DefinedUnit {
        switch self {
        case .Time:
            return UnitTime.second
        case .Length:
            return UnitLength.meter
        default:
            // TODO: Fix this when more units are added
            return UnitForce.newton
        }
    }
}

class Unit: CustomStringConvertible, Hashable {
    
    let dimension: [BaseQuantity: Int]
    
    init(dimension: [BaseQuantity: Int]) {
        self.dimension = dimension
    }
    
    var description: String {
        return dimension.description
    }
    
    static func == (lhs: Unit, rhs: Unit) -> Bool {
        return lhs.dimension == rhs.dimension
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
    
    static func * (lhs: Unit, rhs: Unit) -> CompositeUnit {
        var units: [Unit: Int] = [:]
        if lhs == rhs {
            units[lhs] = 2
        } else {
            units[lhs] = 1
            units[rhs] = 1
        }
        
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
        
        return CompositeUnit(units: units, dimension: newDimension)
    }
    
    static func / (lhs: Unit, rhs: Unit) -> Unit {
        var units: [Unit: Int] = [:]
        if lhs != rhs {
            units[lhs] = 1
            units[rhs] = -1
        }
        
        var newDimension: [BaseQuantity: Int] = [:]
        for base in BaseQuantity.allValues {
            if let expL = lhs.dimension[base], let expR = rhs.dimension[base] {
                let newExp = expL - expR
                if newExp != 0 {
                    newDimension[base] = newExp
                }
                // Don't add to newDimension at all if it zeros out
            } else if let expL = lhs.dimension[base] {
                newDimension[base] = expL
            } else if let expR = rhs.dimension[base] {
                newDimension[base] = -1 * expR
            }
        }
        
        return CompositeUnit(units: units, dimension: newDimension)
    }
}

// Hard-coded symbols are for predefined units.
class DefinedUnit: Unit {
    let symbol: String
    let baseConversion: (Double) -> Double
    
    init(symbol: String, dimension: [BaseQuantity: Int], baseConversion: @escaping (Double) -> Double = { $0 }) {
        self.symbol = symbol
        self.baseConversion = baseConversion
        super.init(dimension: dimension)
    }
    
    // TODO: We assume that desciption is completely unique. Perhaps create a unit registry to ensure this?
    override var description: String {
        return symbol
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
        dimension: [.Length: 1],
        baseConversion: { $0 * 0.3048 }
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
class CompositeUnit: Unit {
    let composedOf: [Unit: Int]

    init(units: [Unit: Int], dimension: [BaseQuantity: Int]) {
        composedOf = units
        super.init(dimension: dimension)
    }
}

/// Measurement models a value with a unit
struct Measurement {
    let value: Double
    let unit: Unit
    
//    func convertToBase() -> Measurement {
//
//    }
    
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
