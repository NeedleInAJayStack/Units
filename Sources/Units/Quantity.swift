/// A dimension of measurement. These may be combined to form composite dimensions and measurements
public enum Quantity: String, Sendable {
    // TODO: Consider changing away from enum for extensibility

    // Base ISQ quantities: https://en.wikipedia.org/wiki/International_System_of_Quantities#Base_quantities
    case Amount
    case Current
    case Length
    case Mass
    case Temperature
    case Time
    case LuminousIntensity

    // Extended SI Units: https://en.wikipedia.org/wiki/Non-SI_units_mentioned_in_the_SI
    case Angle
    case Data
}
