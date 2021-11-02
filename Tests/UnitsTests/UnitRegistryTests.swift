import XCTest
@testable import Units

final class UnitRegistryTests: XCTestCase {
    func testFromSymbol() throws {
        XCTAssertEqual(
            try UnitRegistry.instance.fromSymbol("m"),
            Unit.meter
        )

        XCTAssertEqual(
            try UnitRegistry.instance.fromSymbol("m*s"),
            Unit.meter * .second
        )

        XCTAssertEqual(
            try UnitRegistry.instance.fromSymbol("m/s"),
            Unit.meter / .second
        )

        XCTAssertEqual(
            try UnitRegistry.instance.fromSymbol("m^2"),
            Unit.meter.pow(2)
        )

        XCTAssertEqual(
            try UnitRegistry.instance.fromSymbol("1/s"),
            Unit.second.pow(-1)
        )
        
        XCTAssertEqual(
            try UnitRegistry.instance.fromSymbol("m*s/ft^2/N"),
            Unit.meter * .second / .foot.pow(2) / .newton
        )
        
        XCTAssertThrowsError(
            try UnitRegistry.instance.fromSymbol("")
        )
        
        XCTAssertThrowsError(
            try UnitRegistry.instance.fromSymbol("notAUnit")
        )
        
        XCTAssertThrowsError(
            try UnitRegistry.instance.fromSymbol("m*")
        )
        
        XCTAssertThrowsError(
            try UnitRegistry.instance.fromSymbol("m/")
        )
        
        XCTAssertThrowsError(
            try UnitRegistry.instance.fromSymbol("m^")
        )
        
        XCTAssertThrowsError(
            try UnitRegistry.instance.fromSymbol("m*2")
        )
        
        XCTAssertThrowsError(
            try UnitRegistry.instance.fromSymbol("m/2")
        )
    }
}
