public enum UnitError: Error {
    case incompatibleUnits(message: String)
    case invalidCompositeUnit(message: String)
}
