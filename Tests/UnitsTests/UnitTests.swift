@testable import Units
import XCTest

final class UnitTests: XCTestCase {
    let registry = UnitRegistry()

    func testEqual() throws {
        XCTAssertEqual(registry.meter, registry.meter)
        XCTAssertNotEqual(registry.meter, registry.foot)
        XCTAssertEqual(registry.meter * registry.second / registry.second, registry.meter)
        XCTAssertNotEqual(registry.newton, registry.kilogram * registry.meter / registry.second.pow(2))
    }

    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            registry.meter.isDimensionallyEquivalent(to: registry.meter)
        )
        XCTAssertTrue(
            registry.meter.isDimensionallyEquivalent(to: registry.foot)
        )
        XCTAssertFalse(
            registry.meter.pow(2).isDimensionallyEquivalent(to: registry.foot)
        )
        XCTAssertTrue(
            registry.meter.pow(2).isDimensionallyEquivalent(to: registry.foot.pow(2))
        )
        XCTAssertTrue(
            (registry.meter / registry.second).isDimensionallyEquivalent(to: registry.foot / registry.second)
        )
        XCTAssertTrue(
            (registry.newton).isDimensionallyEquivalent(to: registry.kilogram * registry.meter / registry.second.pow(2))
        )
    }

    func testMultiply() throws {
        XCTAssertEqual(
            registry.meter * registry.meter,
            registry.meter.pow(2)
        )

        // Test that cancelling units give nil
        XCTAssertEqual(
            registry.meter.pow(-1) * registry.meter,
            .none
        )
    }

    func testDivide() throws {
        XCTAssertEqual(
            registry.meter.pow(2) / registry.meter,
            registry.meter
        )

        // Test that cancelling units give nil
        XCTAssertEqual(
            registry.meter / registry.meter,
            .none
        )
    }

    func testPow() throws {
        XCTAssertEqual(
            registry.meter.pow(3),
            registry.meter * registry.meter * registry.meter
        )

        // Test dividing by powers works (order of operations is preserved)
        XCTAssertEqual(
            registry.meter / registry.second.pow(2),
            registry.meter / registry.second / registry.second
        )

        XCTAssertEqual(
            registry.meter / registry.second.pow(2),
            registry.meter / (registry.second * registry.second)
        )

        // Test negative powers is the same as dividing by powers
        XCTAssertEqual(
            registry.meter * registry.second.pow(-2),
            registry.meter / (registry.second * registry.second)
        )
    }

    func testSymbol() throws {
        XCTAssertEqual(
            registry.meter.symbol,
            "m"
        )

        XCTAssertEqual(
            (registry.meter / registry.second).symbol,
            "m/s"
        )

        XCTAssertEqual(
            (registry.meter * registry.foot / registry.second).symbol,
            "ft*m/s"
        )

        XCTAssertEqual(
            (registry.meter * registry.meter / registry.second).symbol,
            "m^2/s"
        )

        XCTAssertEqual(
            (registry.meter / registry.second / registry.foot).symbol,
            "m/ft/s"
        )

        XCTAssertEqual(
            (registry.meter / (registry.second * registry.foot)).symbol,
            "m/ft/s"
        )

        XCTAssertEqual(
            (registry.meter / registry.second.pow(2)).symbol,
            "m/s^2"
        )

        XCTAssertEqual(
            (Unit.none).symbol,
            "none"
        )
    }

    func testName() throws {
        XCTAssertEqual(
            registry.meter.name,
            "meter"
        )

        XCTAssertEqual(
            (registry.meter / registry.second).name,
            "meter / second"
        )

        XCTAssertEqual(
            (registry.meter * registry.foot / registry.second).name,
            "foot * meter / second"
        )

        XCTAssertEqual(
            (registry.meter * registry.meter / registry.second).name,
            "meter^2 / second"
        )

        XCTAssertEqual(
            (registry.meter / registry.second / registry.foot).name,
            "meter / foot / second"
        )

        XCTAssertEqual(
            (registry.meter / (registry.second * registry.foot)).name,
            "meter / foot / second"
        )

        XCTAssertEqual(
            (registry.meter / registry.second.pow(2)).name,
            "meter / second^2"
        )
    }

    func testDimension() throws {
        XCTAssertEqual(
            registry.meter.dimension,
            [.Length: 1]
        )

        XCTAssertEqual(
            (registry.meter / registry.second).dimension,
            [.Length: 1, .Time: -1]
        )

        XCTAssertEqual(
            (registry.meter * registry.foot / registry.second).dimension,
            [.Length: 2, .Time: -1]
        )

        XCTAssertEqual(
            (registry.meter * registry.meter / registry.second).dimension,
            [.Length: 2, .Time: -1]
        )

        XCTAssertEqual(
            (registry.meter / registry.second / registry.foot).dimension,
            [.Time: -1]
        )

        XCTAssertEqual(
            (registry.meter / (registry.second * registry.foot)).dimension,
            [.Time: -1]
        )

        XCTAssertEqual(
            (registry.meter / registry.second.pow(2)).dimension,
            [.Length: 1, .Time: -2]
        )
    }

