import XCTest
@testable import Units

final class MeasurementTests: XCTestCase {
    func testSingle() throws {
        let length = Measurement(value: 5, unit: UnitLength.meter)
        XCTAssertEqual(
            length.value,
            5
        )
        XCTAssertEqual(
            length.unit.getDimension(),
            [.Length: 1]
        )
    }
    
    func testAdd() throws {
        let length1 = Measurement(value: 5, unit: UnitLength.meter)
        let length2 = Measurement(value: 5, unit: UnitLength.meter)
        XCTAssertEqual(
            try (length1 + length2).value,
            10
        )
        XCTAssertEqual(
            try (length1 + length2).unit.getDimension(),
            [.Length: 1]
        )
        XCTAssertEqual(
            try (length1 + length2).unit.getSymbol(),
            "m"
        )
        
        XCTAssertThrowsError(
            try Measurement(value: 5, unit: UnitLength.meter) + Measurement(value: 5, unit: UnitTime.second)
        )
    }
    
    func testSubtract() throws {
        let length1 = Measurement(value: 5, unit: UnitLength.meter)
        let length2 = Measurement(value: 3, unit: UnitLength.meter)
        XCTAssertEqual(
            try (length1 - length2).value,
            2
        )
        XCTAssertEqual(
            try (length1 - length2).unit.getDimension(),
            [.Length: 1]
        )
        XCTAssertEqual(
            try (length1 - length2).unit.getSymbol(),
            "m"
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
            (length1 * length2).value,
            25
        )
        XCTAssertEqual(
            (length1 * length2).unit.getDimension(),
            [.Length: 2]
        )
        XCTAssertEqual(
            (length1 * length2).unit.getSymbol(),
            "m^2"
        )
        
        // Test mixed units
        let force = Measurement(value: 2, unit: UnitForce.newton)
        let time = Measurement(value: 7, unit: UnitTime.second)
        XCTAssertEqual(
            (force * time).value,
            14
        )
        XCTAssertEqual(
            (force * time).unit.getDimension(),
            [.Mass: 1, .Length: 1, .Time: -1]
        )
        XCTAssertEqual(
            (force * time).unit.getSymbol(),
            "N*s"
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
            (length / time).value,
            2
        )
        XCTAssertEqual(
            (length / time).unit.getDimension(),
            [.Length: 1, .Time: -1]
        )
        XCTAssertEqual(
            (length / time).unit.getSymbol(),
            "m/s"
        )
    }
    
    func testPow() throws {
        XCTAssertEqual(
            Measurement(value: 2, unit: UnitLength.meter).pow(2).value,
            4
        )
        XCTAssertEqual(
            Measurement(value: 2, unit: UnitLength.meter).pow(2).unit,
            UnitLength.meter * UnitLength.meter
        )
        
        XCTAssertEqual(
            Measurement(value: 2, unit: UnitLength.meter).pow(3).value,
            8
        )
        XCTAssertEqual(
            Measurement(value: 2, unit: UnitLength.meter).pow(3).unit,
            UnitLength.meter * UnitLength.meter * UnitLength.meter
        )
    }
}
