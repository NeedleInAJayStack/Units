import Units

// import Foundation
import XCTest

func XCTAssertEqual(
    _ expression1: @autoclosure () throws -> Units.Measurement,
    _ expression2: @autoclosure () throws -> Units.Measurement,
    accuracy: Double,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTAssertEqual(
        try expression1().unit,
        try expression2().unit,
        message(),
        file: file,
        line: line
    )
    XCTAssertEqual(
        try expression1().value,
        try expression2().value,
        accuracy: accuracy,
        message(),
        file: file,
        line: line
    )
}