//    func testEncode() throws {
//        let encoder = JSONEncoder()
//
//        XCTAssertEqual(
//            try String(data: encoder.encode(registry.meter / .second), encoding: .utf8),
//            "\"m\\/s\""
//        )
//    }
//
//    func testDecode() throws {
//        let decoder = JSONDecoder()
//
//        XCTAssertEqual(
//            try decoder.decode(registry.self, from: "\"m\\/s\"".data(using: .utf8)!),
//            registry.meter / .second
//        )
//    }

    func testFromSymbol() throws {
        XCTAssertEqual(
            try registry.unit(fromSymbol: "m"),
            registry.meter
        )

        XCTAssertEqual(
            try registry.unit(fromSymbol: "m*s"),
            registry.meter * registry.second
        )

        XCTAssertEqual(
            try registry.unit(fromSymbol: "m/s"),
            registry.meter / registry.second
        )

        XCTAssertEqual(
            try registry.unit(fromSymbol: "m^2"),
            registry.meter.pow(2)
        )

        XCTAssertEqual(
            try registry.unit(fromSymbol: "1/s"),
            registry.second.pow(-1)
        )

        XCTAssertEqual(
            try registry.unit(fromSymbol: "m*s/ft^2/N"),
            registry.meter * registry.second / registry.foot.pow(2) / registry.newton
        )

        XCTAssertThrowsError(
            try registry.unit(fromSymbol: "")
        )

        XCTAssertThrowsError(
            try registry.unit(fromSymbol: "notAUnit")
        )

        XCTAssertThrowsError(
            try registry.unit(fromSymbol: "m*")
        )

        XCTAssertThrowsError(
            try registry.unit(fromSymbol: "m/")
        )

        XCTAssertThrowsError(
            try registry.unit(fromSymbol: "m^")
        )

        XCTAssertThrowsError(
            try registry.unit(fromSymbol: "m*2")
        )

        XCTAssertThrowsError(
            try registry.unit(fromSymbol: "m/2")
        )
    }

    func testFromName() throws {
        XCTAssertEqual(
            try Unit(fromName: "meter", registry: registry),
            registry.meter
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "notAUnit", registry: registry)
        )
    }

    func testLosslessStringConvertible() throws {
        XCTAssertEqual(
            try Unit(fromSymbol: registry.meter.description, registry: registry),
            registry.meter
        )

        XCTAssertEqual(
            try Unit(fromSymbol: (registry.meter * registry.second).description, registry: registry),
            registry.meter * registry.second
        )

        XCTAssertEqual(
            try Unit(fromSymbol: Unit.none.description, registry: registry),
            Unit.none
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "notAUnit", registry: registry)
        )
    }
}
