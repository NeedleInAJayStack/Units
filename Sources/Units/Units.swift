import Foundation

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
    
    func baseUnit() -> Unit {
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
    
    // Populated only on predefined units
    private let dimension: [BaseQuantity: Int]?
    let symbol: String?
    let baseConversion: ((Double) -> Double?)?
    
    // Populated only on composite units
    let subUnits: [Unit: Int]?
    
    private init(
        dimension: [BaseQuantity: Int]? = nil,
        symbol: String? = nil,
        baseConversion: ((Double) -> Double?)? = nil,
        subUnits: [Unit: Int]? = nil
    ) {
        self.dimension = dimension
        self.symbol = symbol
        self.baseConversion = baseConversion
        self.subUnits = subUnits
    }
    
    // Predefined unit
    convenience init(symbol: String, dimension: [BaseQuantity: Int], baseConversion: @escaping (Double) -> Double = { $0 }) {
        self.init(dimension: dimension, symbol: symbol, baseConversion: baseConversion)
    }
    
    // Composite unit
    private convenience init(composedOf: [Unit: Int]) {
        self.init(subUnits: composedOf)
    }
    
    // TODO: We assume that symbol is completely unique. Perhaps create a unit registry to ensure this?
    var description: String {
        if let symbol = symbol {
            return symbol
        } else {
            return dimension?.description ?? "nil"
        }
    }
    
    func getDimension() -> [BaseQuantity: Int] {
        if let dimension = self.dimension {
            return dimension
        } else if let subUnits = self.subUnits {
            var computedDimension: [BaseQuantity: Int] = [:]
            for (subUnit, exp) in subUnits {
                let subDimensions = subUnit.getDimension().mapValues { value in
                    exp * value
                }
                // Append or sum values into computed dimension
                for (subDimension, dimExp) in subDimensions {
                    if let computedDimensionExp = computedDimension[subDimension] {
                        computedDimension[subDimension] = computedDimensionExp + dimExp
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
    
    static func == (lhs: Unit, rhs: Unit) -> Bool {
        return lhs.dimension == rhs.dimension
    }
    
    // TODO: We assume that desciption is completely unique. Perhaps create a unit registry to ensure this?
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
    }
    
    static func * (lhs: Unit, rhs: Unit) -> Unit {
        var units: [Unit: Int] = [:]
        if lhs == rhs {
            units[lhs] = 2
        } else {
            units[lhs] = 1
            units[rhs] = 1
        }
        
        return Unit(composedOf: units)
    }
    
    static func / (lhs: Unit, rhs: Unit) -> Unit {
        var units: [Unit: Int] = [:]
        if lhs != rhs {
            units[lhs] = 1
            units[rhs] = -1
        }
        
        return Unit(composedOf: units)
    }
}

// Predefined units
// TODO: Make more
class UnitLength {
    static var meter = Unit (
        symbol: "m",
        dimension: [.Length: 1]
    )
    static var foot = Unit (
        symbol: "ft",
        dimension: [.Length: 1],
        baseConversion: { $0 * 0.3048 }
    )
}
class UnitTime {
    static var second = Unit (
        symbol: "s",
        dimension: [.Time: 1]
    )
}
class UnitForce {
    static var newton = Unit (
        symbol: "N",
        dimension: [.Mass: 1, .Length: 1, .Time: -2]
    )
}

/// Measurement models a value with a unit
struct Measurement {
    let value: Double
    let unit: Unit
    
//    func convertToBase() -> Measurement {
//
//    }
    
    static func + (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        // TODO: Change this to check unit instead of dimension
        guard lhs.unit.getDimension() == rhs.unit.getDimension() else {
            throw UnitError.incompatibleUnits(message: "Incompatible units")
        }
        
        return Measurement(
            value: lhs.value + rhs.value,
            unit: lhs.unit
        )
    }
    
    static func - (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        // TODO: Change this to check unit instead of dimension
        guard lhs.unit.getDimension() == rhs.unit.getDimension() else {
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
