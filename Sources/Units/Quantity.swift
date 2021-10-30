/// Defines the possible base quantities, as defined by the SI units: https://en.wikipedia.org/wiki/International_System_of_Units#Overview_of_the_units
public enum Quantity {
    // TODO: Consider changing away from enum for extensibility
    
    // Base SI quantities
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
