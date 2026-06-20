/// A dimension of measurement. These may be combined to form composite dimensions and measurements.
///
/// `Quantity` is `RawRepresentable` rather than an enum so that callers can define their own
/// dimensions without modifying this package. Add one with a static extension:
///
/// ```swift
/// extension Quantity {
///     static let money = Quantity(rawValue: "Money")
/// }
/// ```
///
/// Use a unique `rawValue` for each distinct dimension — equality and hashing are based on it.
public struct Quantity: RawRepresentable, Hashable, Sendable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    // Base ISQ quantities: https://en.wikipedia.org/wiki/International_System_of_Quantities#Base_quantities
    public static let Amount = Quantity(rawValue: "Amount")
    public static let Current = Quantity(rawValue: "Current")
    public static let Length = Quantity(rawValue: "Length")
    public static let Mass = Quantity(rawValue: "Mass")
    public static let Temperature = Quantity(rawValue: "Temperature")
    public static let Time = Quantity(rawValue: "Time")
    public static let LuminousIntensity = Quantity(rawValue: "LuminousIntensity")

    // Extended SI Units: https://en.wikipedia.org/wiki/Non-SI_units_mentioned_in_the_SI
    public static let Angle = Quantity(rawValue: "Angle")
    public static let Data = Quantity(rawValue: "Data")
}
