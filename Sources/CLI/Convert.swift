import ArgumentParser
import Units

struct Convert: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Convert a measurement to a specified unit.",
        discussion: """
        This command uses the unit and measurement serialization format. For more details, see
        https://github.com/NeedleInAJayStack/Units/blob/main/README.md#serialization

        Note that for convenience, you may use an underscore `_` to represent the normally 
        serialized space. Also, unless arguments are wrapped in quotes, the `*` character may
        need to be escaped.

        Run `unit list` to see the available symbols.

        EXAMPLES:

        unit convert 1_ft m
        unit convert 5.4_kW\\*hr J
        unit convert 5.4e-3_km/s mi/hr
        unit convert "12 kg*m/s^2" "N"
        unit convert 12_m^1\\*s^-1\\*kg^1 kg\\*m/s
        """
    )

    @Argument(help: "The measurement to convert from")
    var from: Measurement

    @Argument(help: "The unit to convert from")
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

extension Units.Unit: ExpressibleByArgument {}
