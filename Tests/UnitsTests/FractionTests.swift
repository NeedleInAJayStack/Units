import Units
import XCTest



final class FractionTests: XCTestCase {

    /// It should not be possible to create a non-reduced fraction
    func testReductionInvariant() {
        let testCases: [(fraction: Fraction, expectedNumerator: Int, expectedDenominator: Int)] = [
            ((5|10), 1, 2),
            ((3|7), 3, 7),
            ((21|7), 3, 1),
            ((3|21), 1, 7),
            ((0|5), 0, 1),
        ]
        for (fraction, expectedNumerator, expectedDenominator) in testCases {
            XCTAssertEqual(fraction.numerator, expectedNumerator)
            XCTAssertEqual(fraction.denominator, expectedDenominator)
        }
    }

    func testPositive() {
        XCTAssertTrue((3 | 5).positive)
        XCTAssertTrue((-4 | -16).positive)
        XCTAssertFalse((-17 | 42).positive)
        XCTAssertFalse((1 | -111).positive)

        XCTAssertTrue((0 | 1).positive)
        XCTAssertTrue((-0 | -1).positive)
        XCTAssertTrue((0 | -1).positive)
        XCTAssertTrue((-0 | 1).positive)
    }

    func testMultiplication() {
        let fractionFractionCases: [(lhs: Fraction, rhs: Fraction, expected: Fraction)] = [
            ((1|2), (3|5), 3|10),
            ((1|1), (17|11), 17|11),
            ((4|2), (3 | -5), -12|10),
            ((4|2), (3 | -5), -6|5),
        ]
        for (lhs, rhs, expected) in fractionFractionCases {
            XCTAssertEqual(lhs * rhs, expected)
        }

        let fractionIntCases: [(lhs: Fraction, rhs: Int, expected: Fraction)] = [
            ((1|2), 10, 10|2),
            ((1|2), 10, 5),
            ((1|1), 1, 1),
            ((171|24), 1, 171|24),
            ((4|2), -1, -2),
            ((4|2), 15, 60|2),
        ]
        for (lhs, rhs, expected) in fractionIntCases {
            XCTAssertEqual(lhs * rhs, expected)
            XCTAssertEqual(rhs * lhs, expected)
        }
    }

    func testDivision() {
        let fractionFractionCases: [(lhs: Fraction, rhs: Fraction, expected: Fraction)] = [
            ((1|2), (3|5), 5|6),
            ((1|1), (17|11), 11|17),
            ((4|2), (3 | -5), -20|6),
            ((4|2), (3 | -5), -10|3),
        ]
        for (lhs, rhs, expected) in fractionFractionCases {
            XCTAssertEqual(lhs / rhs, expected)
        }

        let fractionIntCases: [(lhs: Fraction, rhs: Int, expected: Fraction)] = [
            ((1|2), 10, 1|20),
            ((1|1), 1, 1),
            ((171|24), 1, 171|24),
            ((4|2), -1, -2),
            ((4|2), 15, 4|30),
        ]
        for (lhs, rhs, expected) in fractionIntCases {
            XCTAssertEqual(lhs / rhs, expected)
            XCTAssertEqual(rhs / lhs, 1/expected)
        }
    }

    func testAddition() {
        let fractionFractionCases: [(lhs: Fraction, rhs: Fraction, expected: Fraction)] = [
            ((1|2), (3|5), 11|10),
            ((1|1), (17|11), 28|11),
            ((4|2), (3 | -5), 14|10),
            ((4|2), (3 | -5), 7|5),
        ]
        for (lhs, rhs, expected) in fractionFractionCases {
            XCTAssertEqual(lhs + rhs, expected)
        }

        let fractionIntCases: [(lhs: Fraction, rhs: Int, expected: Fraction)] = [
            ((1|2), 10, 21|2),
            ((3|2), 10, 23|2),
            ((1|1), 1, 2),
            ((171|24), 1, 65|8),
            ((4|2), -1, 1),
            ((4|2), 15, 17),
        ]
        for (lhs, rhs, expected) in fractionIntCases {
            XCTAssertEqual(lhs + rhs, expected)
            XCTAssertEqual(rhs + lhs, expected)
        }
    }

    func testSubtraction() {
        let fractionFractionCases: [(lhs: Fraction, rhs: Fraction, expected: Fraction)] = [
            ((1|2), (3|5), -2|20),
            ((1|1), (17|11), -6|11),
            ((4|2), (3 | -5), 13|5),
            ((4|2), (3 | -5), 26|10),
        ]
        for (lhs, rhs, expected) in fractionFractionCases {
            XCTAssertEqual(lhs - rhs, expected)
        }

        let fractionIntCases: [(lhs: Fraction, rhs: Int, expected: Fraction)] = [
            ((1|2), 10, -19|2),
            ((1|1), 1, 0),
            ((171|24), 1, 147|24),
            ((4|2), -1, 3),
            ((4|2), 15, -13),
        ]
        for (lhs, rhs, expected) in fractionIntCases {
            XCTAssertEqual(lhs - rhs, expected)
            XCTAssertEqual(rhs - lhs, -lhs + rhs)
        }
    }

    func testStringEncoding() {
        let testCases: [(Fraction, expected: String)] = [
            ((1|2), "(1|2)"),
            ((1|1), "1"),
            ((0|1), "0"),
            ((0 | -1), "0"),
            ((-0|1), "0"),
            ((-5|1), "-5"),
            ((5 | -1), "-5"),
            ((-5|7), "(-5|7)"),
            ((5 | -7), "(-5|7)"),
            ((-5 | -7), "(5|7)"),
            ((-5 | -7), "(5|7)"),
        ]
        for (fraction, expected) in testCases {
            XCTAssertEqual(fraction.description, expected)
        }

        XCTAssertNil(Fraction("("))
        XCTAssertNil(Fraction("(1"))
        XCTAssertNil(Fraction("(1|"))
        XCTAssertNil(Fraction("(1|2"))
        XCTAssertEqual(Fraction("(1|2)"), 1|2)
        XCTAssertNil(Fraction("(1|3|2)"))
        XCTAssertNil(Fraction("1|2)"))
        XCTAssertNil(Fraction("|2)"))
        XCTAssertNil(Fraction("2)"))
        XCTAssertNil(Fraction(")"))
    }
}
