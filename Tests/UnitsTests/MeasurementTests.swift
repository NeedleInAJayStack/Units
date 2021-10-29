import XCTest
@testable import Units

final class MeasurementTests: XCTestCase {
    func testEquals() throws {
        XCTAssertEqual(
            Measurement(value: 2, unit: .meter),
            Measurement(value: 2, unit: .meter)
        )
        XCTAssertNotEqual(
            Measurement(value: 2, unit: .meter),
            Measurement(value: 3, unit: .meter)
        )
        XCTAssertNotEqual(
            Measurement(value: 2, unit: .meter),
            Measurement(value: 2, unit: .foot)
        )
        XCTAssertNotEqual(
            Measurement(value: 2, unit: .meter),
            Measurement(value: 2, unit: .second)
        )
    }
    
    func testAdd() throws {
        let length1 = Measurement(value: 5, unit: .meter)
        let length2 = Measurement(value: 5, unit: .meter)
        XCTAssertEqual(
            try length1 + length2,
            Measurement(value: 10, unit: .meter)
        )
        
        XCTAssertThrowsError(
            try Measurement(value: 5, unit: .meter) + Measurement(value: 5, unit: .second)
        )
    }
    
    func testSubtract() throws {
        let length1 = Measurement(value: 5, unit: .meter)
        let length2 = Measurement(value: 3, unit: .meter)
        XCTAssertEqual(
            try length1 - length2,
            Measurement(value: 2, unit: .meter)
        )
        
        XCTAssertThrowsError(
            try Measurement(value: 5, unit: .meter) - Measurement(value: 5, unit: .second)
        )
    }
    
    func testMultiply() throws {
        // Test the same unit
        let length1 = Measurement(value: 5, unit: .meter)
        let length2 = Measurement(value: 5, unit: .meter)
        XCTAssertEqual(
            length1 * length2,
            Measurement(value: 25, unit: .meter.pow(2))
        )
        
        // Test mixed units
        let force = Measurement(value: 2, unit: .newton)
        let time = Measurement(value: 7, unit: .second)
        XCTAssertEqual(
            force * time,
            Measurement(value: 14, unit: .newton * .second)
        )
        
        // Test composite units
        let work = Measurement(value: 2, unit: .newton * .meter)
        XCTAssertEqual(
            work.unit.dimension,
            [.Mass: 1, .Length: 2, .Time: -2]
        )
    }
    
    func testDivide() throws {
        // Test the same unit
        let length = Measurement(value: 8, unit: .meter)
        let time = Measurement(value: 4, unit: .second)
        XCTAssertEqual(
            length / time,
            Measurement(value: 2, unit: .meter / .second)
        )
    }
    
    func testPow() throws {
        XCTAssertEqual(
            Measurement(value: 2, unit: .meter).pow(2),
            Measurement(value: 4, unit: .meter.pow(2))
        )
        XCTAssertEqual(
            Measurement(value: 2, unit: .meter).pow(3),
            Measurement(value: 8, unit: .meter.pow(3))
        )
    }
    
    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            Measurement(value: 2, unit: .meter)
                .isDimensionallyEquivalent(to: Measurement(value: 2, unit: .meter))
        )
        XCTAssertTrue(
            Measurement(value: 2, unit: .meter)
                .isDimensionallyEquivalent(to: Measurement(value: 4, unit: .meter))
        )
        XCTAssertTrue(
            Measurement(value: 2, unit: .newton)
                .isDimensionallyEquivalent(to: Measurement(value: 4, unit: .kilogram * .meter / .second.pow(2)))
        )
    }
    
    func testConvert() throws {
        // Test defined unit conversion
        XCTAssertEqual(
            try Measurement(value: 1, unit: .kilometer).convert(to: .meter),
            Measurement(value: 1000, unit: .meter)
        )
        XCTAssertEqual(
            try Measurement(value: 1, unit: .kilowatt).convert(to: .horsepower),
            Measurement(value: 1.3410220895950278, unit: .horsepower)
        )
        
        // Test incompatible defined units error
        XCTAssertThrowsError(
            try Measurement(value: 1, unit: .kilowatt).convert(to: .meter)
        )
        
        // Test composite unit conversion
        XCTAssertEqual(
            try Measurement(value: 1, unit: .kilometer.pow(2)).convert(to: .meter.pow(2)),
            Measurement(value: 1000000, unit: .meter.pow(2))
        )
        XCTAssertEqual(
            try Measurement(value: 1, unit: .meter.pow(2)).convert(to: .kilometer.pow(2)),
            Measurement(value: 0.000001, unit: .kilometer.pow(2))
        )
        XCTAssertEqual(
            try Measurement(value: 1, unit: .meter / .second).convert(to: .foot / .minute),
            Measurement(value: 196.85039370078738, unit: .foot / .minute)
        )
        XCTAssertEqual(
            try Measurement(value: 1, unit: .meter / .second.pow(2)).convert(to: .foot / .minute.pow(2)),
            Measurement(value: 11811.023622047243, unit: .foot / .minute.pow(2))
        )
        
        // Test mixed unit conversion
        XCTAssertEqual(
            try Measurement(value: 1, unit: .newton).convert(to: .foot * .pound / .minute.pow(2)),
            Measurement(value: 26038.849864355616, unit: .foot * .pound / .minute.pow(2))
        )
        
        // Test incompatible composite units error
        XCTAssertThrowsError(
            try Measurement(value: 1, unit: .meter / .second.pow(2)).convert(to: .foot / .minute)
        )
        
        // Test conversion with constant
        XCTAssertEqual(
            try Measurement(value: 25, unit: .celsius).convert(to: .kelvin),
            Measurement(value: 298.15, unit: .kelvin)
        )
        XCTAssertEqual(
            try Measurement(value: 0, unit: .celsius).convert(to: .fahrenheit),
            Measurement(value: 31.999999999999986, unit: .fahrenheit)
        )
        XCTAssertEqual(
            try Measurement(value: 32, unit: .fahrenheit).convert(to: .celsius),
            Measurement(value: 0, unit: .celsius)
        )
        
        // Test composite unit with constant cannot be converted
        XCTAssertThrowsError(
            try Measurement(value: 25, unit: .meter * .celsius)
                .convert(to: .meter * .fahrenheit)
        )
    }
}
