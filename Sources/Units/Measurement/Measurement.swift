import Foundation

/// A numeric scalar value with a unit of measure
public struct Measurement: Equatable, Codable {
    public let value: Double
    public let unit: Unit
    
    /// Create a new measurement
    /// - Parameters:
    ///   - value: The magnitude of the measurement
    ///   - unit: The unit of measure
    public init(
        value: Double,
        unit: Unit
    ) {
        self.value = value
        self.unit = unit
    }

    /// Indicates whether the measurement is dimensionally equivalent to the provided measurement.
    /// Note that measurements with different units can be dimensionally equivalent.
    /// - Parameter to: The measurement to compare
    /// - Returns: Bool indicating whether the units have the same dimensions
    public func isDimensionallyEquivalent(to: Measurement) -> Bool {
        return unit.isDimensionallyEquivalent(to: to.unit)
    }

    /// Force the measurement to have the provided unit, but the same scalar value. That is,
    /// the value **is not mathematically converted**.
    /// - Parameter newUnit: The unit to apply to the measurement
    /// - Returns: A new measurement with the same scalar value but the provided unit of measure
    public func declare(as newUnit: Unit) -> Measurement {
        return Measurement(value: value, unit: newUnit)
    }

    /// Convert this measurement to the provided unit by adjusting the scalar value and unit of measure.
    /// The provided unit must be dimensionally equivalent to this measurement's unit.
    /// - Parameter newUnit: The unit to convert this measurement to
    /// - Returns: A new measurement with the converted scalar value and provided unit of measure
    public func convert(to newUnit: Unit) throws -> Measurement {
        guard unit.isDimensionallyEquivalent(to: newUnit) else {
            throw UnitError.incompatibleUnits(message: "Cannot convert \(unit) to \(newUnit)")
        }
        let baseValue = try unit.toBaseUnit(value)
        let convertedValue = try newUnit.fromBaseUnit(baseValue)
        return Measurement(value: convertedValue, unit: newUnit)
    }

    /// Add the measurements. The measurements must have the same unit.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    /// - Returns: A new measurement with the summed scalar values and the same unit of measure
    public static func + (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        guard lhs.unit == rhs.unit else {
            throw UnitError.incompatibleUnits(message: "Incompatible units: \(lhs.unit) != \(rhs.unit)")
        }

        return Measurement(
            value: lhs.value + rhs.value,
            unit: lhs.unit
        )
    }

    /// Subtract one measurement from another. The measurements must have the same unit.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    /// - Returns: A new measurement with a scalar value of the left-hand-side value minus the right-hand-side value
    /// and the same unit of measure
    public static func - (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        guard lhs.unit == rhs.unit else {
            throw UnitError.incompatibleUnits(message: "Incompatible units: \(lhs.unit) != \(rhs.unit)")
        }

        return Measurement(
            value: lhs.value - rhs.value,
            unit: lhs.unit
        )
    }

    /// Multiply the measurements. The measurements may have different units.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    /// - Returns: A new measurement with the multiplied scalar values and a combined unit of measure
    public static func * (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value * rhs.value,
            unit: lhs.unit * rhs.unit
        )
    }

    /// Divide the measurements. The measurements may have different units.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    /// - Returns: A new measurement with a scalar value of the left-hand-side value divided by the right-hand-side value
    /// and a combined unit of measure
    public static func / (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value / rhs.value,
            unit: lhs.unit / rhs.unit
        )
    }

    /// Exponentiate the measurement. This is equavalent to multiple `*` operations.
    /// - Parameter raiseTo: The exponent to raise the measurement to
    /// - Returns: A new measurement with an exponentiated scalar value and an exponentiated unit of measure
    public func pow(_ raiseTo: Int) -> Measurement {
        return Measurement(
            value: Foundation.pow(value, Double(raiseTo)),
            unit: unit.pow(raiseTo)
        )
    }
}

extension Measurement: CustomStringConvertible {
    /// Displays the measurement as a string of the value and unit symbol
    public var description: String {
        return "\(value) \(unit)"
    }
}

extension Measurement: LosslessStringConvertible {
    public init?(_ description: String) {
        guard
            let spaceIndex = description.firstIndex(of: " "),
            let value = Double(description[..<spaceIndex]),
            let unit = Unit(String(
                description[description.index(after: spaceIndex)..<description.endIndex]
            ))
        else {
            return nil
        }
        self.value = value
        self.unit = unit
    }
}

extension Measurement: Hashable {}

extension Measurement: Sendable {}
