public extension Int {
    /// Creates a new measurement from the Int with the provided unit.
    /// - Parameter unit: The unit to use in the resulting measurement
    /// - Returns: A new measurement with a scalar value of the Int and the
    /// provided unit of measure
    func measured(in unit: Unit) -> Measurement {
        return Measurement(value: Double(self), unit: unit)
    }
    
    /// Creates a new measurement from the Int with the provided unit.
    /// - Parameter unit: The unit to use in the resulting measurement
    /// - Returns: A new measurement with a scalar value of the Int and the
    /// provided unit of measure
    func measured(
        in unitSymbol: String,
        registry: UnitRegistry = .global
    ) throws -> Measurement {
        let unit = try registry.unit(fromSymbol: unitSymbol)
        return Measurement(value: Double(self), unit: unit)
    }
}
