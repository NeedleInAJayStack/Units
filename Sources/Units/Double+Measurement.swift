
extension Double {
    /// Creates a measurement from the Double with the provided unit
    public func measured(in unit: Unit) -> Measurement {
        return Measurement(value: self, unit: unit)
    }
}

extension Int {
    /// Creates a measurement from the Int with the provided unit
    public func measured(in unit: Unit) -> Measurement {
        return Measurement(value: Double(self), unit: unit)
    }
}
