@testable import Units
import XCTest

final class MeasurementTests: XCTestCase {
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
    }

    func testAdd() throws {
        let length1 = 5.measured(in: .meter)
        let length2 = 5.measured(in: .meter)
        XCTAssertEqual(
            try length1 + length2,
            10.measured(in: .meter)
        )

        XCTAssertThrowsError(
            try 5.measured(in: .meter) + 5.measured(in: .second)
        )
        
        var length3 = 3.measured(in: .meter)
        try length3 += length1
        
        XCTAssertEqual(
            length3,
            8.measured(in: .meter)
        )
    }

    func testSubtract() throws {
        let length1 = 5.measured(in: .meter)
        let length2 = 3.measured(in: .meter)
        XCTAssertEqual(
            try length1 - length2,
            2.measured(in: .meter)
        )

        XCTAssertThrowsError(
            try 5.measured(in: .meter) - 5.measured(in: .second)
        )
        
        var length3 = 8.measured(in: .meter)
        try length3 -= length1
        
        XCTAssertEqual(
            length3,
            3.measured(in: .meter)
        )
    }

    func testMultiply() throws {
        // Test the same unit
        let length1 = 5.measured(in: .meter)
        let length2 = 5.measured(in: .meter)
        XCTAssertEqual(
            length1 * length2,
            25.measured(in: .meter.pow(2))
        )

        // Test mixed units
        let force = 2.measured(in: .newton)
        let time = 7.measured(in: .second)
        XCTAssertEqual(
            force * time,
            14.measured(in: .newton * .second)
        )

        // Test composite units
        let work = 2.measured(in: .newton * .meter)
        XCTAssertEqual(
            work.unit.dimension,
            [.Mass: 1, .Length: 2, .Time: -2]
        )
    }

    func testDivide() throws {
        // Test the same unit
        let length = 8.measured(in: .meter)
        let time = 4.measured(in: .second)
        XCTAssertEqual(
            length / time,
            2.measured(in: .meter / .second)
        )
    }

    func testPow() throws {
        XCTAssertEqual(
            2.measured(in: .meter).pow(2),
            4.measured(in: .meter.pow(2))
        )
        XCTAssertEqual(
            2.measured(in: .meter).pow(3),
            8.measured(in: .meter.pow(3))
        )
    }

    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            2.measured(in: .meter)
                .isDimensionallyEquivalent(to: 2.measured(in: .meter))
        )
        XCTAssertTrue(
            2.measured(in: .meter)
                .isDimensionallyEquivalent(to: 4.measured(in: .meter))
        )
        XCTAssertTrue(
            2.measured(in: .newton)
                .isDimensionallyEquivalent(to: 4.measured(in: .kilogram * .meter / .second.pow(2)))
        )
    }

    func testConvert() throws {
        // Test defined unit conversion
        XCTAssertEqual(
            try 1.measured(in: .kilometer).convert(to: .meter),
            1000.measured(in: .meter)
        )
        XCTAssertEqual(
            try 1.measured(in: .kilowatt).convert(to: .horsepower),
            1.3410220895950278.measured(in: .horsepower)
        )

        // Test incompatible defined units error
        XCTAssertThrowsError(
            try 1.measured(in: .kilowatt).convert(to: .meter)
        )

        // Test composite unit conversion
        XCTAssertEqual(
            try 1.measured(in: .kilometer.pow(2)).convert(to: .meter.pow(2)),
            1_000_000.measured(in: .meter.pow(2))
        )
        XCTAssertEqual(
            try 1.measured(in: .meter.pow(2)).convert(to: .kilometer.pow(2)),
            0.000001.measured(in: .kilometer.pow(2))
        )
        XCTAssertEqual(
            try 1.measured(in: .meter / .second).convert(to: .foot / .minute),
            196.85039370078738.measured(in: .foot / .minute)
        )
        XCTAssertEqual(
            try 1.measured(in: .meter / .second.pow(2)).convert(to: .foot / .minute.pow(2)),
            11811.023622047243.measured(in: .foot / .minute.pow(2))
        )

        // Test mixed unit conversion
        XCTAssertEqual(
            try 1.measured(in: .newton).convert(to: .foot * .pound / .minute.pow(2)),
            26038.849864355616.measured(in: .foot * .pound / .minute.pow(2))
        )

        // Test incompatible composite units error
        XCTAssertThrowsError(
            try 1.measured(in: .meter / .second.pow(2)).convert(to: .foot / .minute)
        )

        // Test conversion with constant
        XCTAssertEqual(
            try 25.measured(in: .celsius).convert(to: .kelvin),
            298.15.measured(in: .kelvin)
        )
        XCTAssertEqual(
            try 0.measured(in: .celsius).convert(to: .fahrenheit),
            31.999999999999986.measured(in: .fahrenheit)
        )
        XCTAssertEqual(
            try 32.measured(in: .fahrenheit).convert(to: .celsius),
            0.measured(in: .celsius)
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
            2.measured(in: .meter)
        )
        XCTAssertEqual(
            2.measured(in: .meter),
            2.measured(in: .meter)
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
            1.measured(in: .foot)
        )
        
        // Test conversion to custom unit
        XCTAssertEqual(
            try 1.measured(in: .foot).convert(to: centifoot).value,
            100.measured(in: centifoot).value,
            accuracy: 0.01
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
            1.measured(in: centifoot)
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
            0.25.measured(in: .inch)
        )
        // Test typical usage
        XCTAssertEqual(
            try 25.measured(in: .centiinch).convert(to: .inch),
            0.25.measured(in: .inch)
        )
        // Try using twice to verify that multiple access doesn't error
        XCTAssertEqual(
            try 100.measured(in: .centiinch).convert(to: .inch),
            1.measured(in: .inch)
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
        XCTAssertEqual(
            Measurement("5.0 m"),
            5.measured(in: .meter)
        )
        
        XCTAssertEqual(
            Measurement("5 m"),
            5.measured(in: .meter)
        )

        XCTAssertEqual(
            Measurement("5 m/s"),
            5.measured(in: .meter / .second)
        )
        
        XCTAssertNil(
            Measurement("5 notAUnit")
        )
    }
}

extension Units.Unit {
    static let centiinch = try! Unit(fromSymbol: "cin")
}
