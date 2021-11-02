import Foundation

/// A double value with a unit of measure
public struct Measurement: Equatable {
    public let value: Double
    public let unit: Unit
    
    /// Indicates whether the measurement is dimensionally equivalent to the provided measurement.
    /// Note that measurements with different units can be dimensionally equivalent.
    public func isDimensionallyEquivalent(to: Measurement) -> Bool {
        return self.unit.isDimensionallyEquivalent(to: to.unit)
    }
    
    /// Return a measurement of the same value, but with the provided unit. That is,
    /// the value **is not mathematically converted**.
    public func declare(as newUnit: Unit) -> Measurement {
        return Measurement(value: value, unit: newUnit)
    }
    
    /// Convert this unit to the provided one, and return the result. The provided unit must
    /// be dimensionally equivalent to this measurement's unit.
    public func convert(to newUnit: Unit) throws -> Measurement {
        guard unit.isDimensionallyEquivalent(to: newUnit) else {
            throw UnitError.incompatibleUnits(message: "Cannot convert \(unit) to \(newUnit)")
        }
        let baseValue = try self.unit.toBaseUnit(self.value)
        let convertedValue = try newUnit.fromBaseUnit(baseValue)
        return Measurement(value: convertedValue, unit: newUnit)
    }
    
    /// Add the left side measurement to the right side measurement. The measurements must have the
    /// same unit.
    public static func + (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        guard lhs.unit == rhs.unit else {
            throw UnitError.incompatibleUnits(message: "Incompatible units: \(lhs.unit) != \(rhs.unit)")
        }
        
        return Measurement(
            value: lhs.value + rhs.value,
            unit: lhs.unit
        )
    }
    
    /// Subtract the left side measurement from the right side measurement The measurements must have the
    /// same unit.
    public static func - (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        guard lhs.unit == rhs.unit else {
            throw UnitError.incompatibleUnits(message: "Incompatible units: \(lhs.unit) != \(rhs.unit)")
        }
        
        return Measurement(
            value: lhs.value - rhs.value,
            unit: lhs.unit
        )
    }
    
    /// Multiply the left side measurement by the right side measurement.
    public static func * (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value * rhs.value,
            unit: lhs.unit * rhs.unit
        )
    }
    
    /// Divide the left side measurement by the right side measurement.
    public static func / (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value / rhs.value,
            unit: lhs.unit / rhs.unit
        )
    }
    
    /// Raise the measurement to an integer exponent. This will raise the unit
    /// to the same exponent.
    public func pow(_ raiseTo: Int) -> Measurement {
        return Measurement(
            value: Foundation.pow(self.value, Double(raiseTo)),
            unit: self.unit.pow(raiseTo)
        )
    }
}

extension Measurement: CustomStringConvertible {
    /// Displays the measurement as a string of the value and unit symbol
    public var description: String {
        return "\(value) \(unit)"
    }
}
