import ArgumentParser
import Units

struct ConvertUnit: ParsableCommand {
    @Argument(help: "The measurement to convert from")
    var from: Measurement

    @Argument(help: "The unit to convert from")
    var to: Unit

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

extension Unit: ExpressibleByArgument {}