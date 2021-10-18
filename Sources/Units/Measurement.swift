import Foundation

/// Models a value with a unit
struct Measurement {
    let value: Double
    let unit: Unit
    
    func pow(_ raiseTo: Int) -> Measurement {
        return Measurement(
            value: Foundation.pow(self.value, Double(raiseTo)),
            unit: self.unit.pow(raiseTo)
        )
    }
    
    static func + (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        guard lhs.unit == rhs.unit else {
            throw UnitsError.incompatibleUnits(message: "Incompatible units: \(lhs.unit) != \(rhs.unit)")
        }
        
        return Measurement(
            value: lhs.value + rhs.value,
            unit: lhs.unit
        )
    }
    
    static func - (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        guard lhs.unit == rhs.unit else {
            throw UnitsError.incompatibleUnits(message: "Incompatible units: \(lhs.unit) != \(rhs.unit)")
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

