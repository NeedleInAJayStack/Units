import Units
import XCTest

/// Test conversion coefficients, registry inclusion, and default value inclusion for all units
/// To check all 3, we use tests of the form
/// ```swift
/// try XCTAssertEqual(Measurement("1<symbol>"), <coefficient>.measured(in: .<base_unit>).convert(to: .<name>))
/// ```
/// This really is just a double-check that the unit coefficient assigned as expected, and is included in all the appropriate code locations.
class DefinitionTests: XCTestCase {
    func testData() throws {
        try XCTAssertEqual(Measurement("1bit"), 1.measured(in: .bit).convert(to: .bit))
        try XCTAssertEqual(Measurement("1kbit"), 1000.measured(in: .bit).convert(to: .kilobit))
        try XCTAssertEqual(Measurement("1Mbit"), 1e6.measured(in: .bit).convert(to: .megabit))
        try XCTAssertEqual(Measurement("1Gbit"), 1e9.measured(in: .bit).convert(to: .gigabit))
        try XCTAssertEqual(Measurement("1Tbit"), 1e12.measured(in: .bit).convert(to: .terabit))
        try XCTAssertEqual(Measurement("1Pbit"), 1e15.measured(in: .bit).convert(to: .petabit))
        try XCTAssertEqual(Measurement("1Ebit"), 1e18.measured(in: .bit).convert(to: .exabit))
        try XCTAssertEqual(Measurement("1Zbit"), 1e21.measured(in: .bit).convert(to: .zetabit))
        try XCTAssertEqual(Measurement("1Ybit"), 1e24.measured(in: .bit).convert(to: .yottabit))
        
        try XCTAssertEqual(Measurement("1Kibit"), 1024.measured(in: .bit).convert(to: .kibibit))
        try XCTAssertEqual(Measurement("1Mibit"), pow(1024, 2).measured(in: .bit).convert(to: .mebibit))
        try XCTAssertEqual(Measurement("1Gibit"), pow(1024, 3).measured(in: .bit).convert(to: .gibibit))
        try XCTAssertEqual(Measurement("1Tibit"), pow(1024, 4).measured(in: .bit).convert(to: .tebibit))
        try XCTAssertEqual(Measurement("1Pibit"), pow(1024, 5).measured(in: .bit).convert(to: .pebibit))
        try XCTAssertEqual(Measurement("1Eibit"), pow(1024, 6).measured(in: .bit).convert(to: .exbibit))
        try XCTAssertEqual(Measurement("1Zibit"), pow(1024, 7).measured(in: .bit).convert(to: .zebibit))
        try XCTAssertEqual(Measurement("1Yibit"), pow(1024, 8).measured(in: .bit).convert(to: .yobibit))
        
        try XCTAssertEqual(Measurement("1byte"), 8.measured(in: .bit).convert(to: .byte))
        try XCTAssertEqual(Measurement("1kB"), 8000.measured(in: .bit).convert(to: .kilobyte))
        try XCTAssertEqual(Measurement("1MB"), 8e6.measured(in: .bit).convert(to: .megabyte))
        try XCTAssertEqual(Measurement("1GB"), 8e9.measured(in: .bit).convert(to: .gigabyte))
        try XCTAssertEqual(Measurement("1TB"), 8e12.measured(in: .bit).convert(to: .terabyte))
        try XCTAssertEqual(Measurement("1PB"), 8e15.measured(in: .bit).convert(to: .petabyte))
        try XCTAssertEqual(Measurement("1EB"), 8e18.measured(in: .bit).convert(to: .exabyte))
        try XCTAssertEqual(Measurement("1ZB"), 8e21.measured(in: .bit).convert(to: .zetabyte))
        try XCTAssertEqual(Measurement("1YB"), 8e24.measured(in: .bit).convert(to: .yottabyte))
        
        try XCTAssertEqual(Measurement("1KiB"), 8 * 1024.measured(in: .bit).convert(to: .kibibyte))
        try XCTAssertEqual(Measurement("1MiB"), 8 * pow(1024, 2).measured(in: .bit).convert(to: .mebibyte))
        try XCTAssertEqual(Measurement("1GiB"), 8 * pow(1024, 3).measured(in: .bit).convert(to: .gibibyte))
        try XCTAssertEqual(Measurement("1TiB"), 8 * pow(1024, 4).measured(in: .bit).convert(to: .tebibyte))
        try XCTAssertEqual(Measurement("1PiB"), 8 * pow(1024, 5).measured(in: .bit).convert(to: .pebibyte))
        try XCTAssertEqual(Measurement("1EiB"), 8 * pow(1024, 6).measured(in: .bit).convert(to: .exbibyte))
        try XCTAssertEqual(Measurement("1ZiB"), 8 * pow(1024, 7).measured(in: .bit).convert(to: .zebibyte))
        try XCTAssertEqual(Measurement("1YiB"), 8 * pow(1024, 8).measured(in: .bit).convert(to: .yobibyte))
    }
}
