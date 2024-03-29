@testable import Units
import XCTest

final class PerformanceTests: XCTestCase {
    func testInstantiate() throws {
        measure {
            _ = 5.3.measured(in: .meter)
        }
    }

    func testAdd() throws {
        let measurement1 = 5.measured(in: .meter)
        let measurement2 = 2.measured(in: .meter)
        measure {
            _ = try? measurement1 + measurement2
        }
    }

    func testMultiply() throws {
        let measurement1 = 5.measured(in: .meter)
        let measurement2 = 2.measured(in: .second)
        measure {
            _ = measurement1 / measurement2
        }
    }

    func testConvert() throws {
        let measurement = 5.measured(in: .meter)
        measure {
            _ = try? measurement.convert(to: .foot)
        }
    }

    func testCompare() throws {
        let measurement1 = 5.measured(in: .meter)
        let measurement2 = 5.measured(in: .foot)
        measure {
            _ = measurement1 == measurement2
        }
    }
}
