/// A predefined unit, which has an identifying symbol, defined quantity, and conversion information.
struct DefinedUnit: Hashable {
    let name: String
    let symbol: String
    let dimension: [Quantity: Int]
    let coefficient: Double
    let constant: Double

    init(name: String, symbol: String, dimension: [Quantity: Int], coefficient: Double = 1, constant: Double = 0) throws {
        for operatorSymbol in OperatorSymbols.allCases {
            guard !symbol.contains(operatorSymbol.rawValue) else {
                throw UnitError.invalidSymbol(message: "\(name) Symbol cannot contain '\(operatorSymbol.rawValue)'")
            }
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
