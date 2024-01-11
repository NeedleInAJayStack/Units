
/// Represents a reduced fractional number.
/// An invariant exists such that it is not possible to create a ``Fraction``
/// that is not represented in its most reduced form.
public struct Fraction: Hashable, Equatable, Sendable {
    public let numerator: Int
    public let denominator: Int

    /// Combines the provided `numerator` and `denominator` into a reduced ``Fraction``.
    /// - Warning: Attempts to create a ``Fraction`` with a zero denominator will fatally error.
    public init(numerator: Int, denominator: Int) {
        let gcd = Self.gcd(numerator, denominator)
        self.numerator = numerator / gcd
        self.denominator = denominator / gcd
    }

    public var positive: Bool {
        switch (numerator, denominator) {
                // 0/0 is not positive in this logic
            case let (n, d) where n >= 0 && d > 0: true

                // Seems like this case can't happen because
                // all Fractions are reduced.
            case let (n, d) where n < 0 && d < 0: true

            default: false
        }
    }
}

private extension Fraction {
    static func gcd(_ a: Int, _ b: Int) -> Int {
        // See: https://en.wikipedia.org/wiki/Euclidean_algorithm
        var latestRemainder = max(a, b)
        var previousRemainder = min(a, b)

        while latestRemainder != 0 {
            let tmp = latestRemainder
            latestRemainder = previousRemainder % latestRemainder
            previousRemainder = tmp
        }
        return previousRemainder
    }
}


extension Fraction {
    public static func * (lhs: Self, rhs: Self) -> Self {
        Self(numerator: lhs.numerator * rhs.numerator, denominator: lhs.denominator * rhs.denominator)
    }

    public static func / (lhs: Self, rhs: Self) -> Self {
        Self(numerator: lhs.numerator * rhs.denominator, denominator: lhs.denominator * rhs.numerator)
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(numerator: (lhs.numerator * rhs.denominator) + (rhs.numerator * lhs.denominator), denominator: lhs.denominator * rhs.denominator)
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        Self(numerator: (lhs.numerator * rhs.denominator) - (rhs.numerator * lhs.denominator), denominator: lhs.denominator * rhs.denominator)
    }
}
extension Fraction {
    public static func * (lhs: Self, rhs: Int) -> Self {
        lhs * Self(integerLiteral: rhs)
    }

    public static func / (lhs: Self, rhs: Int) -> Self {
        lhs / Self(integerLiteral: rhs)
    }

    public static func * (lhs: Int, rhs: Self) -> Self {
        Self(integerLiteral: lhs) * rhs
    }

    public static func / (lhs: Int, rhs: Self) -> Self {
        Self(integerLiteral: lhs) / rhs
    }

    public static func + (lhs: Self, rhs: Int) -> Self {
        lhs + Self(integerLiteral: rhs)
    }

    public static func - (lhs: Self, rhs: Int) -> Self {
        lhs - Self(integerLiteral: rhs)
    }

    public static func + (lhs: Int, rhs: Self) -> Self {
        Self(integerLiteral: lhs) + rhs
    }

    public static func - (lhs: Int, rhs: Self) -> Self {
        Self(integerLiteral: lhs) - rhs
    }
}

extension Fraction: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int

    public init(integerLiteral value: Int) {
        self.init(numerator: value, denominator: 1)
    }
}

extension Fraction: SignedNumeric {

    public init?<T>(exactly source: T) where T : BinaryInteger {
        self.init(integerLiteral: Int(source))
    }

    public static func *= (lhs: inout Fraction, rhs: Fraction) {
        lhs = lhs * rhs
    }

    public var magnitude: Fraction {
        Self(numerator: abs(numerator), denominator: abs(denominator))
    }

    public typealias Magnitude = Self

}

extension Fraction {
    public var asDouble: Double {
        Double(numerator) / Double(denominator)
    }
}

extension Fraction: Comparable {
    public static func < (lhs: Fraction, rhs: Fraction) -> Bool {
        lhs.numerator * rhs.denominator < rhs.numerator * lhs.denominator
    }
}

extension Fraction: LosslessStringConvertible {
    /// The format for string conversion is: `(<integer>|<integer>)` or `<integer>`
    public init?(_ description: String) {
        if
            description.first == "(",
            description.last == ")"
        {
            let parts = description.dropFirst().dropLast().split(separator: "|").compactMap({ Int(String($0)) })
            guard
                parts.count == 2,
                let numerator = parts.first,
                let denominator = parts.last
            else {
                return nil
            }
            self.init(numerator: numerator, denominator: denominator)
        } else if let number = Int(description) {
            self.init(integerLiteral: number)
        } else {
            return nil
        }
    }

    public var description: String {
        if denominator == 1 {
            "\(!positive && numerator != 0 ? "-" : "")\(abs(numerator))"
        } else {
            "(\(positive ? "" : "-")\(abs(numerator))|\(abs(denominator)))"
        }
    }
}

extension SignedInteger {
    func over<T: SignedInteger>(_ denominator: T) -> Fraction {
        Fraction(numerator: Int(self), denominator: Int(denominator))
    }
}

extension Int {
    public static func |(_ lhs: Self, _ rhs: Self) -> Fraction {
        Fraction(numerator: lhs, denominator: rhs)
    }
}
