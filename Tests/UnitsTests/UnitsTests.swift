import XCTest
@testable import Units

final class UnitTests: XCTestCase {
    func testEqual() throws {
        XCTAssertEqual(UnitLength.meter, UnitLength.meter)
        XCTAssertNotEqual(UnitLength.meter, UnitLength.foot)
        XCTAssertEqual(UnitLength.meter * UnitTime.second / UnitTime.second, UnitLength.meter)
        XCTAssertNotEqual(UnitForce.newton, UnitMass.kilogram * UnitLength.meter / UnitTime.second.pow(2))
    }
    
    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            UnitLength.meter.isDimensionallyEquivalent(to: UnitLength.meter)
        )
        XCTAssertTrue(
            UnitLength.meter.isDimensionallyEquivalent(to: UnitLength.foot)
        )
        XCTAssertFalse(
            UnitLength.meter.pow(2).isDimensionallyEquivalent(to: UnitLength.foot)
        )
        XCTAssertTrue(
            UnitLength.meter.pow(2).isDimensionallyEquivalent(to: UnitLength.foot.pow(2))
        )
        XCTAssertTrue(
            (UnitLength.meter / UnitTime.second).isDimensionallyEquivalent(to: UnitLength.foot / UnitTime.second)
        )
        XCTAssertTrue(
            (UnitForce.newton).isDimensionallyEquivalent(to: UnitMass.kilogram * UnitLength.meter / UnitTime.second.pow(2))
        )
    }
    
    func testPow() throws {
        XCTAssertEqual(
            UnitLength.meter.pow(2),
            UnitLength.meter * UnitLength.meter
        )
        
        XCTAssertEqual(
            UnitLength.meter.pow(3),
            UnitLength.meter * UnitLength.meter * UnitLength.meter
        )
        
        // Test dividing by powers works (order of operations is preserved)
        XCTAssertEqual(
            UnitLength.meter / UnitTime.second.pow(2),
            UnitLength.meter / UnitTime.second / UnitTime.second
        )
        
        XCTAssertEqual(
            UnitLength.meter / UnitTime.second.pow(2),
            UnitLength.meter / (UnitTime.second * UnitTime.second)
        )
        
        // Test negative powers is the same as dividing by powers
        XCTAssertEqual(
            UnitLength.meter * UnitTime.second.pow(-2),
            UnitLength.meter / (UnitTime.second * UnitTime.second)
        )
    }
    
    func testSymbol() throws {
        XCTAssertEqual(
            UnitLength.meter.symbol,
            "m"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second).symbol,
            "m/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter * UnitLength.foot / UnitTime.second).symbol,
            "ft*m/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter * UnitLength.meter / UnitTime.second).symbol,
            "m^2/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second / UnitLength.foot).symbol,
            "m/ft/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / (UnitTime.second * UnitLength.foot)).symbol,
            "m/ft/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second.pow(2)).symbol,
            "m/s^2"
        )
    }
    
    func testDimension() throws {
        XCTAssertEqual(
            UnitLength.meter.dimension,
            [.Length: 1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second).dimension,
            [.Length: 1, .Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter * UnitLength.foot / UnitTime.second).dimension,
            [.Length: 2, .Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter * UnitLength.meter / UnitTime.second).dimension,
            [.Length: 2, .Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second / UnitLength.foot).dimension,
            [.Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / (UnitTime.second * UnitLength.foot)).dimension,
            [.Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second.pow(2)).dimension,
            [.Length: 1, .Time: -2]
        )
    }
}
