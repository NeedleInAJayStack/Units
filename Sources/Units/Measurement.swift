/// Models a value with a unit
struct Measurement {
    let value: Double
    let unit: Unit
    
    static func + (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        // TODO: Change this to check unit instead of dimension
        guard lhs.unit == rhs.unit else {
            throw UnitsError.incompatibleUnits(message: "Incompatible units")
        }
        
        return Measurement(
            value: lhs.value + rhs.value,
            unit: lhs.unit
        )
    }
    
    static func - (lhs: Measurement, rhs: Measurement) throws -> Measurement {
        // TODO: Change this to check unit instead of dimension
        guard lhs.unit == rhs.unit else {
            throw UnitsError.incompatibleUnits(message: "Incompatible units")
        }
        
        return Measurement(
            value: lhs.value - rhs.value,
            unit: lhs.unit
        )
    }
    
    static func * (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value * rhs.value,
            unit: lhs.unit * rhs.unit
        )
    }
    
    static func / (lhs: Measurement, rhs: Measurement) -> Measurement {
        return Measurement(
            value: lhs.value / rhs.value,
            unit: lhs.unit / rhs.unit
        )
    }
}

