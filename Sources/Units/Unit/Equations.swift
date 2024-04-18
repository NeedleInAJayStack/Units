/// Serialize the dictionary of object-exponent pairs into a readable equation, populated
/// with `*` for multiplication, `/` for division, and `^` for exponentiation. For example,
/// given `["a": 1, "b": -2, "c": 3]`, it produces the equation string
/// `a*c^3/b^2`.
///
/// In the result, the input objects are sorted in the following way:
/// - Positive exponents, from smallest to largest
/// - Negative exponents, from smallest to largest
/// - For equal exponents, objects are in alphabetical order by symbol
///
/// - Parameters:
///   - dict: The object-exponent pairs
///   - symbolPath: The keypath used to produce String symbols for the objects
///   - spaceAroundOperators: Whether to include space characters before and after multiplication and division characters.
/// - Returns: A string that represents the equation of the object symbols and their respective exponentiation.
func serializeSymbolicEquation<T>(
    of dict: [T: Fraction],
    symbolPath: KeyPath<T, String>,
    spaceAroundOperators: Bool = false
) -> String {
    // Sort. The order is:
    // - Positive exponents, from smallest to largest
    // - Negative exponents, from smallest to largest
    // - For equal exponents, units are in alphabetical order by symbol
    var list = dict.map { object, exp in
        (object, exp)
    }
    list.sort { lhs, rhs in
        if lhs.1 > 0, rhs.1 > 0 {
            if lhs.1 == rhs.1 {
                return lhs.0[keyPath: symbolPath] < rhs.0[keyPath: symbolPath]
            } else {
                return lhs.1 < rhs.1
            }
        } else if lhs.1 > 0, rhs.1 < 0 {
            return true
        } else if lhs.1 < 0, rhs.1 > 0 {
            return false
        } else { // lhs.1 < 0 && rhs.1 > 0
            if lhs.1 == rhs.1 {
                return lhs.0[keyPath: symbolPath] < rhs.0[keyPath: symbolPath]
            } else {
                return lhs.1 > rhs.1
            }
        }
    }

    // Build up equation, using correct operators
    let expSymbol = String(OperatorSymbols.exp.rawValue)
    var multSymbol = String(OperatorSymbols.mult.rawValue)
    var divSymbol = String(OperatorSymbols.div.rawValue)
    if spaceAroundOperators {
        multSymbol = " \(multSymbol) "
        divSymbol = " \(divSymbol) "
    }

    var equation = ""
    for (object, exp) in list {
        guard exp != 0 else {
            break
        }

        var prefix = ""
        if equation == "" { // first symbol
            if exp >= 0 {
                prefix = ""
            } else {
                prefix = "1\(divSymbol)"
            }
        } else {
            if exp >= 0 {
                prefix = multSymbol
            } else {
                prefix = divSymbol
            }
        }
        let symbol = object[keyPath: symbolPath]
        var expStr = ""
        if abs(exp) != 0, abs(exp) != 1 {
            expStr = "\(expSymbol)\(abs(exp))"
        }

        equation += "\(prefix)\(symbol)\(expStr)"
    }
    return equation
}

/// Deserialize the equation into a dictionary of String-exponent pairs.
/// This is intended to be used on equations produced by
/// `serializeSymbolicEquation`
///
/// - Parameter equation: The equation to deserialize
/// - Returns: A dictionary containing object symbols and exponents
func deserializeSymbolicEquation(
    _ equation: String
) throws -> [String: Fraction] {
    let expSymbol = OperatorSymbols.exp.rawValue
    let multSymbol = OperatorSymbols.mult.rawValue
    let divSymbol = OperatorSymbols.div.rawValue

    var result = [String: Fraction]()
    for multChunks in equation.split(separator: multSymbol, omittingEmptySubsequences: false) {
        for (index, divChunks) in multChunks.split(separator: divSymbol, omittingEmptySubsequences: false).enumerated() {
            let symbolChunks = divChunks.split(separator: expSymbol, omittingEmptySubsequences: false)
            let subSymbol = String(symbolChunks[0]).trimmingCharacters(in: .whitespaces)
            var exp: Fraction = 1
            if symbolChunks.count == 2 {
                guard let expInt = Fraction(String(symbolChunks[1])) else {
                    throw UnitError.invalidSymbol(message: "Symbol '^' must be followed by an integer: \(equation)")
                }
                exp = expInt
            }
            if index > 0 {
                exp = -1 * exp
            }
            guard subSymbol != "1" else {
                continue
            }
            guard subSymbol != "" else {
                throw UnitError.unitNotFound(message: "Expected subsymbol missing")
            }

            if let existingExp = result[subSymbol] {
                result[subSymbol] = existingExp + exp
            } else {
                result[subSymbol] = exp
            }
        }
    }
    return result
}

/// String operator representations. Since composite units may be parsed from symbols,
/// these must be disallowed in defined unit symbols.
enum OperatorSymbols: Character, CaseIterable {
    case mult = "*"
    case div = "/"
    case exp = "^"
}
