public extension Double {
    
    /// Creates a new measurement from the Double with the provided unit.
    /// - Parameter unit: The unit to use in the resulting measurement
    /// - Returns: A new measurement with a scalar value of the Double and the
    /// provided unit of measure
    func measured(in unit: Unit) -> Measurement {
        return Measurement(value: self, unit: unit)
    }
}
