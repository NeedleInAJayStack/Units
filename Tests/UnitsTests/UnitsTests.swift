import XCTest
@testable import Units

final class UnitsTests: XCTestCase {
    func testAdd() throws {
        let length1 = Measurement(value: 5, unit: UnitLength.meter)
        let length2 = Measurement(value: 5, unit: UnitLength.meter)
        XCTAssertEqual(
            try (length1 + length2).value,
            10
        )
        XCTAssertEqual(
            try (length1 + length2).unit.dimension,
            [.Length: 1]
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
            try (length1 - length2).unit.dimension,
            [.Length: 1]
        )
        
        XCTAssertThrowsError(
            try Measurement(value: 5, unit: UnitLength.meter) - Measurement(value: 5, unit: UnitTime.second)
        )
    }
    
    func testMultiply() throws {
        let length1 = Measurement(value: 5, unit: UnitLength.meter)
        let length2 = Measurement(value: 5, unit: UnitLength.meter)
        XCTAssertEqual(
            (length1 * length2).value,
            25
        )
        XCTAssertEqual(
            (length1 * length2).unit.dimension,
            [.Length: 2]
        )
        
        let force = Measurement(value: 2, unit: UnitForce.newton)
        let time = Measurement(value: 7, unit: UnitTime.second)
        XCTAssertEqual(
            (force * time).value,
            14
        )
        XCTAssertEqual(
            (force * time).unit.dimension,
            [.Mass: 1, .Length: 1, .Time: -1]
        )
    }
    
    func testDivide() throws {
        let length = Measurement(value: 8, unit: UnitLength.meter)
        let time = Measurement(value: 4, unit: UnitTime.second)
        XCTAssertEqual(
            (length / time).value,
            2
        )
        XCTAssertEqual(
            (length / time).unit.dimension,
            [.Length: 1, .Time: -1]
        )
    }
}
