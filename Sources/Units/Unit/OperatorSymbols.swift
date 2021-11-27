/// String operator representations. Since composite units may be parsed from symbols,
/// these must be disallowed in defined unit symbols.
enum OperatorSymbols: String, CaseIterable {
    case mult = "*"
    case div = "/"
    case exp = "^"
}
