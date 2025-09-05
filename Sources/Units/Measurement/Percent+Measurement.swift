//
//  Percent.swift
//  Units
//
//  Created by Jason Jobe on 9/5/25.
//

import Foundation
/*
 NOTE: Should consider introducing `protocol Scalar`
 based on `VectorArithmetic`
 */

/**
 Math operators with percentages treat the percent as its decimal equivalent (e.g., 25% = 0.25)
 but in the case of `+` and `-` the calculation is less direct.
 
 Here’s how math operators work with percentages in typical calculations:
 
 Multiplication (100 * 25%)
 
 When you multiply a number by a percentage, you’re finding that percent of the number.
 • 25% is the same as 0.25.
 • So, 100 * 25% = 100 * 0.25 = 25.
 
 Division (100 / 30%)
 
 Dividing by a percentage means dividing by its decimal form.
 • 30% is 0.3.
 • So, 100 / 30% = 100 / 0.3 ≈ 333.33.
 
 Addition (100 + 10%)
 
 Adding a percentage to a number is less direct, but usually means increasing the number by that percent.
 • 10% of 100 is 10.
 • So, 100 + 10% = 100 + (100 * 0.10) = 110.
 
 General Rule
 • Percent means “per hundred,” so 25% = 25/100 = 0.25.
 • Replace the percent with its decimal equivalent before performing the operation.
 
 Example Table
 ===========
 Expression    Decimal Form           Result
 ------------------------------
 100 * 25%     100 * 0.25                25
 100 / 30%      100 / 0.3                   333.33
 100 + 10%     100 + (100*0.10)     110
 
 
 If you see a percent sign in a calculation, just convert it to a decimal and proceed as usual. If you want to know how subtraction works with percentages, or how to handle more complex expressions, let me know!
 */
public struct Percent: Numeric, Equatable, Codable {
    
    public private(set) var magnitude: Double
    
    /// Create a new Percent
    /// - Parameters:
    ///   - value: The magnitude of the percent
    public init(
        magnitude: Double
    ) {
        self.magnitude = magnitude
    }
    
    func percent(of measure: Measurement) -> Measurement {
        .init(value: magnitude * measure.value, unit: measure.unit)
    }
    
    func percent(of other: Double) -> Double {
        magnitude * other
    }
}

// MARK: Percent as Unit
extension Percent {
    public var unit: Unit { Self.unit }
    
    public static let unit = Unit(
        definedBy: try! DefinedUnit(
        name: "percent",
        symbol: "%",
        dimension: [:],
        coefficient: 0.01
    ))
}

// MARK: Numeric Conformance
public extension Percent {
    init(integerLiteral value: Double) {
        magnitude = value
    }
    
    static func *= (lhs: inout Percent, rhs: Percent) {
        lhs.magnitude *= rhs.magnitude
    }
    
    static func - (lhs: Percent, rhs: Percent) -> Percent {
        Percent(magnitude: lhs.magnitude - rhs.magnitude)
    }
    
    init?<T>(exactly source: T) where T : BinaryInteger {
        magnitude = Double(source)
    }
    
    static func * (lhs: Percent, rhs: Percent) -> Percent {
        Percent(magnitude: lhs.magnitude * rhs.magnitude)
    }
    
    static func + (lhs: Percent, rhs: Percent) -> Percent {
        Percent(magnitude: lhs.magnitude + rhs.magnitude)
    }
}

postfix operator %

extension BinaryInteger {
    public static postfix func % (value: Self) -> Percent {
        Percent(magnitude: Double(value)/100)
    }
}

extension BinaryFloatingPoint {
    public static postfix func % (value: Self) -> Percent {
        Percent(magnitude: Double(value)/100)
    }
}

// AdditiveArithmetic operations `*` and `/`

public extension Measurement {
    /// Calculate the percentage of the Measurement
    /// - Parameters:
    ///   - lhs: The left-hand-side measurement
    ///   - rhs: The right-hand-side measurement
    /// - Returns: A new measurement with the summed scalar values and the same unit of measure
    @_disfavoredOverload
    static func + (lhs: Measurement, rhs: Percent) -> Measurement {
        return Measurement(
            value: lhs.value + rhs.percent(of: lhs.value),
            unit: lhs.unit
        )
    }
    
    @_disfavoredOverload
    static func - (lhs: Measurement, rhs: Percent) -> Measurement {
        return Measurement(
            value: lhs.value - rhs.percent(of: lhs.value),
            unit: lhs.unit
        )
    }
    
    @_disfavoredOverload
    static func += (lhs: inout Measurement, rhs: Percent) {
        lhs = lhs + rhs
    }

    @_disfavoredOverload
    static func -= (lhs: inout Measurement, rhs: Percent) {
        lhs = lhs - rhs
    }

}

// Scalar operations `*` and `/`
public extension Measurement {
    
    @_disfavoredOverload
    static func * (lhs: Measurement, rhs: Percent) -> Measurement {
        return Measurement(
            value: lhs.value * rhs.magnitude,
            unit: lhs.unit
        )
    }

    @_disfavoredOverload
    static func / (lhs: Measurement, rhs: Percent) -> Measurement {
        return Measurement(
            value: lhs.value / rhs.magnitude,
            unit: lhs.unit
        )
    }

}
