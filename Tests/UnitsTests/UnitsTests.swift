import XCTest
@testable import Units

final class UnitTests: XCTestCase {
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
            UnitLength.meter.getSymbol(),
            "m"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second).getSymbol(),
            "m/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter * UnitLength.foot / UnitTime.second).getSymbol(),
            "ft*m/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter * UnitLength.meter / UnitTime.second).getSymbol(),
            "m^2/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second / UnitLength.foot).getSymbol(),
            "m/ft/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / (UnitTime.second * UnitLength.foot)).getSymbol(),
            "m/ft/s"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second.pow(2)).getSymbol(),
            "m/s^2"
        )
    }
    
    func testDimension() throws {
        XCTAssertEqual(
            UnitLength.meter.getDimension(),
            [.Length: 1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second).getDimension(),
            [.Length: 1, .Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter * UnitLength.foot / UnitTime.second).getDimension(),
            [.Length: 2, .Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter * UnitLength.meter / UnitTime.second).getDimension(),
            [.Length: 2, .Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second / UnitLength.foot).getDimension(),
            [.Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / (UnitTime.second * UnitLength.foot)).getDimension(),
            [.Time: -1]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / UnitTime.second.pow(2)).getDimension(),
            [.Length: 1, .Time: -2]
        )
    }
}
