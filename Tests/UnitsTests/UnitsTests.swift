import XCTest
@testable import Units

final class UnitTests: XCTestCase {
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
            (UnitLength.meter / UnitTime.second / UnitTime.second).getSymbol(),
            "m/s^2"
        )
        
        XCTAssertEqual(
            (UnitLength.meter / (UnitTime.second * UnitTime.second)).getSymbol(),
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
            (UnitLength.meter / UnitTime.second / UnitTime.second).getDimension(),
            [.Length: 1, .Time: -2]
        )
        
        XCTAssertEqual(
            (UnitLength.meter / (UnitTime.second * UnitTime.second)).getDimension(),
            [.Length: 1, .Time: -2]
        )
    }
}
