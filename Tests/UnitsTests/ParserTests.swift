@testable import Units
import XCTest

final class ParseMeasurementTests: XCTestCase {
    let registry = Registry.default

    func testNoUnit() throws {
        XCTAssertEqual(
            try Parser("5.1", registry: registry).parseMeasurement(),
            5.1.measured(in: .none)
        )
    }

    func testSimpleUnit() throws {
        XCTAssertEqual(
            try Parser("5.1 kW", registry: registry).parseMeasurement(),
            5.1.measured(in: .kilowatt)
        )
    }

    func testUnitWithSymbol() throws {
        XCTAssertEqual(
            try Parser("5.1 °F", registry: registry).parseMeasurement(),
            5.1.measured(in: .fahrenheit)
        )
    }

    func testComplexUnit() throws {
        XCTAssertEqual(
            try Parser("5.1 m^2*kg/s^3", registry: registry).parseMeasurement(),
            5.1.measured(in: .meter * .meter * .kilogram / .second / .second / .second)
        )
    }

    func testHandlesWhitespace() throws {
        XCTAssertEqual(
            try Parser("  5.1 ", registry: registry).parseMeasurement(),
            5.1.measured(in: .none)
        )

        XCTAssertEqual(
            try Parser("5.1     kW", registry: registry).parseMeasurement(),
            5.1.measured(in: .kilowatt)
        )

        XCTAssertEqual(
            try Parser("5.1kW", registry: registry).parseMeasurement(),
            5.1.measured(in: .kilowatt)
        )
    }

    func testHandlesNoDecimal() throws {
        XCTAssertEqual(
            try Parser("5 kW", registry: registry).parseMeasurement(),
            5.measured(in: .kilowatt)
        )
    }

    func testFailsOnBadUnit() throws {
        XCTAssertThrowsError(
            try Parser("5 +", registry: registry).parseMeasurement()
        )
    }

    func testFailsOnUnknownUnit() throws {
        XCTAssertThrowsError(
            try Parser("5 flippers", registry: registry).parseMeasurement()
        )
    }

    func testFailsOnBadValue() throws {
        XCTAssertThrowsError(
            try Parser("orange kW", registry: registry).parseMeasurement()
        )
    }
}

final class ParseExpressionTests: XCTestCase {
    let registry = Registry.default

    func testSimple() throws {
        XCTAssertEqual(
            try Parser("5 m + 3 m", registry: registry).parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .meter))))
        )
    }

    func testComplex() throws {
        XCTAssertEqual(
            try Parser("5 m^2/s + (1 m + 2 m)^2 / 5 s", registry: registry).parseExpression(),
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
            try Parser("5 m * (1 m * (1 m + 2 m))", registry: registry).parseExpression(),
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
            try Parser("5 + 2 * 3", registry: registry).parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .none))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .none))))
                .append(op: .multiply, node: .init(.measurement(3.measured(in: .none))))
        )
    }

    func testHandlesWhitespace() throws {
        XCTAssertEqual(
            try Parser("5  m   +   3  m", registry: registry).parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .meter))))
        )

        XCTAssertEqual(
            try Parser("5m + 3m", registry: registry).parseExpression(),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .meter))))
        )
    }

    func testFailsOnUnspacedOperators() throws {
        XCTAssertThrowsError(
            try Parser("5m+3m", registry: registry).parseExpression()
        )
        XCTAssertThrowsError(
            try Parser("5m-3m", registry: registry).parseExpression()
        )
        XCTAssertThrowsError(
            try Parser("5m*3m", registry: registry).parseExpression()
        )
        XCTAssertThrowsError(
            try Parser("5m/3m", registry: registry).parseExpression()
        )
    }

    func testFailsOnIncompleteExpression() throws {
        XCTAssertThrowsError(
            try Parser("5m + ", registry: registry).parseExpression()
        )

        XCTAssertThrowsError(
            try Parser("(5m + 2m) - (3m", registry: registry).parseExpression()
        )

        XCTAssertThrowsError(
            try Parser("(5m)^", registry: registry).parseExpression()
        )

        XCTAssertThrowsError(
            try Parser("(5m + 2m) (3m)", registry: registry).parseExpression()
        )

        XCTAssertThrowsError(
            try Parser(") + (5m + 2m)", registry: registry).parseExpression()
        )
    }
}
