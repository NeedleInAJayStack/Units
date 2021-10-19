import Foundation

/// Models a value with a unit
struct Measurement: Equatable {
    let value: Double
    let unit: Unit
    
    public func isDimensionallyEquivalent(to: Measurement) -> Bool {
        return self.unit.isDimensionallyEquivalent(to: to.unit)
    }
    
    func pow(_ raiseTo: Int) -> Measurement {
        return Measurement(
            value: Foundation.pow(self.value, Double(raiseTo)),
            unit: self.unit.pow(raiseTo)
        )
    }
    
    func convert(to newUnit: Unit) throws -> Measurement {
        guard unit.isDimensionallyEquivalent(to: newUnit) else {
            throw UnitsError.incompatibleUnits(message: "Cannot convert \(unit) to \(newUnit)")
        }
        let baseValue = self.unit.toBaseUnit(self.value)
        let convertedValue = newUnit.fromBaseUnit(baseValue)
        return Measurement(value: convertedValue, unit: newUnit)
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

extension Measurement: CustomStringConvertible {
    var description: String {
        return "\(value)\(unit)"
    }
}
