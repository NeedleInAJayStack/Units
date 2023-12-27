@testable import Units
import XCTest

final class MeasurementTests: XCTestCase {
    let accuracy = 1e-12

    func testEquals() throws {
        XCTAssertEqual(
            2.measured(in: .meter),
            2.measured(in: .meter)
        )
        XCTAssertNotEqual(
            2.measured(in: .meter),
            3.measured(in: .meter)
        )
        XCTAssertNotEqual(
            2.measured(in: .meter),
            2.measured(in: .foot)
        )
        XCTAssertNotEqual(
            2.measured(in: .meter),
            2.measured(in: .second)
        )
        XCTAssertNotEqual(
            2.measured(in: .meter),
            2
        )
    }

    func testAdd() throws {
        let length1 = 5.measured(in: .meter)
        let length2 = 5.measured(in: .meter)
        XCTAssertEqual(
            try length1 + length2,
            10.measured(in: .meter),
            accuracy: accuracy
        )

        XCTAssertThrowsError(
            try 5.measured(in: .meter) + 5.measured(in: .second)
        )
        XCTAssertThrowsError(
            try 5.measured(in: .meter) + 5
        )

        var length3 = 3.measured(in: .meter)
        try length3 += length1

        XCTAssertEqual(
            length3,
            8.measured(in: .meter),
            accuracy: accuracy
        )
    }

    func testSubtract() throws {
        let length1 = 5.measured(in: .meter)
        let length2 = 3.measured(in: .meter)
        XCTAssertEqual(
            try length1 - length2,
            2.measured(in: .meter),
            accuracy: accuracy
        )

        XCTAssertThrowsError(
            try 5.measured(in: .meter) - 5.measured(in: .second)
        )
        XCTAssertThrowsError(
            try 5.measured(in: .meter) - 5
        )

        var length3 = 8.measured(in: .meter)
        try length3 -= length1

        XCTAssertEqual(
            length3,
            3.measured(in: .meter),
            accuracy: accuracy
        )
    }

    func testMultiply() throws {
        // Test the same unit
        let length1 = 5.measured(in: .meter)
        let length2 = 5.measured(in: .meter)
        XCTAssertEqual(
            length1 * length2,
            25.measured(in: .meter.pow(2)),
            accuracy: accuracy
        )

        // Test mixed units
        let force = 2.measured(in: .newton)
        let time = 7.measured(in: .second)
        XCTAssertEqual(
            force * time,
            14.measured(in: .newton * .second),
            accuracy: accuracy
        )

        // Test composite units
        let work = 2.measured(in: .newton * .meter)
        let workUnit = try XCTUnwrap(work.unit)
        XCTAssertEqual(
            workUnit.dimension,
            [.Mass: 1, .Length: 2, .Time: -2]
        )

        // Test scalar multiplication
        XCTAssertEqual(
            6.measured(in: .meter) * 2,
            12.measured(in: .meter),
            accuracy: accuracy
        )
        XCTAssertEqual(
            6.measured(in: .meter) * 2.5,
            15.measured(in: .meter),
            accuracy: accuracy
        )

        // Test that cancelling units coerce to none
        XCTAssertEqual(
            6.measured(in: .meter.pow(-1)) * 3.measured(in: .meter),
            18,
            accuracy: accuracy
        )

        // Test *=
        var value = 2.measured(in: .meter)
        value *= length1

        XCTAssertEqual(
            value,
            10.measured(in: .meter.pow(2)),
            accuracy: accuracy
        )
    }

    func testDivide() throws {
        // Test the same unit
        let length = 8.measured(in: .meter)
        let time = 4.measured(in: .second)
        XCTAssertEqual(
            length / time,
            2.measured(in: .meter / .second),
            accuracy: accuracy
        )

        // Test scalar division
        XCTAssertEqual(
            6.measured(in: .meter) / 2,
            3.measured(in: .meter),
            accuracy: accuracy
        )
        XCTAssertEqual(
            6.measured(in: .meter) / 1.5,
            4.measured(in: .meter),
            accuracy: accuracy
        )

        // Test that cancelling units coerce to none
        XCTAssertEqual(
            6.measured(in: .meter) / 3.measured(in: .meter),
            2,
            accuracy: accuracy
        )

        // Test /=
        var value = 10.measured(in: .meter.pow(2))
        value /= 2.measured(in: .meter)

        XCTAssertEqual(
            value,
            5.measured(in: .meter),
            accuracy: accuracy
        )
    }

