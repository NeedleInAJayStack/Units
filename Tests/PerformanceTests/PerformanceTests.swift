@testable import Units
import XCTest

final class PerformanceTests: XCTestCase {
    let registry = UnitRegistry()

    func testInstantiate() throws {
        measure {
            _ = 5.3.measured(in: registry.meter)
        }
    }

    func testAdd() throws {
        let measurement1 = 5.measured(in: registry.meter)
        let measurement2 = 2.measured(in: registry.meter)
        measure {
            _ = try? measurement1 + measurement2
        }
    }

    func testMultiply() throws {
        let measurement1 = 5.measured(in: registry.meter)
        let measurement2 = 2.measured(in: registry.second)
        measure {
            _ = measurement1 / measurement2
        }
    }

    func testConvert() throws {
        let measurement = 5.measured(in: registry.meter)
        measure {
            _ = try? measurement.convert(to: registry.foot)
        }
    }

    func testCompare() throws {
        let measurement1 = 5.measured(in: registry.meter)
        let measurement2 = 5.measured(in: registry.foot)
        measure {
            _ = measurement1 == measurement2
        }
    }
}
