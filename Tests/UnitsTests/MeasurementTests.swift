@testable import Units
import XCTest

final class MeasurementTests: XCTestCase {
    let registry = UnitRegistry()
    let accuracy = 1e-12

    func testEquals() throws {
        XCTAssertEqual(
            2.measured(in: registry.meter),
            2.measured(in: registry.meter)
        )
        XCTAssertNotEqual(
            2.measured(in: registry.meter),
            3.measured(in: registry.meter)
        )
        XCTAssertNotEqual(
            2.measured(in: registry.meter),
            2.measured(in: registry.foot)
        )
        XCTAssertNotEqual(
            2.measured(in: registry.meter),
            2.measured(in: registry.second)
        )
        XCTAssertNotEqual(
            2.measured(in: registry.meter),
            2
        )
    }

    func testAdd() throws {
        let length1 = 5.measured(in: registry.meter)
        let length2 = 5.measured(in: registry.meter)
        XCTAssertEqual(
            try length1 + length2,
            10.measured(in: registry.meter),
            accuracy: accuracy
        )

        XCTAssertThrowsError(
            try 5.measured(in: registry.meter) + 5.measured(in: registry.second)
        )
        XCTAssertThrowsError(
            try 5.measured(in: registry.meter) + 5
        )

        var length3 = 3.measured(in: registry.meter)
        try length3 += length1

        XCTAssertEqual(
            length3,
            8.measured(in: registry.meter),
            accuracy: accuracy
        )
    }

    func testSubtract() throws {
        let length1 = 5.measured(in: registry.meter)
        let length2 = 3.measured(in: registry.meter)
        XCTAssertEqual(
            try length1 - length2,
            2.measured(in: registry.meter),
            accuracy: accuracy
        )

        XCTAssertThrowsError(
            try 5.measured(in: registry.meter) - 5.measured(in: registry.second)
        )
        XCTAssertThrowsError(
            try 5.measured(in: registry.meter) - 5
        )

        var length3 = 8.measured(in: registry.meter)
        try length3 -= length1

        XCTAssertEqual(
            length3,
            3.measured(in: registry.meter),
            accuracy: accuracy
        )
    }

    func testMultiply() throws {
        // Test the same unit
        let length1 = 5.measured(in: registry.meter)
        let length2 = 5.measured(in: registry.meter)
        XCTAssertEqual(
            length1 * length2,
            25.measured(in: registry.meter.pow(2)),
            accuracy: accuracy
        )

        // Test mixed units
        let force = 2.measured(in: registry.newton)
        let time = 7.measured(in: registry.second)
        XCTAssertEqual(
            force * time,
            14.measured(in: registry.newton * registry.second),
            accuracy: accuracy
        )

        // Test composite units
        let work = 2.measured(in: registry.newton * registry.meter)
        let workUnit = try XCTUnwrap(work.unit)
        XCTAssertEqual(
            workUnit.dimension,
            [.Mass: 1, .Length: 2, .Time: -2]
        )

        // Test scalar multiplication
        XCTAssertEqual(
            6.measured(in: registry.meter) * 2,
            12.measured(in: registry.meter),
            accuracy: accuracy
        )
        XCTAssertEqual(
            6.measured(in: registry.meter) * 2.5,
            15.measured(in: registry.meter),
            accuracy: accuracy
        )

        // Test that cancelling units coerce to none
        XCTAssertEqual(
            6.measured(in: registry.meter.pow(-1)) * 3.measured(in: registry.meter),
            18,
            accuracy: accuracy
        )

        // Test *=
        var value = 2.measured(in: registry.meter)
        value *= length1

        XCTAssertEqual(
            value,
            10.measured(in: registry.meter.pow(2)),
            accuracy: accuracy
        )
    }

    func testDivide() throws {
        // Test the same unit
        let length = 8.measured(in: registry.meter)
        let time = 4.measured(in: registry.second)
        XCTAssertEqual(
            length / time,
            2.measured(in: registry.meter / registry.second),
            accuracy: accuracy
        )

        // Test scalar division
        XCTAssertEqual(
            6.measured(in: registry.meter) / 2,
            3.measured(in: registry.meter),
            accuracy: accuracy
        )
        XCTAssertEqual(
            6.measured(in: registry.meter) / 1.5,
            4.measured(in: registry.meter),
            accuracy: accuracy
        )

        // Test that cancelling units coerce to none
        XCTAssertEqual(
            6.measured(in: registry.meter) / 3.measured(in: registry.meter),
            2,
            accuracy: accuracy
        )

        // Test /=
        var value = 10.measured(in: registry.meter.pow(2))
        value /= 2.measured(in: registry.meter)

        XCTAssertEqual(
            value,
            5.measured(in: registry.meter),
            accuracy: accuracy
        )
    }

