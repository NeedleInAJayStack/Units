@testable import Units
//import Units
import XCTest

final class CLITests: XCTestCase {
    func testSingleMeasurement() throws {
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt)))).solve(),
            5.measured(in: .kilowatt)
        )
    }
    
    func testAddition() throws {
        // 5kW + 2kW = 7kW
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt))))
                .append(op: .add, value: .measurement(2.measured(in: .kilowatt)))
                .solve(),
            7.measured(in: .kilowatt)
        )
    }
    
    func testSubtraction() throws {
        // 5kW - 2kW = 3kW
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt))))
                .append(op: .subtract, value: .measurement(2.measured(in: .kilowatt)))
                .solve(),
            3.measured(in: .kilowatt)
        )
    }
    
    func testMultiplication() throws {
        // 5kW * 2h = 10kWh
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, value: .measurement(2.measured(in: .hour)))
                .solve(),
            10.measured(in: .kilowatt * .hour)
        )
    }
    
    func testDivision() throws {
        // 6m / 2s = 3m/s
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(6.measured(in: .meter))))
                .append(op: .divide, value: .measurement(2.measured(in: .second)))
                .solve(),
            3.measured(in: .meter / .second)
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
            .append(op: .multiply, value: .measurement(2.measured(in: .hour)))
            .solve(),
            10.measured(in: .kilowatt * .hour)
        )
        
        // 5kW * (2h) = 10kWh
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
            .append(op: .multiply,
                value: .subExpression(.init(
                    node: .init(.measurement(2.measured(in: .hour)))
                ))
            )
            .solve(),
            10.measured(in: .kilowatt * .hour)
        )
        
        // 5kW * (2h + 1h) = 15kWh
        try XCTAssertEqual(
            Expression(node: .init(.measurement(5.measured(in: .kilowatt))))
            .append(op: .multiply, value:
                .subExpression(.init(
                    node: .init(.measurement(2.measured(in: .hour)))
                ).append(op: .add,
                    value: .measurement(1.measured(in: .hour))
                ))
            )
            .solve(),
            15.measured(in: .kilowatt * .hour)
        )
    }
    
    func testOrderOfOperations() throws {
        // 5kW * 2h + 3kWh = 13kW
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, value: .measurement(2.measured(in: .hour)))
                .append(op: .add, value: .measurement(3.measured(in: .kilowatt * .hour)))
                .solve(),
            13.measured(in: .kilowatt * .hour)
        )
        
        // 5kWh + 3kW * 2h = 11kWh
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt * .hour))))
                .append(op: .add, value: .measurement(3.measured(in: .kilowatt)))
                .append(op: .multiply, value: .measurement(2.measured(in: .hour)))
                .solve(),
            11.measured(in: .kilowatt * .hour)
        )
        
        // 5kWh + 3kW * 2h + 2kWh = 13kWh
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt * .hour))))
                .append(op: .add, value: .measurement(3.measured(in: .kilowatt)))
                .append(op: .multiply, value: .measurement(2.measured(in: .hour)))
                .append(op: .add, value: .measurement(2.measured(in: .kilowatt * .hour)))
                .solve(),
            13.measured(in: .kilowatt * .hour)
        )
        
        // 5kW * 3h + 2kW * 2h = 19kWh
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, value: .measurement(3.measured(in: .hour)))
                .append(op: .add, value: .measurement(2.measured(in: .kilowatt)))
                .append(op: .multiply, value: .measurement(2.measured(in: .hour)))
                .solve(),
            19.measured(in: .kilowatt * .hour)
        )
        
        // 5kW * (3h + 2h) * 2h = 50kW*h^2
        try XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, value: 
                    .subExpression(.init(
                        node: .init(.measurement(3.measured(in: .hour)))
                    ).append(op: .add,
                        value: .measurement(2.measured(in: .hour))
                    ))
                )
                .append(op: .multiply, value: .measurement(2.measured(in: .hour)))
                .solve(),
            50.measured(in: .kilowatt * .hour * .hour)
        )
    }
    
    func testDescription() throws {
        XCTAssertEqual(
            Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt))))
                .append(op: .multiply, value: .measurement(3.measured(in: .hour)))
                .append(op: .add, value: .measurement(2.measured(in: .kilowatt)))
                .append(op: .multiply, value: .measurement(2.measured(in: .hour)))
                .description,
            "5.0 kW * 3.0 hr + 2.0 kW * 2.0 hr"
        )
    }
    
    func testSolveIsNotDestructive() throws {
        // 5 kW + 2 kW
        let expression = Expression(node: ExpressionNode(.measurement(5.measured(in: .kilowatt))))
            .append(op: .add, value: .measurement(2.measured(in: .kilowatt)))
        
        XCTAssertEqual(
            expression.description,
            "5.0 kW + 2.0 kW"
        )
        
        try XCTAssertNoThrow(expression.solve())
        
        expression.append(op: .add, value: .measurement(3.measured(in: .kilowatt)))
        
        XCTAssertEqual(
            expression.description,
            "5.0 kW + 2.0 kW + 3.0 kW"
        )
    }
}
