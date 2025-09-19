import ArgumentParser
import Units

struct List: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Print a table of the available units, their symbols, and their dimensionality."
    )

    @Option(name: .shortAndLong,
        help: "Substring to filter on dimensions and symbols")
    var filter: String? = nil
    
    func run() throws {
        let units = registry.allUnits().sorted { u1, u2 in
            u1.name <= u2.name
        }

        let columns = [
            "name",
            "symbol",
            "dimension",
        ]

        let rows = units
            .filter({ $0.contains(filter)})
            .map { unit in
            [
                unit.name,
                unit.symbol,
                unit.dimensionDescription(),
            ]
        }

        let padding = 2 // The padding between the longest col value and the start of the next col.
        let columnWidths = columns.enumerated().map { i, _ in
            rows.reduce(0) { maxSoFar, row in
                max(row[i].count, maxSoFar)
            } + padding
        }

        var header = ""
        for (i, column) in columns.enumerated() {
            header += column.padding(
                toLength: columnWidths[i],
                withPad: " ",
                startingAt: 0
            )
        }
        let rowStrings = rows.map { row in
            var rowString = ""
            for (i, value) in row.enumerated() {
                rowString += value.padding(
                    toLength: columnWidths[i],
                    withPad: " ",
                    startingAt: 0
                )
            }
            return rowString
        }

        print(header)
        print(String(repeating: "-", count: header.count))
        for rowString in rowStrings {
            print(rowString)
        }
    }
}

extension Units.Unit {
    func contains(_ substring: String?) -> Bool {
        guard let substring else { return true }
        return self.symbol.contains(substring)
        || self.dimensionDescription().contains(substring)
    }
}
