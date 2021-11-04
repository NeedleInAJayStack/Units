import XCTest
@testable import Units

final class UnitTests: XCTestCase {
    func testEqual() throws {
        XCTAssertEqual(Unit.meter, Unit.meter)
        XCTAssertNotEqual(Unit.meter, Unit.foot)
        XCTAssertEqual(Unit.meter * Unit.second / Unit.second, Unit.meter)
        XCTAssertNotEqual(Unit.newton, Unit.kilogram * Unit.meter / Unit.second.pow(2))
    }
    
    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            Unit.meter.isDimensionallyEquivalent(to: .meter)
        )
        XCTAssertTrue(
            Unit.meter.isDimensionallyEquivalent(to: .foot)
        )
        XCTAssertFalse(
            Unit.meter.pow(2).isDimensionallyEquivalent(to: .foot)
        )
        XCTAssertTrue(
            Unit.meter.pow(2).isDimensionallyEquivalent(to: .foot.pow(2))
        )
        XCTAssertTrue(
            (Unit.meter / Unit.second).isDimensionallyEquivalent(to: Unit.foot / Unit.second)
        )
        XCTAssertTrue(
            (Unit.newton).isDimensionallyEquivalent(to: Unit.kilogram * Unit.meter / Unit.second.pow(2))
        )
    }
    
    func testPow() throws {
        XCTAssertEqual(
            Unit.meter.pow(2),
            Unit.meter * Unit.meter
        )
        
        XCTAssertEqual(
            Unit.meter.pow(3),
            Unit.meter * Unit.meter * Unit.meter
        )
        
        // Test dividing by powers works (order of operations is preserved)
        XCTAssertEqual(
            Unit.meter / Unit.second.pow(2),
            Unit.meter / Unit.second / Unit.second
        )
        
        XCTAssertEqual(
            Unit.meter / Unit.second.pow(2),
            Unit.meter / (Unit.second * Unit.second)
        )
        
        // Test negative powers is the same as dividing by powers
        XCTAssertEqual(
            Unit.meter * Unit.second.pow(-2),
            Unit.meter / (Unit.second * Unit.second)
        )
    }
    
    func testSymbol() throws {
        XCTAssertEqual(
            Unit.meter.symbol,
            "m"
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second).symbol,
            "m/s"
        )
        
        XCTAssertEqual(
            (Unit.meter * Unit.foot / Unit.second).symbol,
            "ft*m/s"
        )
        
        XCTAssertEqual(
            (Unit.meter * Unit.meter / Unit.second).symbol,
            "m^2/s"
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second / Unit.foot).symbol,
            "m/ft/s"
        )
        
        XCTAssertEqual(
            (Unit.meter / (Unit.second * Unit.foot)).symbol,
            "m/ft/s"
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second.pow(2)).symbol,
            "m/s^2"
        )
    }
    
    func testName() throws {
        XCTAssertEqual(
            Unit.meter.name,
            "meter"
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second).name,
            "meter / second"
        )
        
        XCTAssertEqual(
            (Unit.meter * Unit.foot / Unit.second).name,
            "foot * meter / second"
        )
        
        XCTAssertEqual(
            (Unit.meter * Unit.meter / Unit.second).name,
            "meter^2 / second"
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second / Unit.foot).name,
            "meter / foot / second"
        )
        
        XCTAssertEqual(
            (Unit.meter / (Unit.second * Unit.foot)).name,
            "meter / foot / second"
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second.pow(2)).name,
            "meter / second^2"
        )
    }
    
    func testDimension() throws {
        XCTAssertEqual(
            Unit.meter.dimension,
            [.Length: 1]
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second).dimension,
            [.Length: 1, .Time: -1]
        )
        
        XCTAssertEqual(
            (Unit.meter * Unit.foot / Unit.second).dimension,
            [.Length: 2, .Time: -1]
        )
        
        XCTAssertEqual(
            (Unit.meter * Unit.meter / Unit.second).dimension,
            [.Length: 2, .Time: -1]
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second / Unit.foot).dimension,
            [.Time: -1]
        )
        
        XCTAssertEqual(
            (Unit.meter / (Unit.second * Unit.foot)).dimension,
            [.Time: -1]
        )
        
        XCTAssertEqual(
            (Unit.meter / Unit.second.pow(2)).dimension,
            [.Length: 1, .Time: -2]
        )
    }
    
    func testEncode() throws {
        let encoder = JSONEncoder()
        
        XCTAssertEqual(
            try String(data: encoder.encode(Unit.meter / .second), encoding: .utf8),
            "\"m\\/s\""
        )
        
        // TODO: Add more tests
    }
    
    func testDecode() throws {
        let decoder = JSONDecoder()
        
        XCTAssertEqual(
            try decoder.decode(Unit.self, from: "\"m\\/s\"".data(using: .utf8)!),
            Unit.meter / .second
        )
        
        // TODO: Add more tests
    }
}
