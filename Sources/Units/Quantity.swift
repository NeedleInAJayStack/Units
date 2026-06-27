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
/// Equality and hashing are based on `rawValue`, so each distinct dimension needs a unique
/// raw string. Because the namespace is global across every module that links this package,
/// two modules that independently pick the same raw value are treated as the *same* dimension
/// and silently cancel against one another. Prefix custom raw values to avoid collisions —
/// e.g. `"Acme.Money"` rather than `"Money"`.
public struct Quantity: RawRepresentable, Hashable, Sendable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    // Base ISQ quantities: https://en.wikipedia.org/wiki/International_System_of_Quantities#Base_quantities
    public static let amount = Quantity(rawValue: "Amount")
    public static let current = Quantity(rawValue: "Current")
    public static let length = Quantity(rawValue: "Length")
    public static let mass = Quantity(rawValue: "Mass")
    public static let temperature = Quantity(rawValue: "Temperature")
    public static let time = Quantity(rawValue: "Time")
    public static let luminousIntensity = Quantity(rawValue: "LuminousIntensity")

    // Extended SI Units: https://en.wikipedia.org/wiki/Non-SI_units_mentioned_in_the_SI
    public static let angle = Quantity(rawValue: "Angle")
    public static let data = Quantity(rawValue: "Data")
}

// MARK: - Deprecated PascalCase aliases

// The previous `enum Quantity` spelled its cases in PascalCase. These aliases keep existing
// call sites compiling against the renamed lowerCamelCase properties (Swift API Design
// Guidelines) and can be removed in a future major release.
public extension Quantity {
    @available(*, deprecated, renamed: "amount")
    static let Amount = Quantity.amount
    @available(*, deprecated, renamed: "current")
    static let Current = Quantity.current
    @available(*, deprecated, renamed: "length")
    static let Length = Quantity.length
    @available(*, deprecated, renamed: "mass")
    static let Mass = Quantity.mass
    @available(*, deprecated, renamed: "temperature")
    static let Temperature = Quantity.temperature
    @available(*, deprecated, renamed: "time")
    static let Time = Quantity.time
    @available(*, deprecated, renamed: "luminousIntensity")
    static let LuminousIntensity = Quantity.luminousIntensity
    @available(*, deprecated, renamed: "angle")
    static let Angle = Quantity.angle
    @available(*, deprecated, renamed: "data")
    static let Data = Quantity.data
}

// MARK: - CustomStringConvertible

extension Quantity: CustomStringConvertible {
    // Preserve the enum's behavior: interpolating a Quantity yields its raw value
    // (e.g. "Length"), not the synthesized struct description.
    public var description: String { rawValue }
}