    func testPow() throws {
        XCTAssertEqual(
            2.measured(in: .meter).pow(2),
            4.measured(in: .meter.pow(2)),
            accuracy: accuracy
        )
        XCTAssertEqual(
            2.measured(in: .meter).pow(3),
            8.measured(in: .meter.pow(3)),
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
            try 1.measured(in: .mile / .mile) * 1.measured(in: .mile) - 1.measured(in: .mile),
            0.measured(in: .mile),
            accuracy: accuracy
        )

        XCTAssertEqual(
            try 0.measured(in: .mile) / 1.measured(in: .mile) + 1,
            1,
            accuracy: accuracy
        )

        XCTAssertEqual(
            try 0.measured(in: .none) + 0 + (1.measured(in: .mile) / 1.measured(in: .mile)),
            1,
            accuracy: accuracy
        )
    }

    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            2.measured(in: .meter).isDimensionallyEquivalent(
                to: 2.measured(in: .meter)
            )
        )
        XCTAssertTrue(
            2.measured(in: .meter).isDimensionallyEquivalent(
                to: 4.measured(in: .meter)
            )
        )
        XCTAssertTrue(
            2.measured(in: .newton).isDimensionallyEquivalent(
                to: 4.measured(in: .kilogram * .meter / .second.pow(2))
            )
        )

        // Test none comparisons
        XCTAssertTrue(
            2.measured(in: .none).isDimensionallyEquivalent(
                to: 4
            )
        )
        XCTAssertFalse(
            2.measured(in: .meter).isDimensionallyEquivalent(
                to: 4
            )
        )
        XCTAssertFalse(
            2.measured(in: .none).isDimensionallyEquivalent(
                to: 4.measured(in: .meter)
            )
        )
    }

    func testConvert() throws {
        // Test defined unit conversion
        XCTAssertEqual(
            try 1.measured(in: .kilometer).convert(to: .meter),
            1000.measured(in: .meter),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: .kilowatt).convert(to: .horsepower),
            1.3410220895950278.measured(in: .horsepower),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: .none).convert(to: .none),
            1,
            accuracy: accuracy
        )

        // Test incompatible defined units error
        XCTAssertThrowsError(
            try 1.measured(in: .kilowatt).convert(to: .meter)
        )
        XCTAssertThrowsError(
            try 1.measured(in: .none).convert(to: .meter)
        )

        // Test composite unit conversion
        XCTAssertEqual(
            try 1.measured(in: .kilometer.pow(2)).convert(to: .meter.pow(2)),
            1_000_000.measured(in: .meter.pow(2)),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: .meter.pow(2)).convert(to: .kilometer.pow(2)),
            0.000001.measured(in: .kilometer.pow(2)),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: .meter / .second).convert(to: .foot / .minute),
            196.85039370078738.measured(in: .foot / .minute),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 1.measured(in: .meter / .second.pow(2)).convert(to: .foot / .minute.pow(2)),
            11811.023622047243.measured(in: .foot / .minute.pow(2)),
            accuracy: accuracy
        )

        // Test mixed unit conversion
        XCTAssertEqual(
            try 1.measured(in: .newton).convert(to: .foot * .pound / .minute.pow(2)),
            26038.849864355616.measured(in: .foot * .pound / .minute.pow(2)),
            accuracy: accuracy
        )

        // Test incompatible composite units error
        XCTAssertThrowsError(
            try 1.measured(in: .meter / .second.pow(2)).convert(to: .foot / .minute)
        )

        // Test conversion with constant
        XCTAssertEqual(
            try 25.measured(in: .celsius).convert(to: .kelvin),
            298.15.measured(in: .kelvin),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 0.measured(in: .celsius).convert(to: .fahrenheit),
            31.999999999999986.measured(in: .fahrenheit),
            accuracy: accuracy
        )
        XCTAssertEqual(
            try 32.measured(in: .fahrenheit).convert(to: .celsius),
            0.measured(in: .celsius),
            accuracy: accuracy
        )

        // Test composite unit with constant cannot be converted
        XCTAssertThrowsError(
            try 25.measured(in: .meter * .celsius)
                .convert(to: .meter * .fahrenheit)
        )
    }

    func testNumericExtensions() throws {
        XCTAssertEqual(
            2.0.measured(in: .meter),
            2.measured(in: .meter),
            accuracy: accuracy
        )
        XCTAssertEqual(
            2.measured(in: .meter),
            2.measured(in: .meter),
            accuracy: accuracy
        )
    }

    func testUnitDefine() throws {
        let centifoot = try Unit.define(
            name: "centifoot",
            symbol: "cft",
            dimension: [.Length: 1],
            coefficient: 0.003048
        )

        // Test conversion from custom unit
        XCTAssertEqual(
            try 100.measured(in: centifoot).convert(to: .foot),
            1.measured(in: .foot),
            accuracy: accuracy
        )

        // Test conversion to custom unit
        XCTAssertEqual(
            try 1.measured(in: .foot).convert(to: centifoot),
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
    

    func testCompositeUnitDefine() throws {
        let ampereHour = try Unit.define(
            name: "ampereHour",
            symbol: "Ah",
            composedOf: [Unit.ampere: 1, Unit.hour: 1],
            coefficient: 3600
        )

        // Test conversion from custom unit
        XCTAssertEqual(
            try 1.measured(in: ampereHour).convert(to: .coulomb),
            3600.measured(in: .coulomb),
            accuracy: accuracy
        )

        // Test conversion to custom unit
        XCTAssertEqual(
            try 3600.measured(in: .coulomb).convert(to: ampereHour),
            1.measured(in: ampereHour),
            accuracy: accuracy
        )

        let ampereSquareMeters = try Unit.define(
            name: "ampereSquareMeters",
            symbol: "Am²",
            composedOf: [Unit.ampere: 1, Unit.meter: 2]
        )

        let joulePerTesla = try Unit.define(
            name: "ampereSquareMeters",
            symbol: "JT⁻¹",
            composedOf: [Unit.joule: 1, Unit.tesla: -1]
        )

        // Test conversion from custom unit
        XCTAssertEqual(
            try 1.measured(in: ampereSquareMeters).convert(to: joulePerTesla),
            1.measured(in: joulePerTesla),
            accuracy: accuracy
        )

        // Test conversion to custom unit
        XCTAssertEqual(
            try 1.measured(in: joulePerTesla).convert(to: ampereSquareMeters),
            1.measured(in: ampereSquareMeters),
            accuracy: accuracy
        )
    }

    func testUnitRegister() throws {
        try Unit.register(
            name: "centiinch",
            symbol: "cin",
            dimension: [.Length: 1],
            coefficient: 0.000254
        )
        // Test referencing string before running the extension
        XCTAssertEqual(
            try 25.measured(in: Unit(fromSymbol: "cin")).convert(to: .inch),
            0.25.measured(in: .inch),
            accuracy: accuracy
        )
        // Test typical usage
        XCTAssertEqual(
            try 25.measured(in: .centiinch).convert(to: .inch),
            0.25.measured(in: .inch),
            accuracy: accuracy
        )
        // Try using twice to verify that multiple access doesn't error
        XCTAssertEqual(
            try 100.measured(in: .centiinch).convert(to: .inch),
            1.measured(in: .inch),
            accuracy: accuracy
        )
    }

    func testCustomStringConvertible() throws {
        XCTAssertEqual(
            5.measured(in: .meter).description,
            "5.0 m"
        )

        XCTAssertEqual(
            5.measured(in: .meter / .second).description,
            "5.0 m/s"
        )
    }

    func testLosslessStringConvertible() throws {
        let length = 5.measured(in: .meter)
        XCTAssertEqual(
            Measurement(length.description),
            length
        )

        let velocity = 5.measured(in: .meter / .second)
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

        let personPickRate = 600.measured(in: apple / .day / person)
        let workforce = 4.measured(in: person)
        let weeklyCartons = try (workforce * personPickRate).convert(to: carton / .week)
        XCTAssertEqual(
            weeklyCartons,
            350.measured(in: carton / .week),
            accuracy: accuracy
        )
    }
}

extension Units.Unit {
    static let centiinch = try! Unit(fromSymbol: "cin")
}
