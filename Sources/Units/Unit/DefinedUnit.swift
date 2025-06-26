/// A predefined unit, which has an identifying symbol, defined quantity, and conversion information.
struct DefinedUnit: Hashable, Sendable {
    let name: String
    let symbol: String
    let dimension: [Quantity: Fraction]
    let coefficient: Double
    let constant: Double

    init(name: String, symbol: String, dimension: [Quantity: Fraction], coefficient: Double = 1, constant: Double = 0) throws {
        guard !symbol.isEmpty else {
            throw UnitError.invalidSymbol(message: "Symbol cannot be empty")
        }
        for operatorSymbol in OperatorSymbols.allCases {
            guard !symbol.contains(operatorSymbol.rawValue) else {
                throw UnitError.invalidSymbol(message: "'\(name)' Symbol cannot contain '\(operatorSymbol.rawValue)'")
            }
        }
        guard !symbol.contains(" ") else {
            throw UnitError.invalidSymbol(message: "'\(name)' Symbol cannot contain spaces")
        }

        self.name = name
        self.symbol = symbol
        self.dimension = dimension
        self.coefficient = coefficient
        self.constant = constant
    }
}

extension DefinedUnit: Equatable {
    public static func == (lhs: DefinedUnit, rhs: DefinedUnit) -> Bool {
        return lhs.symbol == rhs.symbol
    }
}
