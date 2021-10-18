/// Defines the possible base quantities, as defined by the SI units: https://en.wikipedia.org/wiki/International_System_of_Units#Overview_of_the_units
enum BaseQuantity {
    case Time
    case Length
    case Mass
    case Current
    case Temperature
    case Amount
    case LuminousIntensity
    
    static let allValues = [
        Time,
        Length,
        Mass,
        Current,
        Temperature,
        Amount,
        LuminousIntensity,
    ]
    
    func baseUnit() -> Unit {
        switch self {
        case .Time:
            return UnitTime.second
        case .Length:
            return UnitLength.meter
        default:
            // TODO: Fix this when more units are added
            return UnitForce.newton
        }
    }
}
