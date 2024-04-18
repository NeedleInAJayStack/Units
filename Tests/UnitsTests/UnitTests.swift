@testable import Units
import XCTest

final class UnitTests: XCTestCase {
    func testEqual() throws {
        XCTAssertEqual(Unit.meter, Unit.meter)
        XCTAssertNotEqual(Unit.meter, Unit.foot)
        XCTAssertEqual(Unit.meter * Unit.second / Unit.second, Unit.meter)
        XCTAssertNotEqual(Unit.newton, Unit.kilogram * Unit.meter / Unit.second.pow(2))
        XCTAssertNotEqual(Unit.meter.pow(1.over(2)), Unit.kilogram * Unit.meter / Unit.second.pow(2))
        XCTAssertEqual(Unit.meter.pow(1.over(6)), Unit.meter.pow(1.over(2)).pow(1.over(3)) )
    }

    func testIsDimensionallyEquivalent() throws {
        XCTAssertTrue(
            Unit.meter.isDimensionallyEquivalent(to: .meter)
        )
        XCTAssertTrue(
            Unit.meter.isDimensionallyEquivalent(to: .foot)
        )
        XCTAssertFalse(
            Unit.meter.pow(2).isDimensionallyEquivalent(to: .foot)
        )
        XCTAssertTrue(
            Unit.meter.pow(2).isDimensionallyEquivalent(to: .foot.pow(2))
        )
        XCTAssertTrue(
            (Unit.meter / Unit.second).isDimensionallyEquivalent(to: Unit.foot / Unit.second)
        )
        XCTAssertTrue(
            (Unit.newton).isDimensionallyEquivalent(to: Unit.kilogram * Unit.meter / Unit.second.pow(2))
        )
        XCTAssertTrue(
            Unit.meter.pow(1.over(6)).isDimensionallyEquivalent(to: Unit.meter.pow(1.over(2)).pow(1.over(3)))
        )

    }

    func testMultiply() throws {
        XCTAssertEqual(
            Unit.meter * Unit.meter,
            Unit.meter.pow(2)
        )

        XCTAssertEqual(
            Unit.meter.pow(2) * Unit.meter.pow(1.over(2)),
            Unit.meter.pow(5.over(2))
        )

        // Test that cancelling units give nil
        XCTAssertEqual(
            Unit.meter.pow(-1) * Unit.meter,
            .none
        )
    }

    func testDivide() throws {
        XCTAssertEqual(
            Unit.meter.pow(2) / Unit.meter,
            Unit.meter
        )

        XCTAssertEqual(
            Unit.meter.pow(2) / Unit.meter.pow(1.over(2)),
            Unit.meter.pow(3.over(2))
        )

        // Test that cancelling units give nil
        XCTAssertEqual(
            Unit.meter / Unit.meter,
            .none
        )
    }

    func testPow() throws {
        XCTAssertEqual(
            Unit.meter.pow(3),
            Unit.meter * Unit.meter * Unit.meter
        )

        XCTAssertEqual(
            Unit.meter.pow(2).pow(1.over(2)),
            Unit.meter
        )

        XCTAssertEqual(
            Unit.meter.pow(3).pow(1.over(2)),
            Unit.meter.pow(3.over(2))
        )

        XCTAssertEqual(
            Unit.meter.pow(2).pow(3),
            Unit.meter.pow(6)
        )

        // Test dividing by powers works (order of operations is preserved)
        XCTAssertEqual(
            Unit.meter / Unit.second.pow(2),
            Unit.meter / Unit.second / Unit.second
        )

        XCTAssertEqual(
            Unit.meter / Unit.second.pow(2),
            Unit.meter / (Unit.second * Unit.second)
        )

        // Test negative powers is the same as dividing by powers
        XCTAssertEqual(
            Unit.meter * Unit.second.pow(-2),
            Unit.meter / (Unit.second * Unit.second)
        )
    }

    func testSymbol() throws {
        XCTAssertEqual(
            Unit.meter.symbol,
            "m"
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second).symbol,
            "m/s"
        )

        XCTAssertEqual(
            (Unit.meter * Unit.foot / Unit.second).symbol,
            "ft*m/s"
        )

