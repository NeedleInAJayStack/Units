// TODO: Make more
public class UnitForce {
    public static var newton = Unit (
        symbol: "N",
        dimension: [.Mass: 1, .Length: 1, .Time: -2]
    )
}
public class UnitPower {
    public static var watt = Unit (
        symbol: "W",
        dimension: [.Mass: 1, .Length: 2, .Time: -3]
    )
    public static var kilowatt = Unit (
        symbol: "kW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1000
    )
    public static var horsepower = Unit (
        symbol: "hp",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 745.6998715822702
    )
}
public class UnitLength {
    public static var meter = Unit (
        symbol: "m",
        dimension: [.Length: 1]
    )
    public static var kilometer = Unit (
        symbol: "km",
        dimension: [.Length: 1],
        coefficient: 1000
    )
    public static var foot = Unit (
        symbol: "ft",
        dimension: [.Length: 1],
        coefficient: 0.3048
    )
}
public class UnitMass {
    public static var kilogram = Unit (
        symbol: "kg",
        dimension: [.Mass: 1]
    )
    public static var gram = Unit (
        symbol: "g",
        dimension: [.Mass: 1],
        coefficient: 0.001
    )
    public static var pound = Unit (
        symbol: "lb",
        dimension: [.Mass: 1],
        coefficient: 0.45359237
    )
}
public class UnitTime {
    public static var second = Unit (
        symbol: "s",
        dimension: [.Time: 1]
    )
    public static var minute = Unit (
        symbol: "min",
        dimension: [.Time: 1],
        coefficient: 60
    )
    public static var hour = Unit (
        symbol: "hr",
        dimension: [.Time: 1],
        coefficient: 3600
    )
}
public class UnitTemperature {
    public static var kelvin = Unit (
        symbol: "K",
        dimension: [.Temperature: 1]
    )
    public static var celsius = Unit (
        symbol: "°C",
        dimension: [.Temperature: 1],
        constant: 273.15
    )
    public static var fahrenheit = Unit (
        symbol: "°F",
        dimension: [.Temperature: 1],
        coefficient: 5.0/9.0,
        constant: 273.15 - (32 * 5.0/9.0)
    )
    public static var rankine = Unit (
        symbol: "°R",
        dimension: [.Temperature: 1],
        coefficient: 5.0/9.0
    )
}
