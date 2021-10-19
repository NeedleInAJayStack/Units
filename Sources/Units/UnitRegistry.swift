// TODO: Make more
class UnitForce {
    static var newton = Unit (
        symbol: "N",
        dimension: [.Mass: 1, .Length: 1, .Time: -2]
    )
}
class UnitPower {
    static var watt = Unit (
        symbol: "W",
        dimension: [.Mass: 1, .Length: 2, .Time: -3]
    )
    static var kilowatt = Unit (
        symbol: "kW",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 1000
    )
    static var horsepower = Unit (
        symbol: "hp",
        dimension: [.Mass: 1, .Length: 2, .Time: -3],
        coefficient: 745.6998715822702
    )
}
class UnitLength {
    static var meter = Unit (
        symbol: "m",
        dimension: [.Length: 1]
    )
    static var kilometer = Unit (
        symbol: "km",
        dimension: [.Length: 1],
        coefficient: 1000
    )
    static var foot = Unit (
        symbol: "ft",
        dimension: [.Length: 1],
        coefficient: 0.3048
    )
}
class UnitMass {
    static var kilogram = Unit (
        symbol: "kg",
        dimension: [.Mass: 1]
    )
    static var gram = Unit (
        symbol: "g",
        dimension: [.Mass: 1],
        coefficient: 0.001
    )
}
class UnitTime {
    static var second = Unit (
        symbol: "s",
        dimension: [.Time: 1]
    )
    static var minute = Unit (
        symbol: "min",
        dimension: [.Time: 1],
        coefficient: 60
    )
    static var hour = Unit (
        symbol: "hr",
        dimension: [.Time: 1],
        coefficient: 3600
    )
}
