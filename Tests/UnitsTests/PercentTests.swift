//
//  Test.swift
//  Units
//
//  Created by Jason Jobe on 9/13/25.
//

@testable import Units
import XCTest

final class PercentTests: XCTestCase {
    func testParse() throws {
        XCTAssertEqual(
            try Expression("10m + 25%"),
            Expression(node: .init(.measurement(10.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(25.measured(in: .percent))))
        )
    }
    
    func testSolutions() throws {
 
        XCTAssertEqual(
            try Expression("10m + 25%").solve(),
            12.5.measured(in: .meter)
        )
        
        XCTAssertEqual(
            try Expression("10m - 25%").solve(),
            7.5.measured(in: .meter)
        )

        XCTAssertEqual(
            try Expression("10m * 25%").solve(),
            2.5.measured(in: .meter)
        )

        XCTAssertEqual(
            try Expression("10m / 25%").solve(),
            40.measured(in: .meter)
        )

    }
}

