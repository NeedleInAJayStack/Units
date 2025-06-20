import ArgumentParser

struct Unit: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A utility for performing unit conversions.",
        subcommands: [Convert.self, List.self]
    )
}
