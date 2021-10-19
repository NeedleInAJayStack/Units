import XCTest
@testable import Units

final class MeasurementTests: XCTestCase {
    func testEquals() throws {
        XCTAssertEqual(
            Measurement(value: 2, unit: UnitLength.meter),
            Measurement(value: 2, unit: UnitLength.meter)
        )
        XCTAssertNotEqual(
            Measurement(value: 2, unit: UnitLength.meter),
            Measurement(value: 3, unit: UnitLength.meter)
        )
        XCTAssertNotEqual(
            Measurement(value: 2, unit: UnitLength.meter),
            Measurement(value: 2, unit: UnitLength.foot)
        )
        XCTAssertNotEqual(
            Measurement(value: 2, unit: UnitLength.meter),
            Measurement(value: 2, unit: UnitTime.second)
        )
    }
    
    func testAdd() throws {
        let length1 = Measurement(value: 5, unit: UnitLength.meter)
        let length2 = Measurement(value: 5, unit: UnitLength.meter)
        XCTAssertEqual(
            try length1 + length2,
            Measurement(value: 10, unit: UnitLength.meter)
        )
        
        XCTAssertThrowsError(
            try Measurement(value: 5, unit: UnitLength.meter) + Measurement(value: 5, unit: UnitTime.second)
        )
    }
    
    func testSubtract() throws {
        let length1 = Measurement(value: 5, unit: UnitLength.meter)
        let length2 = Measurement(value: 3, unit: UnitLength.meter)
        XCTAssertEqual(
            try length1 - length2,
            Measurement(value: 2, unit: UnitLength.meter)
        )
        
        XCTAssertThrowsError(
            try Measurement(value: 5, unit: UnitLength.meter) - Measurement(value: 5, unit: UnitTime.second)
        )
    }
    
    func testMultiply() throws {
        // Test the same unit
        let length1 = Measurement(value: 5, unit: UnitLength.meter)
        let length2 = Measurement(value: 5, unit: UnitLength.meter)
        XCTAssertEqual(
            length1 * length2,
            Measurement(value: 25, unit: UnitLength.meter.pow(2))
        )
        
        // Test mixed units
        let force = Measurement(value: 2, unit: UnitForce.newton)
        let time = Measurement(value: 7, unit: UnitTime.second)
        XCTAssertEqual(
            force * time,
            Measurement(value: 14, unit: UnitForce.newton * UnitTime.second)
        )
        
        // Test composite units
        let work = Measurement(value: 2, unit: UnitForce.newton * UnitLength.meter)
        XCTAssertEqual(
            work.unit.getDimension(),
            [.Mass: 1, .Length: 2, .Time: -2]
        )
    }
    
    func testDivide() throws {
        // Test the same unit
        let length = Measurement(value: 8, unit: UnitLength.meter)
        let time = Measurement(value: 4, unit: UnitTime.second)
        XCTAssertEqual(
            length / time,
            Measurement(value: 2, unit: UnitLength.meter / UnitTime.second)
        )
    }
    
    func testPow() throws {
        XCTAssertEqual(
            Measurement(value: 2, unit: UnitLength.meter).pow(2),
            Measurement(value: 4, unit: UnitLength.meter.pow(2))
        )
        XCTAssertEqual(
            Measurement(value: 2, unit: UnitLength.meter).pow(3),
            Measurement(value: 8, unit: UnitLength.meter.pow(3))
        )
    }
    
    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            Measurement(value: 2, unit: UnitLength.meter)
                .isDimensionallyEquivalent(to: Measurement(value: 2, unit: UnitLength.meter))
        )
        XCTAssertTrue(
            Measurement(value: 2, unit: UnitLength.meter)
                .isDimensionallyEquivalent(to: Measurement(value: 4, unit: UnitLength.meter))
        )
        XCTAssertTrue(
            Measurement(value: 2, unit: UnitForce.newton)
                .isDimensionallyEquivalent(to: Measurement(value: 4, unit: UnitMass.kilogram * UnitLength.meter / UnitTime.second.pow(2)))
        )
    }
    
    func testConvert() throws {
        // Test defined unit conversion
        XCTAssertEqual(
            try Measurement(value: 1, unit: UnitLength.kilometer).convert(to: UnitLength.meter),
            Measurement(value: 1000, unit: UnitLength.meter)
        )
        XCTAssertEqual(
            try Measurement(value: 1, unit: UnitPower.kilowatt).convert(to: UnitPower.horsepower),
            Measurement(value: 1.3410220895950278, unit: UnitPower.horsepower)
        )
        
        // Test incompatible defined units error
        XCTAssertThrowsError(
            try Measurement(value: 1, unit: UnitPower.kilowatt).convert(to: UnitLength.meter)
        )
        
        // Test composite unit conversion
        XCTAssertEqual(
            try Measurement(value: 1, unit: UnitLength.kilometer.pow(2)).convert(to: UnitLength.meter.pow(2)),
            Measurement(value: 1000000, unit: UnitLength.meter.pow(2))
        )
        XCTAssertEqual(
            try Measurement(value: 1, unit: UnitLength.meter.pow(2)).convert(to: UnitLength.kilometer.pow(2)),
            Measurement(value: 0.000001, unit: UnitLength.kilometer.pow(2))
        )
        XCTAssertEqual(
            try Measurement(value: 1, unit: UnitLength.meter / UnitTime.second).convert(to: UnitLength.foot / UnitTime.minute),
            Measurement(value: 196.85039370078738, unit: UnitLength.foot / UnitTime.minute)
        )
        XCTAssertEqual(
            try Measurement(value: 1, unit: UnitLength.meter / UnitTime.second.pow(2)).convert(to: UnitLength.foot / UnitTime.minute.pow(2)),
            Measurement(value: 11811.023622047243, unit: UnitLength.foot / UnitTime.minute.pow(2))
        )
        
        // Test mixed unit conversion
        XCTAssertEqual(
            try Measurement(value: 1, unit: UnitForce.newton).convert(to: UnitLength.foot * UnitMass.pound / UnitTime.minute.pow(2)),
            Measurement(value: 26038.849864355616, unit: UnitLength.foot * UnitMass.pound / UnitTime.minute.pow(2))
        )
        
        // Test incompatible composite units error
        XCTAssertThrowsError(
            try Measurement(value: 1, unit: UnitLength.meter / UnitTime.second.pow(2)).convert(to: UnitLength.foot / UnitTime.minute)
        )
    }
}
