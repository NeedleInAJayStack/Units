/// Represents a mathematical expression of measurements. It supports arithemetic operators and sub-expressions.
class Expression {
    // Implemented as a linked list of ExpressionNodes
    
    var first: ExpressionNode
    var last: ExpressionNode
    var count: Int
    
    init(node: ExpressionNode) {
        self.first = node
        self.last = node
        count = 1
    }
    
//    // TODO: parsing
//    init(_ expr: String) {
//        // Goal: Split string up into measurements and operators. Measurement parsing is complete,
//        // so at that point, we just go left to right adding items to the expression.
//        let utf8 = expr.unicodeScalars
//        var prev: Character? = nil
//
//        let space = Character(" ")
//        for (index, char) in utf8.enumerated() {
//            guard let prev = prev else {
//                prev = Character(char)
//                continue
//            }
//            if prev == space {
//
//            }
//            prev = Character(char)
//        }
//    }
    
    @discardableResult
    func append(op: Operator, value: ExpressionNodeValue) -> Self {
        let newNode = ExpressionNode(value)
        last.next = .init(op: op, node: newNode)
        last = newNode
        count = count + 1
        return self
    }
    
    /// Reduces the expression to a single measurement, respecting the [order of operations](https://en.wikipedia.org/wiki/Order_of_operations)
    public func solve() throws -> Measurement {
        let copy = self.copy()
        return try copy.computeAndDestroy()
    }
    
    func copy() -> Expression {
        // Copy the expression list so the original is not destroyed
        let copy = Expression(node: ExpressionNode(first.copyValue()))
        var traversal = first
        while let next = traversal.next {
            copy.append(op: next.op, value: next.node.copyValue())
            traversal = next.node
        }
        return copy
    }
    
    /// Reduces the expression to a single measurement, respecting the [order of operations](https://en.wikipedia.org/wiki/Order_of_operations)
    ///
    /// NOTE: This flattens the list, destroying it. Use `solve` for non-destructive behavior.
    private func computeAndDestroy() throws -> Measurement {
        
        // SubExpressions
        var left = first
        func computeSubExpression(node: ExpressionNode) throws {
            switch node.value {
            case .measurement:
                break // Just pass through
            case let .subExpression(expression):
                // Reassign node's value from subExpression to the solved value
                try node.value = .measurement(expression.solve())
            }
        }
        while let next = left.next {
            try computeSubExpression(node: left)
            left = next.node
        }
        try computeSubExpression(node: left)
        // At this point, there should be no more sub expressions
        
        // Multiplication
        left = first
        while let next = left.next {
            let right = next.node
            switch (left.value, right.value) {
            case let (.measurement(leftMeasurement), .measurement(rightMeasurement)):
                switch next.op {
                case .add, .subtract: // Skip over operation
                    left = right
                case .multiply: // Compute and absorb right node into left
                    left.value = .measurement(leftMeasurement * rightMeasurement)
                    left.next = right.next
                case .divide: // Compute and absorb right node into left
                    left.value = .measurement(leftMeasurement / rightMeasurement)
                    left.next = right.next
                }
            default:
                fatalError("Parentheses still present during multiplication phase")
            }
        }
        
        // Addition
        left = first
        while let next = left.next {
            let right = next.node
            switch (left.value, right.value) {
            case let (.measurement(leftMeasurement), .measurement(rightMeasurement)):
                switch next.op {
                case .add:  // Compute and absorb right node into left
                    left.value = try .measurement(leftMeasurement + rightMeasurement)
                    left.next = right.next
                case .subtract: // Compute and absorb right node into left
                    left.value = try .measurement(leftMeasurement - rightMeasurement)
                    left.next = right.next
                case .multiply, .divide:
                    fatalError("Multiplication still present during addition phase")
                }
            default:
                fatalError("Parentheses still present during addition phase")
            }
        }
        
        if first.next != nil {
            fatalError("Expression list reduction not complete")
        }
        switch first.value {
        case let .measurement(measurement):
            return measurement
        default:
            fatalError("Final value is not a computed measurement")
        }
    }
}

extension Expression: CustomStringConvertible {
    var description: String {
        var result = first.value.description
        var traversal = first
        while let next = traversal.next {
            result = result + " \(next.op.rawValue) \(next.node.value.description)"
            traversal = next.node
        }
        return result
    }
}

class ExpressionNode {
    var value: ExpressionNodeValue
    var next: ExpressionLink?
    
    init(_ value: ExpressionNodeValue, next: ExpressionLink? = nil) {
        self.value = value
        self.next = next
    }
    
    func copyValue() -> ExpressionNodeValue {
        switch value {
        case let .measurement(measurement):
            return .measurement(measurement)
        case let .subExpression(expression):
            return .subExpression(expression.copy())
        }
    }
}

enum ExpressionNodeValue {
    case measurement(Measurement)
    case subExpression(Expression)
}

extension ExpressionNodeValue: CustomStringConvertible {
    var description: String {
        switch self {
        case let .measurement(measurement):
            return measurement.description
        case let .subExpression(subExpression):
            return "(\(subExpression.description))"
        }
    }
}

class ExpressionLink {
    let op: Operator
    let node: ExpressionNode
    
    init(op: Operator, node: ExpressionNode) {
        self.op = op
        self.node = node
    }
}

enum Operator: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
}
