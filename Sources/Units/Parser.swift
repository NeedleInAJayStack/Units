import Foundation

class Parser {
    var data: [UnicodeScalar]
    var position = 0
    
    private var cur: Character? {
        guard position < data.count else {
            return nil
        }
        return Character(UnicodeScalar(data[position]))
    }
    
    private var peek: Character? {
        guard position < data.count - 1 else {
            return nil
        }
        return Character(UnicodeScalar(data[position+1]))
    }
    
    init(_ string: String) {
        self.data = Array(string.unicodeScalars)
    }
    
    func parseMeasurement() throws -> Measurement {
        let value: Double
        switch try next() {
        case let .number(parsed):
            value = parsed
        default:
            throw ParserError.invalidMeasurement
        }
        
        let unit: Unit
        switch try next() {
        case let .unit(parsed):
            unit = parsed
        case .eof:
            unit = .none
        default:
            throw ParserError.invalidMeasurement
        }
        
        return Measurement(value: value, unit: unit)
    }
    
    func parseExpression() throws -> Expression {
        return try parseExpression(isSubExpression: false)
    }
    
    private func parseExpression(isSubExpression: Bool) throws -> Expression {
        var expression: Expression? = nil
        
        var token = try next()
        var op: Operator? = nil
        // We do while/true because we can exit on either eof or rParen, depending on isSubExpression
        parseLoop: while true {
            switch token {
            case .eof:
                guard !isSubExpression else {
                    throw ParserError.invalidExpression(reason: "No right parentheses following left parentheses")
                }
                break parseLoop
            case let .number(value):
                let unit: Unit
                
                // Check next token to see if it is a unit. Continue loop to avoid calling next again below.
                let nextToken = try next()
                switch nextToken {
                case let .unit(parsed):
                    unit = parsed
                    token = try next()
                default:
                    unit = .none
                    token = nextToken
                }
                let measurement = Measurement(value: value, unit: unit)
                let node = ExpressionNode(.measurement(measurement))
                if let expression = expression {
                    guard let op = op else {
                        throw ParserError.invalidExpression(reason: "No operator preceeding measurement \(measurement)")
                    }
                    expression.append(op: op, node: node)
                } else {
                    expression = Expression(node: node)
                }
                op = nil
                continue parseLoop
            case .lParen:
                let subExpression = try parseExpression(isSubExpression: true)
                let node = ExpressionNode(.subExpression(subExpression))
                
                if let expression = expression {
                    guard let op = op else {
                        throw ParserError.invalidExpression(reason: "No operator preceeding left parentheses")
                    }
                    expression.append(op: op, node: node)
                } else {
                    expression = Expression(node: node)
                }
                op = nil
            case .rParen:
                guard isSubExpression else {
                    throw ParserError.invalidExpression(reason: "No left parentheses preceeding right parentheses")
                }
                guard expression != nil else {
                    throw ParserError.invalidExpression(reason: "No expression preceeding right parentheses")
                }
                break parseLoop
            case let .exp(exponent):
                guard let expression = expression else {
                    throw ParserError.invalidExpression(reason: "No node preceeding exponent")
                }
                expression.last.exponent = exponent
                op = nil
            case .add:
                op = .add
            case .sub:
                op = .subtract
            case .mult:
                op = .multiply
            case .div:
                op = .divide
            case let .unit(unit):
                // Measurement unit parsing handled above
                throw ParserError.invalidExpression(reason: "Unexpected unit: \(unit)")
            }
            token = try next()
        }
        
        if let op = op {
            throw ParserError.invalidExpression(reason: "Expression ended with operator `\(op)`")
        }
        guard let expression = expression else {
            throw ParserError.invalidExpression(reason: "Expression contained no complete node")
        }
        return expression
    }
    
    private func next() throws -> Token {
        guard let char = cur else {
            return .eof
        }
        
        if char.isNumber {
            let startPosition = position
            var numberString = ""
            while let cur = cur, (cur.isNumber ||  cur == ".") {
                numberString.append(cur)
                consume()
            }
            guard let number = Double(numberString) else {
                throw ParserError.unableToParseNumber(numberString, position: startPosition)
            }
            return .number(number)
        }
        else if char == "(" {
            consume()
            return .lParen
        }
        else if char == ")" {
            consume()
            return .rParen
        }
        else if char == "^" {
            let startPosition = position
            try consume("^")
            var intString = ""
            while let cur = cur, cur.isNumber {
                intString.append(cur)
                consume()
            }
            guard let int = Int(intString) else {
                throw ParserError.unableToParseExponent("^\(intString)", position: startPosition)
            }
            return .exp(int)
        }
        else if char.isWhitespace {
            if peek == "+" {
                try consume(" ")
                try consume("+")
                try consume(" ")
                return .add
            }
            if peek == "-" {
                try consume(" ")
                try consume("-")
                try consume(" ")
                return .sub
            }
            if peek == "*" {
                try consume(" ")
                try consume("*")
                try consume(" ")
                return .mult
            }
            if peek == "/" {
                try consume(" ")
                try consume("/")
                try consume(" ")
                return .div
            }
            
            // consume and try again
            consume()
            return try next()
        }
        else {
            var unitString = ""
            while let cur = cur, cur != "(" && cur != ")" && !cur.isWhitespace {
                unitString.append(cur)
                consume()
            }
            let unit = try Unit.init(fromSymbol: unitString)
            return .unit(unit)
        }
    }
    
    private func consume() {
        position = position + 1
    }
    
    private func consume(_ expected: Character) throws {
        guard let character = cur else {
            return
        }
        if character != expected {
            throw ParserError.unexpectedCharacter(character, position: position)
        }
        position = position + 1
    }
}

enum Token: Equatable {
    case number(Double)
    case unit(Unit)
    case lParen
    case rParen
    case add
    case sub
    case mult
    case div
    case exp(Int)
    case eof
}

enum ParserError: Error {
    case unexpectedCharacter(Character, position: Int)
    case unableToParseNumber(String, position: Int)
    case unableToParseExponent(String, position: Int)
    
    case invalidMeasurement
    case invalidExpression(reason: String)
}
