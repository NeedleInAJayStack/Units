/// Represents a mathematical expression of measurements. It supports arithemetic operators, exponents, and sub-expressions.
public final class Expression {
    // Implemented as a linked list of ExpressionNodes. This allows us to indicate operators,
    // and iteratively solve by reducing the list according to the order of operations.

    var first: ExpressionNode
    var last: ExpressionNode
    var count: Int

    init(node: ExpressionNode) {
        first = node
        last = node
        count = 1
    }

    /// Initializes an expression from a string.
    ///
    /// Parsing rules:
    /// - All parentheses must be matched
    /// - All measurement operators must have a leading and following space. i.e. ` * `
    /// - Only integer exponentiation is supported
    /// - Exponentiated measurements must have parentheses to avoid ambiguity with units. i.e. `(3m)^2`
    ///
    /// Examples:
    /// - `5m + 3m`
    /// - `5.3 m + 3.8 m`
    /// - `5m^2/s + (1m + 2m)^2 / 5s`
    ///
    /// - Parameter expr: The string expression to parse.
    public init(_ expr: String, registry: Registry = .default) throws {
        let parsed = try Parser(expr, registry: registry).parseExpression()
        first = parsed.first
        last = parsed.last
        count = parsed.count
    }

    /// Reduces the expression to a single measurement, respecting the [order of operations](https://en.wikipedia.org/wiki/Order_of_operations)
    public func solve() throws -> Measurement {
        let copy = self.copy()
        return try copy.computeAndDestroy()
    }

    @discardableResult
    func append(op: Operator, node: ExpressionNode) -> Self {
        last.next = .init(op: op, node: node)
        last = node
        count = count + 1
        return self
    }

    func copy() -> Expression {
        // Copy the expression list so the original is not destroyed
        let copy = Expression(node: first.copy())
        var traversal = first
        while let next = traversal.next {
            copy.append(op: next.op, node: next.node.copy())
            traversal = next.node
        }
        return copy
    }

    /// Reduces the expression to a single measurement, respecting the [order of operations](https://en.wikipedia.org/wiki/Order_of_operations)
    ///
    /// NOTE: This flattens the list, destroying it. Use `solve` for non-destructive behavior.
    private func computeAndDestroy() throws -> Measurement {
        // SubExpressions
        func computeSubExpression(node: ExpressionNode) throws {
            switch node.value {
            case .measurement:
                return // Just pass through
            case let .subExpression(expression):
                // Reassign node's value from subExpression to the solved value
                try node.value = .measurement(expression.solve())
            }
        }
        var left = first
        while let next = left.next {
            try computeSubExpression(node: left)
            left = next.node
        }
        try computeSubExpression(node: left)
        // At this point, there should be no more sub expressions

        // Exponentals
        func exponentiate(node: ExpressionNode) throws {
            guard let exponent = node.exponent else {
                return
            }
            switch node.value {
            case .subExpression:
                fatalError("Parentheses still present during exponent phase")
            case let .measurement(measurement):
                // Reassign node's value to the exponentiated result & clear exponent
                node.value = .measurement(measurement.pow(exponent))
                node.exponent = nil
            }
        }
        left = first
        while let next = left.next {
            try exponentiate(node: left)
            left = next.node
        }
        try exponentiate(node: left)

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
                case .add: // Compute and absorb right node into left
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
    public var description: String {
        var result = first.value.description
        var traversal = first
        while let next = traversal.next {
            result = result + " \(next.op.rawValue) \(next.node.value.description)"
            traversal = next.node
        }
        return result
    }
}

extension Expression: Equatable {
    public static func == (lhs: Expression, rhs: Expression) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        var lhsNode = lhs.first
        var rhsNode = rhs.first
        guard lhsNode == rhsNode else {
            return false
        }
        while let lhsNext = lhsNode.next, let rhsNext = rhsNode.next {
            guard lhsNext == rhsNext else {
                return false
            }
            lhsNode = lhsNext.node
            rhsNode = rhsNext.node
        }
        return true
    }
}

class ExpressionNode {
    var value: ExpressionNodeValue
    var exponent: Int?
    var next: ExpressionLink?

    init(_ value: ExpressionNodeValue, exponent: Int? = nil, next: ExpressionLink? = nil) {
        self.value = value
        self.exponent = exponent
        self.next = next
    }

    func copy() -> ExpressionNode {
        return .init(value.copy(), exponent: exponent)
    }
}

extension ExpressionNode: Equatable {
    static func == (lhs: ExpressionNode, rhs: ExpressionNode) -> Bool {
        return lhs.value == rhs.value &&
            lhs.exponent == rhs.exponent
    }
}

enum ExpressionNodeValue {
    case measurement(Measurement)
    case subExpression(Expression)

    func copy() -> ExpressionNodeValue {
        switch self {
        case let .measurement(measurement):
            return .measurement(measurement)
        case let .subExpression(expression):
            return .subExpression(expression.copy())
        }
    }
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

extension ExpressionNodeValue: Equatable {
    static func == (lhs: ExpressionNodeValue, rhs: ExpressionNodeValue) -> Bool {
        switch (lhs, rhs) {
        case let (.measurement(lhsM), .measurement(rhsM)):
            return lhsM == rhsM
        case let (.subExpression(lhsE), .subExpression(rhsE)):
            return lhsE == rhsE
        default:
            return false
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

extension ExpressionLink: Equatable {
    static func == (lhs: ExpressionLink, rhs: ExpressionLink) -> Bool {
        return lhs.op == rhs.op &&
            lhs.node == rhs.node
    }
}

enum Operator: String {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
}
