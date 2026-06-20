import Units
import XCTest

/// A user-defined dimension, declared outside the package. This is the capability
/// that `Quantity` being `RawRepresentable` (rather than a closed enum) enables.
private extension Quantity {
    static let money = Quantity(rawValue: "Money")
}

class QuantityTests: XCTestCase {
    /// Built-in quantities keep their stable string raw values.
    func testBuiltInRawValues() {
        XCTAssertEqual(Quantity.Length.rawValue, "Length")
        XCTAssertEqual(Quantity.Time.rawValue, "Time")
        XCTAssertEqual(Quantity(rawValue: "Mass"), .Mass)
    }

    /// A custom dimension is distinct from every built-in one and equal to itself.
    func testCustomQuantityIdentity() {
        XCTAssertEqual(Quantity.money, Quantity(rawValue: "Money"))
        XCTAssertNotEqual(Quantity.money, .Length)
        XCTAssertNotEqual(Quantity.money, .Amount)

        // Usable as a dictionary key alongside built-ins.
        let dimension: [Quantity: Int] = [.money: 1, .Length: -3]
        XCTAssertEqual(dimension[.money], 1)
        XCTAssertEqual(dimension[.Length], -3)
    }

    /// A unit on a custom dimension participates in dimensional arithmetic:
    /// a rate of `$/m^3` multiplied by a volume in `m^3` cancels to pure `$`.
    func testCustomDimensionCancelsInArithmetic() throws {
        let registry = try RegistryBuilder().addUnit(
            name: "dollar",
            symbol: "$",
            dimension: [.money: 1]
        ).registry()

        let dollar = try Unit(fromSymbol: "$", registry: registry)
        let cubicMeter = Unit.meter.pow(3)

        let rate = Measurement(value: 180, unit: dollar / cubicMeter) // $180 per m^3
        let volume = Measurement(value: 24, unit: cubicMeter) // 24 m^3
        let cost = rate * volume

        XCTAssertEqual(cost.value, 4320, accuracy: 1e-9)
        // The volume cancels, leaving a pure money dimension.
        XCTAssertEqual(cost.unit.dimension, [.money: 1])
        XCTAssertTrue(cost.isDimensionallyEquivalent(to: Measurement(value: 1, unit: dollar)))
    }

    /// A custom dimension surfaces in the human-readable dimension description.
    func testCustomDimensionDescription() throws {
        let registry = try RegistryBuilder().addUnit(
            name: "dollar",
            symbol: "$",
            dimension: [.money: 1]
        ).registry()

        let dollar = try Unit(fromSymbol: "$", registry: registry)
        XCTAssertEqual(dollar.dimensionDescription(), "Money")
    }
}
