public enum UnitError: Error {
    case incompatibleUnits(message: String)
    case invalidCompositeUnit(message: String)
    case unitNotFound(message: String)
}
