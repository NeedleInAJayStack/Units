@testable import Units
import XCTest

final class ExpressionTests: XCTestCase {
    func testParse() throws {
        XCTAssertEqual(
            try Expression("5m + 3m"),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .meter))))
        )

        XCTAssertEqual(
            try Expression("5.3 m + 3.8 m"),
            Expression(node: .init(.measurement(5.3.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.8.measured(in: .meter))))
        )

        XCTAssertEqual(
            try Expression("5m^2/s + (1m + 2m)^2 / 5s"),
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

    func testSingleMeasurement() throws {
        try XCTAssertEqual(
            Expression("5kW").solve(),
            5.measured(in: .kilowatt)
        )
    }

    func testAddition() throws {
        try XCTAssertEqual(
            Expression("5kW + 2kW").solve(),
            7.measured(in: .kilowatt)
        )
    }

    func testSubtraction() throws {
        try XCTAssertEqual(
            Expression("5kW - 2kW").solve(),
            3.measured(in: .kilowatt)
        )
    }

    func testMultiplication() throws {
        try XCTAssertEqual(
            Expression("5kW * 2hr").solve(),
            10.measured(in: .kilowatt * .hour)
        )
    }

    func testDivision() throws {
        try XCTAssertEqual(
            Expression("6m / 2s").solve(),
            3.measured(in: .meter / .second)
        )
    }

    func testExponent() throws {
        try XCTAssertEqual(
            Expression("(3m)^2").solve(),
            9.measured(in: .meter * .meter)
        )

        try XCTAssertEqual(
            Expression("(3m + 2m)^2").solve(),
            25.measured(in: .meter * .meter)
        )

        try XCTAssertEqual(
            Expression("3m^2 + (2m)^2").solve(),
            7.measured(in: .meter * .meter)
        )
    }

    func testParentheses() throws {
        try XCTAssertEqual(
            Expression("(5kW) * 2hr").solve(),
            10.measured(in: .kilowatt * .hour)
        )

        try XCTAssertEqual(
            Expression("5kW * (2hr)").solve(),
            10.measured(in: .kilowatt * .hour)
        )

        try XCTAssertEqual(
            Expression("5kW * (2hr + 1hr)").solve(),
            15.measured(in: .kilowatt * .hour)
        )
    }

    func testOrderOfOperations() throws {
        try XCTAssertEqual(
            Expression("5kW * 2hr + 3kW*hr").solve(),
            13.measured(in: .kilowatt * .hour)
        )

        try XCTAssertEqual(
            Expression("5kW*hr + 3kW * 2hr").solve(),
            11.measured(in: .kilowatt * .hour)
        )

        try XCTAssertEqual(
            Expression("5kW*hr + 3kW * 2hr + 2kW*hr").solve(),
            13.measured(in: .kilowatt * .hour)
        )

        try XCTAssertEqual(
            Expression("5kW * 3hr + 2kW * 2hr").solve(),
            19.measured(in: .kilowatt * .hour)
        )

        try XCTAssertEqual(
            Expression("5kW * (3hr + 2hr) * 2hr").solve(),
            50.measured(in: .kilowatt * .hour * .hour)
        )
    }

    func testDescription() throws {
        try XCTAssertEqual(
            Expression("5kW * 3hr + 2kW * 2hr").description,
            "5.0 kW * 3.0 hr + 2.0 kW * 2.0 hr"
        )
    }

    func testPrintParseCycle() throws {
        try XCTAssertEqual(
            Expression(Expression("5kW * 3hr + 2kW * 2hr").description),
            Expression("5kW * 3hr + 2kW * 2hr")
        )

        try XCTAssertEqual(
            Expression(Expression("5kW * (3hr + 2hr) * 2hr").description),
            Expression("5kW * (3hr + 2hr) * 2hr")
        )
    }

    func testEquatable() throws {
        try XCTAssertEqual(
            Expression("5kW + 3kW + 2kW"),
            Expression("5kW + 3kW + 2kW")
        )
    }

    func testNotEqualWhenCountsDontMatch() throws {
        try XCTAssertNotEqual(
            Expression("5kW + 3kW"),
            Expression("5kW + 3kW + 2kW")
        )
    }

    func testNotEqualWhenOperatorsDontMatch() throws {
        try XCTAssertNotEqual(
            Expression("5kW + 3kW"),
            Expression("5kW * 3kW")
        )
    }

    func testNotEqualWhenUnitsDontMatch() throws {
        try XCTAssertNotEqual(
            Expression("5kW + 3kW"),
            Expression("5W + 3W")
        )
    }

    func testNotEqualWhenScalarsDontMatch() throws {
        try XCTAssertNotEqual(
            Expression("5kW + 3kW"),
            Expression("5kW + 4kW")
        )
    }

    func testNotEqualWhenExponentsDontMatch() throws {
        try XCTAssertNotEqual(
            Expression("(5kW)^2"),
            Expression("(5kW)^3")
        )
    }

    func testNotEqualWhenSubExpressionsDontMatch() throws {
        try XCTAssertNotEqual(
            Expression("5kW * (2hr + 1hr)"),
            Expression("5kW * (1hr + 1hr)")
        )
    }

    func testSolveIsNotDestructive() throws {
        let expression = try Expression("5kW + 2kW")

        XCTAssertEqual(
            expression.description,
            "5.0 kW + 2.0 kW"
        )

        try XCTAssertNoThrow(expression.solve())

        expression.append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt))))

        XCTAssertEqual(
            expression.description,
            "5.0 kW + 2.0 kW + 3.0 kW"
        )
    }
}
