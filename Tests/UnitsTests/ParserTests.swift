@testable import Units
import XCTest

final class ParseMeasurementTests: XCTestCase {
    func testNoUnit() throws {
        XCTAssertEqual(
            try Parser("5.1").parseMeasurement(),
            5.1.measured(in: .none)
        )
    }

    func testSimpleUnit() throws {
        XCTAssertEqual(
            try Parser("5.1 kW").parseMeasurement(),
            5.1.measured(in: .kilowatt)
        )
    }

    func testUnitWithSymbol() throws {
        XCTAssertEqual(
            try Parser("5.1 °F").parseMeasurement(),
            5.1.measured(in: .fahrenheit)
        )
    }

    func testComplexUnit() throws {
        XCTAssertEqual(
            try Parser("5.1 m^2*kg/s^3").parseMeasurement(),
            5.1.measured(in: .meter * .meter * .kilogram / .second / .second / .second)
        )
    }

    func testHandlesWhitespace() throws {
        XCTAssertEqual(
            try Parser("  5.1 ").parseMeasurement(),
            5.1.measured(in: .none)
        )

        XCTAssertEqual(
            try Parser("5.1     kW").parseMeasurement(),
            5.1.measured(in: .kilowatt)
        )

        XCTAssertEqual(
            try Parser("5.1kW").parseMeasurement(),
            5.1.measured(in: .kilowatt)
        )
    }

    func testHandlesNoDecimal() throws {
        XCTAssertEqual(
            try Parser("5 kW").parseMeasurement(),
            5.measured(in: .kilowatt)
        )
    }

    func testFailsOnBadUnit() throws {
        XCTAssertThrowsError(
            try Parser("5 +").parseMeasurement()
        )
    }

    func testFailsOnUnknownUnit() throws {
        XCTAssertThrowsError(
            try Parser("5 flippers").parseMeasurement()
        )
    }

    func testFailsOnBadValue() throws {
        XCTAssertThrowsError(
            try Parser("orange kW").parseMeasurement()
        )
    }
}

final class ParseExpressionTests: XCTestCase {
    func testSimple() throws {
        XCTAssertEqual(
            try Parser("5 m + 3 m").parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .meter))))
        )
    }

    func testComplex() throws {
        XCTAssertEqual(
            try Parser("5 m^2/s + (1 m + 2 m)^2 / 5 s").parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .meter * .meter / .second))))
                .append(op: .add, node: .init(
                    .subExpression(
                        .init(node: .init(.measurement(1.measured(in: .meter))))
                            .append(op: .add, node: .init(.measurement(2.measured(in: .meter))))
                    ),
                    exponent: 2
                ))
                .append(op: .divide, node: .init(.measurement(5.measured(in: .second))))
        )
    }

    func testNestedExpressions() throws {
        XCTAssertEqual(
            try Parser("5 m * (1 m * (1 m + 2 m))").parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .multiply, node: .init(
                    .subExpression(
                        .init(node: .init(.measurement(1.measured(in: .meter))))
                            .append(op: .multiply, node: .init(
                                .subExpression(
                                    .init(node: .init(.measurement(1.measured(in: .meter))))
                                        .append(op: .add, node: .init(.measurement(2.measured(in: .meter))))
                                )
                            ))
                    )
                ))
        )
    }

    func testNoUnit() throws {
        XCTAssertEqual(
            try Parser("5 + 2 * 3").parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .none))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .none))))
                .append(op: .multiply, node: .init(.measurement(3.measured(in: .none))))
        )
    }

    func testHandlesWhitespace() throws {
        XCTAssertEqual(
            try Parser("5  m   +   3  m").parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .meter))))
        )

        XCTAssertEqual(
            try Parser("5m + 3m").parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .meter))))
        )
    }

    func testFailsOnUnspacedOperators() throws {
        XCTAssertThrowsError(
            try Parser("5m+3m").parseExpression()
        )
        XCTAssertThrowsError(
            try Parser("5m-3m").parseExpression()
        )
        XCTAssertThrowsError(
            try Parser("5m*3m").parseExpression()
        )
        XCTAssertThrowsError(
            try Parser("5m/3m").parseExpression()
        )
    }

    func testFailsOnIncompleteExpression() throws {
        XCTAssertThrowsError(
            try Parser("5m + ").parseExpression()
        )

        XCTAssertThrowsError(
            try Parser("(5m + 2m) - (3m").parseExpression()
        )

        XCTAssertThrowsError(
            try Parser("(5m)^").parseExpression()
        )

        XCTAssertThrowsError(
            try Parser("(5m + 2m) (3m)").parseExpression()
        )

        XCTAssertThrowsError(
            try Parser(") + (5m + 2m)").parseExpression()
        )
    }
}
