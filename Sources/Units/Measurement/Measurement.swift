import Foundation

/// A numeric scalar value with a unit of measure
public struct Measurement: Equatable, Codable {
    public private(set) var value: Double
    public private(set) var unit: Unit

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
        try checkSameUnit(lhs, rhs)
        return Measurement(
            value: lhs.value + rhs.value,
            unit: lhs.unit
        )
    }

    /// Adds the measurements and stores the result in the left-hand-side variable. The measurements must have the same unit.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    public static func += (lhs: inout Measurement, rhs: Measurement) throws {
        try checkSameUnit(lhs, rhs)
        lhs.value = lhs.value + rhs.value
    }

    /// Subtract one measurement from another. The measurements must have the same unit.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    /// - Returns: A new measurement with the subtracted scalar values and the same unit of measure
    /// and the same unit of measure
    public static func - (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        try checkSameUnit(lhs, rhs)
        return Measurement(
            value: lhs.value - rhs.value,
            unit: lhs.unit
        )
    }

    /// Subtracts the measurements and stores the result in the left-hand-side variable. The measurements must have the same unit.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    public static func -= (lhs: inout Measurement, rhs: Measurement) throws {
        try checkSameUnit(lhs, rhs)
        lhs.value = lhs.value - rhs.value
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

    /// Multiplies the measurements and stores the result in the left-hand-side variable. The measurements may have different units.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    public static func *= (lhs: inout Measurement, rhs: Measurement) {
        lhs.value = lhs.value * rhs.value
        lhs.unit = lhs.unit * rhs.unit
    }

    /// Divide the measurements. The measurements may have different units.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    /// - Returns: A new measurement with the divided scalar value and a combined unit of measure
    public static func / (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value / rhs.value,
            unit: lhs.unit / rhs.unit
        )
    }

    /// Divide the measurements and stores the result in the left-hand-side variable. The measurements may have different units.
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    public static func /= (lhs: inout Measurement, rhs: Measurement) {
        lhs.value = lhs.value / rhs.value
        lhs.unit = lhs.unit / rhs.unit
    }

    /// Exponentiate the measurement. This is equavalent to multiple `*` operations.
    /// - Parameter raiseTo: The exponent to raise the measurement to
    /// - Returns: A new measurement with an exponentiated scalar value and an exponentiated unit of measure
    public func pow(_ raiseTo: Fraction) -> Measurement {
        return Measurement(
            value: Foundation.pow(value, raiseTo.asDouble),
            unit: unit.pow(raiseTo)
        )
    }

    private static func checkSameUnit(_ lhs: Measurement, _ rhs: Measurement) throws {
        guard lhs.unit == rhs.unit else {
            throw UnitError.incompatibleUnits(message: "Incompatible units: \(lhs.unit) != \(rhs.unit)")
        }
    }
}

extension Measurement: CustomStringConvertible {
    /// Displays the measurement as a string of the value and unit symbol
    public var description: String {
        if unit == .none {
            return "\(value)"
        } else {
            return "\(value) \(unit)"
        }
    }
}

extension Measurement: LosslessStringConvertible {
    public init?(_ description: String) {
        let valueEndIndex = description.firstIndex(of: " ") ?? description.endIndex
        guard let value = Double(description[..<valueEndIndex]) else {
            return nil
        }
        self.value = value

        if valueEndIndex != description.endIndex {
            guard let unit = Unit(String(
                description[description.index(after: valueEndIndex) ..< description.endIndex]
            )) else {
                return nil
            }
            self.unit = unit
        } else {
            unit = .none
        }
    }
}

extension Measurement: Hashable {}

extension Measurement: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int64) {
        self = Self(value: Double(value), unit: .none)
    }

    public typealias IntegerLiteralType = Int64
}

extension Measurement: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = Self(value: value, unit: .none)
    }

    public typealias FloatLiteralType = Double
}

extension Measurement: Sendable {}
