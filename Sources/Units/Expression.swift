// Implemented as a linked list of ExpressionNodes
class Expression {
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
    func append(op: Operator, measurement: Measurement) -> Self {
        let newNode = ExpressionNode(measurement: measurement)
        last.next = .init(op: op, node: newNode)
        last = newNode
        count = count + 1
        return self
    }
    
    func solve() throws -> Measurement {
        let copy = self.copy()
        return try copy.computeAndDestroy()
    }
    
    private func copy() -> Expression {
        // Copy the expression list so the original is not destroyed
        let copy = Expression(node: ExpressionNode(measurement: first.measurement))
        var traversal = first
        while let next = traversal.next {
            copy.append(op: next.op, measurement: next.node.measurement)
            traversal = next.node
        }
        return copy
    }
    
    // NOTE: This flattens the list, destroying it.
    private func computeAndDestroy() throws -> Measurement {
        // Multiplication
        var left = first
        while let next = left.next {
            let right = next.node
            switch next.op {
            case .add, .subtract: // Skip over operation
                left = right
            case .multiply: // Compute and absorb right node into left
                left.measurement = left.measurement * right.measurement
                left.next = right.next
            case .divide: // Compute and absorb right node into left
                left.measurement = left.measurement / right.measurement
                left.next = right.next
            }
        }
        
        // Addition
        left = first
        while let next = left.next {
            let right = next.node
            switch next.op {
            case .add:  // Compute and absorb right node into left
                left.measurement = try left.measurement + right.measurement
                left.next = right.next
            case .subtract: // Compute and absorb right node into left
                left.measurement = try left.measurement - right.measurement
                left.next = right.next
            case .multiply, .divide:
                // TODO: Throw
                break
            }
        }
        
//        if first.next != nil {
//            throw
//        }
        return first.measurement
    }
}

extension Expression: CustomStringConvertible {
    var description: String {
        return first.description
    }
}

class ExpressionNode {
    var measurement: Measurement
    var next: ExpressionLink?
    
    init(measurement: Measurement, next: ExpressionLink? = nil) {
        self.measurement = measurement
        self.next = next
    }
}

extension ExpressionNode: CustomStringConvertible {
    var description: String {
        var result = measurement.description
        var traversal = self
        while let next = traversal.next {
            result = result + " \(next.op.rawValue) \(next.node.measurement.description)"
            traversal = next.node
        }
        return result
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
