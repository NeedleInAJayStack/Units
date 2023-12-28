import ArgumentParser
import Units

struct List: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Print a table of the available units, their symbols, and their dimensionality."
    )

    func run() throws {
        let units = Units.Unit.allDefined(registry: .instance).sorted { u1, u2 in
            u1.name <= u2.name
        }

        let columns = [
            "name",
            "symbol",
            "dimension",
        ]

        let rows = units.map { unit in
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
