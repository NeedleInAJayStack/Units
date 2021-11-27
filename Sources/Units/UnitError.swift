/// Thrown errors from the Units package
public enum UnitError: Error {
    case incompatibleUnits(message: String)
    case invalidCompositeUnit(message: String)
    case unitNotFound(message: String)
    case invalidSymbol(message: String)
}