    func testPow() throws {
        XCTAssertEqual(
            2.measured(in: registry.meter).pow(2),
            4.measured(in: registry.meter.pow(2)),
            accuracy: accuracy
        )
        XCTAssertEqual(
            2.measured(in: registry.meter).pow(3),
            8.measured(in: registry.meter.pow(3)),
            accuracy: accuracy
        )

        // Test that unitless exponentiation is unitless
        XCTAssertEqual(
            3.measured(in: .none).pow(2),
            9.measured(in: .none),
            accuracy: accuracy
        )
    }

    func testComplexArithmetic() throws {
        XCTAssertEqual(
            try 1.measured(in: registry.mile / registry.mile) * 1.measured(in: registry.mile) - 1.measured(in: registry.mile),
            0.measured(in: registry.mile),
            accuracy: accuracy
        )

        XCTAssertEqual(
            try 0.measured(in: registry.mile) / 1.measured(in: registry.mile) + 1,
            1,
            accuracy: accuracy
        )

        XCTAssertEqual(
            try 0.measured(in: .none) + 0 + (1.measured(in: registry.mile) / 1.measured(in: registry.mile)),
            1,
            accuracy: accuracy
        )
    }

    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            2.measured(in: registry.meter).isDimensionallyEquivalent(
                to: 2.measured(in: registry.meter)
            )
        )
        XCTAssertTrue(
            2.measured(in: registry.meter).isDimensionallyEquivalent(
                to: 4.measured(in: registry.meter)
            )
        )
        XCTAssertTrue(
            2.measured(in: registry.newton).isDimensionallyEquivalent(
                to: 4.measured(in: registry.kilogram * registry.meter / registry.second.pow(2))
            )
        )

        // Test none comparisons
        XCTAssertTrue(
            2.measured(in: .none).isDimensionallyEquivalent(
                to: 4
            )
        )
        XCTAssertFalse(
            2.measured(in: registry.meter).isDimensionallyEquivalent(
                to: 4
            )
        )
        XCTAssertFalse(
            2.measured(in: .none).isDimensionallyEquivalent(
                to: 4.measured(in: registry.meter)
            )
        )
    }

    func testConvert() throws {
        // Test defined unit conversion
        XCTAssertEqual(
            try 1.measured(in: registry.kilometer).convert(to: registry.meter),
            1000.measured(in: registry.meter),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: registry.kilowatt).convert(to: registry.horsepower),
            1.3410220895950278.measured(in: registry.horsepower),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: .none).convert(to: .none),
            1,
            accuracy: accuracy
        )

        // Test incompatible defined units error
        XCTAssertThrowsError(
            try 1.measured(in: registry.kilowatt).convert(to: registry.meter)
        )
        XCTAssertThrowsError(
            try 1.measured(in: .none).convert(to: registry.meter)
        )

        // Test composite unit conversion
        XCTAssertEqual(
            try 1.measured(in: registry.kilometer.pow(2)).convert(to: registry.meter.pow(2)),
            1_000_000.measured(in: registry.meter.pow(2)),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: registry.meter.pow(2)).convert(to: registry.kilometer.pow(2)),
            0.000001.measured(in: registry.kilometer.pow(2)),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: registry.meter / registry.second).convert(to: registry.foot / registry.minute),
            196.85039370078738.measured(in: registry.foot / registry.minute),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: registry.meter / registry.second.pow(2)).convert(to: registry.foot / registry.minute.pow(2)),
            11811.023622047243.measured(in: registry.foot / registry.minute.pow(2)),
            accuracy: accuracy
        )

        // Test mixed unit conversion
        XCTAssertEqual(
            try 1.measured(in: registry.newton).convert(to: registry.foot * registry.pound / registry.minute.pow(2)),
            26038.849864355616.measured(in: registry.foot * registry.pound / registry.minute.pow(2)),
            accuracy: accuracy
        )

        // Test incompatible composite units error
        XCTAssertThrowsError(
            try 1.measured(in: registry.meter / registry.second.pow(2)).convert(to: registry.foot / registry.minute)
        )

        // Test conversion with constant
        XCTAssertEqual(
            try 25.measured(in: registry.celsius).convert(to: registry.kelvin),
            298.15.measured(in: registry.kelvin),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 0.measured(in: registry.celsius).convert(to: registry.fahrenheit),
            31.999999999999986.measured(in: registry.fahrenheit),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 32.measured(in: registry.fahrenheit).convert(to: registry.celsius),
            0.measured(in: registry.celsius),
            accuracy: accuracy
        )

        // Test composite unit with constant cannot be converted
        XCTAssertThrowsError(
            try 25.measured(in: registry.meter * registry.celsius)
                .convert(to: registry.meter * registry.fahrenheit)
        )
    }

    func testNumericExtensions() throws {
        XCTAssertEqual(
            2.0.measured(in: registry.meter),
            2.measured(in: registry.meter),
            accuracy: accuracy
        )
        XCTAssertEqual(
            2.measured(in: registry.meter),
            2.measured(in: registry.meter),
            accuracy: accuracy
        )
    }

    func testUnitDefine() throws {
        let centifoot = try Unit.define(
            name: "centifoot",
            symbol: "cft",
            dimension: [Quantity.Length: 1],
            coefficient: 0.003048
        )

        // Test conversion from custom unit
        XCTAssertEqual(
            try 100.measured(in: centifoot).convert(to: registry.foot),
            1.measured(in: registry.foot),
            accuracy: accuracy
        )

        // Test conversion to custom unit
        XCTAssertEqual(
            try 1.measured(in: registry.foot).convert(to: centifoot),
            100.measured(in: centifoot),
            accuracy: accuracy
        )

        let centiinch = try Unit.define(
            name: "centiinch",
            symbol: "cin",
            dimension: [.Length: 1],
            coefficient: 0.000254
        )

        // Test conversion from a custom unit to a different custom unit
        XCTAssertEqual(
            try 12.measured(in: centiinch).convert(to: centifoot),
            1.measured(in: centifoot),
            accuracy: accuracy
        )

        // Test that definitions with bad characters are rejected
        XCTAssertThrowsError(
            try Unit.define(
                name: "no name",
                symbol: "",
                dimension: [.Amount: 1],
                coefficient: 1
            )
        )
        XCTAssertThrowsError(
            try Unit.define(
                name: "unit with space",
                symbol: "unit with space",
                dimension: [.Amount: 1],
                coefficient: 1
            )
        )
        XCTAssertThrowsError(
            try Unit.define(
                name: "slash",
                symbol: "/",
                dimension: [.Amount: 1],
                coefficient: 1
            )
        )
        XCTAssertThrowsError(
            try Unit.define(
                name: "star",
                symbol: "*",
                dimension: [.Amount: 1],
                coefficient: 1
            )
        )
        XCTAssertThrowsError(
            try Unit.define(
                name: "carrot",
                symbol: "^",
                dimension: [.Amount: 1],
                coefficient: 1
            )
        )
    }

    func testUnitRegister() throws {
        let centiinch = try registry.define(
            name: "centiinch",
            symbol: "cin",
            dimension: [.Length: 1],
            coefficient: 0.000254
        )
        // Test referencing string before running the extension
        XCTAssertEqual(
            try 25.measured(in: registry.unit(fromSymbol: "cin")).convert(to: registry.inch),
            0.25.measured(in: registry.inch),
            accuracy: accuracy
        )
        // Test typical usage
        XCTAssertEqual(
            try 25.measured(in: centiinch).convert(to: registry.inch),
            0.25.measured(in: registry.inch),
            accuracy: accuracy
        )
        // Try using twice to verify that multiple access doesn't error
        XCTAssertEqual(
            try 100.measured(in: centiinch).convert(to: registry.inch),
            1.measured(in: registry.inch),
            accuracy: accuracy
        )
    }

    func testCustomStringConvertible() throws {
        XCTAssertEqual(
            5.measured(in: registry.meter).description,
            "5.0 m"
        )

        XCTAssertEqual(
            5.measured(in: registry.meter / registry.second).description,
            "5.0 m/s"
        )
    }

    func testLosslessStringConvertible() throws {
        let length = 5.measured(in: registry.meter)
        XCTAssertEqual(
            Measurement(length.description),
            length
        )

        let velocity = 5.measured(in: registry.meter / registry.second)
        XCTAssertEqual(
            Measurement(velocity.description),
            velocity
        )

        let scalar = 5.measured(in: .none)
        XCTAssertEqual(
            Measurement(scalar.description),
            scalar
        )

        XCTAssertNil(
            Measurement("5 notAUnit")
        )

        XCTAssertEqual(
            try XCTUnwrap(Measurement("5 m/m")),
            5
        )
    }

    func testCustomUnitSystemExample() throws {
        let apple = try Unit.define(
            name: "apple",
            symbol: "apple",
            dimension: [.Amount: 1],
            coefficient: 1
        )

        let carton = try Unit.define(
            name: "carton",
            symbol: "carton",
            dimension: [.Amount: 1],
            coefficient: 48
        )

        let harvest = 288.measured(in: apple)
        XCTAssertEqual(
            try harvest.convert(to: carton),
            6.measured(in: carton),
            accuracy: accuracy
        )

        let person = try Unit.define(
            name: "person",
            symbol: "person",
            dimension: [.Amount: 1],
            coefficient: 1
        )

        let personPickRate = 600.measured(in: apple / registry.day / person)
        let workforce = 4.measured(in: person)
        let weeklyCartons = try (workforce * personPickRate).convert(to: carton / registry.week)
        XCTAssertEqual(
            weeklyCartons,
            350.measured(in: carton / registry.week),
            accuracy: accuracy
        )
    }
}

// extension UnitRegistry {
//    var centiinch = try self.unit(fromSymbol: "cin")
// }
