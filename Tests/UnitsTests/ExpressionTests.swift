@testable import Units
//import Units
import XCTest

final class ExpressionTests: XCTestCase {
    func testParse() throws {
        XCTAssertEqual(
            try Expression("5 m + 3 m"),
            Expression(node: .init(.measurement(5.measured(in: .meter))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .meter))))
        )
        
        XCTAssertEqual(
            try Expression("5 m^2/s + (1 m + 2 m)^2 / 5 s"),
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
            Expression(node: .init(.measurement(5.measured(in: .kilowatt)))).solve(),
            5.measured(in: .kilowatt)
        )
    }
    
    func testAddition() throws {
        // 5kW + 2kW = 7kW
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .kilowatt))))
                .solve(),
            7.measured(in: .kilowatt)
        )
    }
    
    func testSubtraction() throws {
        // 5kW - 2kW = 3kW
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .subtract, node: .init(.measurement(2.measured(in: .kilowatt))))
                .solve(),
            3.measured(in: .kilowatt)
        )
    }
    
    func testMultiplication() throws {
        // 5kW * 2h = 10kWh
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(2.measured(in: .hour))))
                .solve(),
            10.measured(in: .kilowatt * .hour)
        )
    }
    
    func testDivision() throws {
        // 6m / 2s = 3m/s
        try XCTAssertEqual(
            Expression(node: .init(.measurement(6.measured(in: .meter))))
                .append(op: .divide, node: .init(.measurement(2.measured(in: .second))))
                .solve(),
            3.measured(in: .meter / .second)
        )
    }
    
    func testExponent() throws {
        // (3m)^2 = 9m^2
        try XCTAssertEqual(
            Expression(node: .init(.measurement(3.measured(in: .meter)), exponent: 2))
                .solve(),
            9.measured(in: .meter * .meter)
        )
        
        // (3m + 2m)^2 = 25m^2
        try XCTAssertEqual(
            Expression(node: .init(
                .subExpression(
                    .init(node: .init(.measurement(3.measured(in: .meter))))
                    .append(op: .add, node: .init(.measurement(2.measured(in: .meter))))
                ),
                exponent: 2
            )).solve(),
            25.measured(in: .meter * .meter)
        )
        
        // 3m^2 + (2m)^2 = 7m^2
        try XCTAssertEqual(
            Expression(node: .init(.measurement(3.measured(in: .meter * .meter))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .meter)), exponent: 2))
                .solve(),
            7.measured(in: .meter * .meter)
        )
    }
    
    func testParentheses() throws {
        // (5kW) * 2h = 10kWh
        try XCTAssertEqual(
            Expression(node: .init(
                .subExpression(.init(
                    node: .init(.measurement(5.measured(in: .kilowatt)))
                ))
            ))
            .append(op: .multiply, node: .init(.measurement(2.measured(in: .hour))))
            .solve(),
            10.measured(in: .kilowatt * .hour)
        )
        
        // 5kW * (2h) = 10kWh
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
            .append(op: .multiply,
                node: .init(.subExpression(.init(
                    node: .init(.measurement(2.measured(in: .hour)))
                )))
            )
            .solve(),
            10.measured(in: .kilowatt * .hour)
        )
        
        // 5kW * (2h + 1h) = 15kWh
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
            .append(op: .multiply, node: .init(
                .subExpression(.init(
                    node: .init(.measurement(2.measured(in: .hour)))
                ).append(op: .add,
                    node: .init(.measurement(1.measured(in: .hour)))
                ))
            ))
            .solve(),
            15.measured(in: .kilowatt * .hour)
        )
    }
    
    func testOrderOfOperations() throws {
        // 5kW * 2h + 3kWh = 13kW
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(2.measured(in: .hour))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt * .hour))))
                .solve(),
            13.measured(in: .kilowatt * .hour)
        )
        
        // 5kWh + 3kW * 2h = 11kWh
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt * .hour))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(2.measured(in: .hour))))
                .solve(),
            11.measured(in: .kilowatt * .hour)
        )
        
        // 5kWh + 3kW * 2h + 2kWh = 13kWh
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt * .hour))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(2.measured(in: .hour))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .kilowatt * .hour))))
                .solve(),
            13.measured(in: .kilowatt * .hour)
        )
        
        // 5kW * 3h + 2kW * 2h = 19kWh
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(3.measured(in: .hour))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(2.measured(in: .hour))))
                .solve(),
            19.measured(in: .kilowatt * .hour)
        )
        
        // 5kW * (3h + 2h) * 2h = 50kW*h^2
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(
                    .subExpression(.init(
                        node: .init(.measurement(3.measured(in: .hour)))
                    ).append(op: .add,
                        node: .init(.measurement(2.measured(in: .hour)))
                    ))
                ))
                .append(op: .multiply, node: .init(.measurement(2.measured(in: .hour))))
                .solve(),
            50.measured(in: .kilowatt * .hour * .hour)
        )
    }
    
    func testDescription() throws {
        XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(3.measured(in: .hour))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(2.measured(in: .hour))))
                .description,
            "5.0 kW * 3.0 hr + 2.0 kW * 2.0 hr"
        )
    }
    
    func testEquatable() throws {
        XCTAssertEqual(
            // 5.0 kW + 3.0 kW + 2.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .kilowatt)))),
            // 5.0 kW + 3.0 kW + 2.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .kilowatt))))
        )
    }
    
    func testNotEqualWhenCountsDontMatch() throws {
        XCTAssertNotEqual(
            // 5.0 kW + 3.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt)))),
            // 5.0 kW + 3.0 kW + 2.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(2.measured(in: .kilowatt))))
        )
    }
    
    func testNotEqualWhenOperatorsDontMatch() throws {
        XCTAssertNotEqual(
            // 5.0 kW + 3.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt)))),
            // 5.0 kW * 3.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, node: .init(.measurement(3.measured(in: .kilowatt))))
        )
    }
    
    func testNotEqualWhenUnitsDontMatch() throws {
        XCTAssertNotEqual(
            // 5.0 kW + 3.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt)))),
            // 5.0 W * 3.0 W
            Expression(node: .init(.measurement(5.measured(in: .watt))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .watt))))
        )
    }
    
    func testNotEqualWhenScalarsDontMatch() throws {
        XCTAssertNotEqual(
            // 5.0 kW + 3.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(3.measured(in: .kilowatt)))),
            // 5.0 kW * 4.0 kW
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, node: .init(.measurement(4.measured(in: .kilowatt))))
        )
    }
    
    func testNotEqualWhenExponentsDontMatch() throws {
        XCTAssertNotEqual(
            // (5.0 kW)^2
            Expression(node: .init(.measurement(5.measured(in: .kilowatt)), exponent: 2)),
            // (5.0 kW)^3
            Expression(node: .init(.measurement(5.measured(in: .kilowatt)), exponent: 3))
        )
    }
    
    func testNotEqualWhenSubExpressionsDontMatch() throws {
        XCTAssertNotEqual(
            // 5 kW * (2 hr + 1 hr)
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
            .append(op: .multiply, node: .init(
                .subExpression(.init(
                    node: .init(.measurement(2.measured(in: .hour)))
                ).append(op: .add,
                    node: .init(.measurement(1.measured(in: .hour)))
                ))
            )),
            // 5 kW * (1 hr + 1 hr)
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
            .append(op: .multiply, node: .init(
                .subExpression(.init(
                    node: .init(.measurement(1.measured(in: .hour)))
                ).append(op: .add,
                    node: .init(.measurement(1.measured(in: .hour)))
                ))
            ))
        )
    }
    
    func testSolveIsNotDestructive() throws {
        // 5 kW + 2 kW
        let expression = Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
            .append(op: .add, node: .init(.measurement(2.measured(in: .kilowatt))))
        
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
