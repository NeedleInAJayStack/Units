import ArgumentParser
import Units

struct Convert: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Convert a measurement expression to a specified unit.",
        discussion: """
        Run `unit list` to see the supported unit symbols and names. Unless arguments are wrapped \
        in quotes, the `*` character may need to be escaped.

        The arguments use the unit and measurement serialization format. For more details, see \
        https://github.com/NeedleInAJayStack/Units/blob/main/README.md#serialization

        EXAMPLES:
          unit convert 1ft m
          unit convert 1_ft meter
          unit convert 5.4_kW\\*hr J
          unit convert 5.4e-3_km/s mi/hr
          unit convert "12 kg*m/s^2" "N"
          unit convert "8kg * 3m / 2s^2" "N"
        """
    )

    @Argument(help: """
    The expression to compute to convert. This must follow the expression parsing rules found \
    in https://github.com/NeedleInAJayStack/Units/blob/main/README.md#serialization. \
    For convenience, you may use an underscore `_` to represent spaces.
    """)
    var from: Expression

    @Argument(help: """
    The unit to convert to. This can either be a unit name, a unit symbol, or an equation of \
    unit symbols.
    """)
    var to: Units.Unit

    func run() throws {
        try print(from.solve().convert(to: to))
    }
}

extension Expression: @retroactive ExpressibleByArgument {
    public convenience init?(argument: String) {
        let argument = argument.replacingOccurrences(of: "_", with: " ")
        try? self.init(argument)
    }
}

extension Units.Unit: @retroactive ExpressibleByArgument {
    public init?(argument: String) {
        if let unit = try? Self(fromName: argument) {
            self = unit
        } else if let unit = try? Self(fromSymbol: argument) {
            self = unit
        } else {
            return nil
        }
    }
}
