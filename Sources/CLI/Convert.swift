import ArgumentParser
import Units

struct Convert: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Convert a measurement to a specified unit.",
        discussion: """
        Run `unit list` to see the supported unit symbols and names. Unless arguments are wrapped \
        in quotes, the `*` character may need to be escaped.

        The arguments use the unit and measurement serialization format. For more details, see \
        https://github.com/NeedleInAJayStack/Units/blob/main/README.md#serialization

        EXAMPLES:
          unit convert 1_ft m
          unit convert 1_ft meter
          unit convert 5.4_kW\\*hr J
          unit convert 5.4e-3_km/s mi/hr
          unit convert "12 kg*m/s^2" "N"
          unit convert 12_m^1\\*s^-1\\*kg^1 kg\\*m/s
        """
    )

    @Argument(help: """
    The measurement to convert. This is a number, followed by a space, followed by a unit \
    symbol. For convenience, you may use an underscore `_` to represent the space.
    """)
    var from: Measurement

    @Argument(help: """
    The unit to convert to. This can either be a unit name, a unit symbol, or an equation of \
    unit symbols.
    """)
    var to: Units.Unit

    func run() throws {
        try print(from.convert(to: to))
    }
}

extension Measurement: ExpressibleByArgument {
    public init?(argument: String) {
        let argument = argument.replacingOccurrences(of: "_", with: " ")
        guard let measurement = Measurement(argument) else {
            return nil
        }
        self = measurement
    }
}

extension Units.Unit: ExpressibleByArgument {
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
