// TODO: Make more
class UnitForce {
    static var newton = Unit (
        symbol: "N",
        dimension: [.Mass: 1, .Length: 1, .Time: -2]
    )
}
class UnitLength {
    static var meter = Unit (
        symbol: "m",
        dimension: [.Length: 1]
    )
    static var foot = Unit (
        symbol: "ft",
        dimension: [.Length: 1],
        constant: 0.3048
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
        coefficient: 1000
    )
}
class UnitTime {
    static var second = Unit (
        symbol: "s",
        dimension: [.Time: 1]
    )
}
