enum UnitsError: Error {
    case incompatibleUnits(message: String)
    case invalidCompositeUnit(message: String)
}