        XCTAssertEqual(
            (Unit.meter * Unit.meter / Unit.second).symbol,
            "m^2/s"
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second / Unit.foot).symbol,
            "m/ft/s"
        )

        XCTAssertEqual(
            (Unit.meter / (Unit.second * Unit.foot)).symbol,
            "m/ft/s"
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second.pow(2)).symbol,
            "m/s^2"
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second.pow(2.over(5))).symbol,
            "m/s^(2|5)"
        )

        XCTAssertEqual(
            (Unit.none).symbol,
            "none"
        )
    }

    func testName() throws {
        XCTAssertEqual(
            Unit.meter.name,
            "meter"
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second).name,
            "meter / second"
        )

        XCTAssertEqual(
            (Unit.meter * Unit.foot / Unit.second).name,
            "foot * meter / second"
        )

        XCTAssertEqual(
            (Unit.meter * Unit.meter / Unit.second).name,
            "meter^2 / second"
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second / Unit.foot).name,
            "meter / foot / second"
        )

        XCTAssertEqual(
            (Unit.meter / (Unit.second * Unit.foot)).name,
            "meter / foot / second"
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second.pow(2)).name,
            "meter / second^2"
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second.pow(2.over(5))).name,
            "meter / second^(2|5)"
        )
    }

    func testDimension() throws {
        XCTAssertEqual(
            Unit.meter.dimension,
            [.Length: 1]
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second).dimension,
            [.Length: 1, .Time: -1]
        )

        XCTAssertEqual(
            (Unit.meter * Unit.foot / Unit.second).dimension,
            [.Length: 2, .Time: -1]
        )

        XCTAssertEqual(
            (Unit.meter * Unit.meter / Unit.second).dimension,
            [.Length: 2, .Time: -1]
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second / Unit.foot).dimension,
            [.Time: -1]
        )

        XCTAssertEqual(
            (Unit.meter / (Unit.second * Unit.foot)).dimension,
            [.Time: -1]
        )

        XCTAssertEqual(
            (Unit.meter / Unit.second.pow(2)).dimension,
            [.Length: 1, .Time: -2]
        )
    }

    func testEncode() throws {
        let encoder = JSONEncoder()

        XCTAssertEqual(
            try String(data: encoder.encode(Unit.meter / .second), encoding: .utf8),
            "\"m\\/s\""
        )
    }

    func testDecode() throws {
        let decoder = JSONDecoder()

        XCTAssertEqual(
            try decoder.decode(Unit.self, from: "\"m\\/s\"".data(using: .utf8)!),
            Unit.meter / .second
        )
    }

    func testFromSymbol() throws {
        XCTAssertEqual(
            try Unit(fromSymbol: "m"),
            Unit.meter
        )

        XCTAssertEqual(
            try Unit(fromSymbol: "m*s"),
            Unit.meter * .second
        )

        XCTAssertEqual(
            try Unit(fromSymbol: "m/s"),
            Unit.meter / .second
        )

        XCTAssertEqual(
            try Unit(fromSymbol: "m^2"),
            Unit.meter.pow(2)
        )

        XCTAssertEqual(
            try Unit(fromSymbol: "m^(2|5)"),
            Unit.meter.pow(2.over(5))
        )

        XCTAssertEqual(
            try Unit(fromSymbol: "1/s"),
            Unit.second.pow(-1)
        )

        XCTAssertEqual(
            try Unit(fromSymbol: "m*s/ft^2/N"),
            Unit.meter * .second / .foot.pow(2) / .newton
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "")
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "notAUnit")
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "m*")
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "m/")
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "m^")
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "m*2")
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "m/2")
        )
    }

    func testFromName() throws {
        XCTAssertEqual(
            try Unit(fromName: "meter"),
            Unit.meter
        )

        XCTAssertThrowsError(
            try Unit(fromSymbol: "notAUnit")
        )
    }

    func testLosslessStringConvertible() throws {
        XCTAssertEqual(
            Unit(Unit.meter.description),
            Unit.meter
        )

        XCTAssertEqual(
            Unit((Unit.meter * .second).description),
            Unit.meter * .second
        )

        XCTAssertEqual(
            Unit(Unit.none.description),
            Unit.none
        )

        XCTAssertNil(
            Unit("notAUnit")
        )
    }
}
