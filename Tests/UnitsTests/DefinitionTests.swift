import Units
import XCTest

/// Test conversion coefficients, registry inclusion, and default value inclusion for all units
/// To check all 3, we use tests of the form
/// ```swift
/// try XCTAssertEqual(Measurement("1<symbol>"), <coefficient>.measured(in: .<base_unit>).convert(to: .<name>))
/// ```
/// This really is just a double-check that the unit coefficient assigned as expected, and is included in all the appropriate code locations.
class DefinitionTests: XCTestCase {
    func testAcceleration() throws {
        // Base unit: meter / second^2
        try XCTAssertEqual(Measurement("1ɡ"), 9.80665.measured(in: .meter / .second / .second).convert(to: .standardGravity))
    }

    func testAmount() throws {
        // Base unit: mole
        XCTAssertEqual(Measurement("1mol"), 1.measured(in: .mole))
        try XCTAssertEqual(Measurement("1mmol"), 0.001.measured(in: .mole).convert(to: .millimole))
        try XCTAssertEqual(Measurement("1particle"), 6.02214076e-23.measured(in: .mole).convert(to: .particle))
    }

    func testAngle() throws {
        // Base unit: radian
        XCTAssertEqual(Measurement("1rad"), 1.measured(in: .radian))
        try XCTAssertEqual(Measurement("1°"), (180 / Double.pi).measured(in: .radian).convert(to: .degree))
        try XCTAssertEqual(Measurement("1rev"), (2 * Double.pi).measured(in: .radian).convert(to: .revolution))
    }

    func testArea() throws {
        // Base unit: meter^2
        try XCTAssertEqual(Measurement("1ac"), 4046.8564224.measured(in: .meter * .meter).convert(to: .acre))
        try XCTAssertEqual(Measurement("1a"), 100.measured(in: .meter * .meter).convert(to: .are))
        try XCTAssertEqual(Measurement("1ha"), 10000.measured(in: .meter * .meter).convert(to: .hectare))
    }

    func testCapacitance() throws {
        // Base unit: farad
        XCTAssertEqual(Measurement("1F"), 1.measured(in: .farad))
    }

    func testCharge() throws {
        // Base unit: coloumb
        XCTAssertEqual(Measurement("1C"), 1.measured(in: .coulomb))
    }

    func testCurrent() throws {
        // Base unit: ampere
        XCTAssertEqual(Measurement("1A"), 1.measured(in: .ampere))
        try XCTAssertEqual(Measurement("1μA"), 1e-6.measured(in: .ampere).convert(to: .microampere))
        try XCTAssertEqual(Measurement("1mA"), 0.001.measured(in: .ampere).convert(to: .milliampere))
        try XCTAssertEqual(Measurement("1kA"), 1000.measured(in: .ampere).convert(to: .kiloampere))
        try XCTAssertEqual(Measurement("1MA"), 1e6.measured(in: .ampere).convert(to: .megaampere))
    }

    func testData() throws {
        // Base unit: bit
        XCTAssertEqual(Measurement("1bit"), 1.measured(in: .bit))
        try XCTAssertEqual(Measurement("1kbit"), 1000.measured(in: .bit).convert(to: .kilobit))
        try XCTAssertEqual(Measurement("1Mbit"), 1e6.measured(in: .bit).convert(to: .megabit))
        try XCTAssertEqual(Measurement("1Gbit"), 1e9.measured(in: .bit).convert(to: .gigabit))
        try XCTAssertEqual(Measurement("1Tbit"), 1e12.measured(in: .bit).convert(to: .terabit))
        try XCTAssertEqual(Measurement("1Pbit"), 1e15.measured(in: .bit).convert(to: .petabit))
        try XCTAssertEqual(Measurement("1Ebit"), 1e18.measured(in: .bit).convert(to: .exabit))
        try XCTAssertEqual(Measurement("1Zbit"), 1e21.measured(in: .bit).convert(to: .zetabit))
        try XCTAssertEqual(Measurement("1Ybit"), 1e24.measured(in: .bit).convert(to: .yottabit))
        
        try XCTAssertEqual(Measurement("1Kibit"), 1024.measured(in: .bit).convert(to: .kibibit))
        try XCTAssertEqual(Measurement("1Mibit"), pow(1024, 2).measured(in: .bit).convert(to: .mebibit))
        try XCTAssertEqual(Measurement("1Gibit"), pow(1024, 3).measured(in: .bit).convert(to: .gibibit))
        try XCTAssertEqual(Measurement("1Tibit"), pow(1024, 4).measured(in: .bit).convert(to: .tebibit))
        try XCTAssertEqual(Measurement("1Pibit"), pow(1024, 5).measured(in: .bit).convert(to: .pebibit))
        try XCTAssertEqual(Measurement("1Eibit"), pow(1024, 6).measured(in: .bit).convert(to: .exbibit))
        try XCTAssertEqual(Measurement("1Zibit"), pow(1024, 7).measured(in: .bit).convert(to: .zebibit))
        try XCTAssertEqual(Measurement("1Yibit"), pow(1024, 8).measured(in: .bit).convert(to: .yobibit))
        
        try XCTAssertEqual(Measurement("1byte"), 8.measured(in: .bit).convert(to: .byte))
        try XCTAssertEqual(Measurement("1kB"), 8000.measured(in: .bit).convert(to: .kilobyte))
        try XCTAssertEqual(Measurement("1MB"), 8e6.measured(in: .bit).convert(to: .megabyte))
        try XCTAssertEqual(Measurement("1GB"), 8e9.measured(in: .bit).convert(to: .gigabyte))
        try XCTAssertEqual(Measurement("1TB"), 8e12.measured(in: .bit).convert(to: .terabyte))
        try XCTAssertEqual(Measurement("1PB"), 8e15.measured(in: .bit).convert(to: .petabyte))
        try XCTAssertEqual(Measurement("1EB"), 8e18.measured(in: .bit).convert(to: .exabyte))
        try XCTAssertEqual(Measurement("1ZB"), 8e21.measured(in: .bit).convert(to: .zetabyte))
        try XCTAssertEqual(Measurement("1YB"), 8e24.measured(in: .bit).convert(to: .yottabyte))
        
        try XCTAssertEqual(Measurement("1KiB"), (8 * 1024).measured(in: .bit).convert(to: .kibibyte))
        try XCTAssertEqual(Measurement("1MiB"), (8 * pow(1024, 2)).measured(in: .bit).convert(to: .mebibyte))
        try XCTAssertEqual(Measurement("1GiB"), (8 * pow(1024, 3)).measured(in: .bit).convert(to: .gibibyte))
        try XCTAssertEqual(Measurement("1TiB"), (8 * pow(1024, 4)).measured(in: .bit).convert(to: .tebibyte))
        try XCTAssertEqual(Measurement("1PiB"), (8 * pow(1024, 5)).measured(in: .bit).convert(to: .pebibyte))
        try XCTAssertEqual(Measurement("1EiB"), (8 * pow(1024, 6)).measured(in: .bit).convert(to: .exbibyte))
        try XCTAssertEqual(Measurement("1ZiB"), (8 * pow(1024, 7)).measured(in: .bit).convert(to: .zebibyte))
        try XCTAssertEqual(Measurement("1YiB"), (8 * pow(1024, 8)).measured(in: .bit).convert(to: .yobibyte))
    }

    func testElectricPotentialDifference() throws {
        // Base unit: volt
        XCTAssertEqual(Measurement("1V"), 1.measured(in: .volt))
        try XCTAssertEqual(Measurement("1μV"), 1e-6.measured(in: .volt).convert(to: .microvolt))
        try XCTAssertEqual(Measurement("1mV"), 0.001.measured(in: .volt).convert(to: .millivolt))
        try XCTAssertEqual(Measurement("1kV"), 1000.measured(in: .volt).convert(to: .kilovolt))
        try XCTAssertEqual(Measurement("1MV"), 1e6.measured(in: .volt).convert(to: .megavolt))
    }

    func testEnergy() throws {
        // Base unit: joule
        XCTAssertEqual(Measurement("1J"), 1.measured(in: .joule))
        try XCTAssertEqual(Measurement("1kJ"), 1000.measured(in: .joule).convert(to: .kilojoule))
        try XCTAssertEqual(Measurement("1MJ"), 1_000_000.measured(in: .joule).convert(to: .megajoule))
        try XCTAssertEqual(Measurement("1cal"), 4.184.measured(in: .joule).convert(to: .calorie))
        try XCTAssertEqual(Measurement("1kCal"), 4184.measured(in: .joule).convert(to: .kilocalorie))
        try XCTAssertEqual(Measurement("1BTU"), 1054.35.measured(in: .joule).convert(to: .btu))
        try XCTAssertEqual(Measurement("1kBTU"), 1.05435e6.measured(in: .joule).convert(to: .kilobtu))
        try XCTAssertEqual(Measurement("1MBTU"), 1.05435e9.measured(in: .joule).convert(to: .megabtu))
        try XCTAssertEqual(Measurement("1therm"), 1.05435e8.measured(in: .joule).convert(to: .therm))
        try XCTAssertEqual(Measurement("1eV"), 1.602176634e-19.measured(in: .joule).convert(to: .electronVolt))
    }

    func testForce() throws {
        // Base unit: newton
        XCTAssertEqual(Measurement("1N"), 1.measured(in: .newton))
        try XCTAssertEqual(Measurement("1lbf"), 4.448222.measured(in: .newton).convert(to: .poundForce))
    }

    func testFrequency() throws {
        // Base unit: hertz
        XCTAssertEqual(Measurement("1Hz"), 1.measured(in: .hertz))
        try XCTAssertEqual(Measurement("1nHz"), 1e-9.measured(in: .hertz).convert(to: .nanohertz))
        try XCTAssertEqual(Measurement("1μHz"), 1e-6.measured(in: .hertz).convert(to: .microhertz))
        try XCTAssertEqual(Measurement("1mHz"), 0.001.measured(in: .hertz).convert(to: .millihertz))
        try XCTAssertEqual(Measurement("1kHz"), 1000.measured(in: .hertz).convert(to: .kilohertz))
        try XCTAssertEqual(Measurement("1MHz"), 1e6.measured(in: .hertz).convert(to: .megahertz))
        try XCTAssertEqual(Measurement("1GHz"), 1e9.measured(in: .hertz).convert(to: .gigahertz))
        try XCTAssertEqual(Measurement("1THz"), 1e12.measured(in: .hertz).convert(to: .terahertz))
    }

    func testIlluminance() throws {
        // Base unit: lux
        XCTAssertEqual(Measurement("1lx"), 1.measured(in: .lux))
        try XCTAssertEqual(Measurement("1fc"), 10.76.measured(in: .lux).convert(to: .footCandle))
        try XCTAssertEqual(Measurement("1phot"), 10000.measured(in: .lux).convert(to: .phot))
    }

    func testInductance() throws {
        // Base unit: henry
        XCTAssertEqual(Measurement("1H"), 1.measured(in: .henry))
    }

    func testLength() throws {
        // Base unit: meter
        XCTAssertEqual(Measurement("1m"), 1.measured(in: .meter))
        try XCTAssertEqual(Measurement("1pm"), 1e-12.measured(in: .meter).convert(to: .picometer))
        try XCTAssertEqual(Measurement("1nm"), 1e-9.measured(in: .meter).convert(to: .nanoometer))
        try XCTAssertEqual(Measurement("1μm"), 1e-6.measured(in: .meter).convert(to: .micrometer))
        try XCTAssertEqual(Measurement("1mm"), 0.001.measured(in: .meter).convert(to: .millimeter))
        try XCTAssertEqual(Measurement("1cm"), 0.01.measured(in: .meter).convert(to: .centimeter))
        try XCTAssertEqual(Measurement("1dm"), 10.measured(in: .meter).convert(to: .decameter))
        try XCTAssertEqual(Measurement("1hm"), 100.measured(in: .meter).convert(to: .hectometer))
        try XCTAssertEqual(Measurement("1km"), 1000.measured(in: .meter).convert(to: .kilometer))
        try XCTAssertEqual(Measurement("1Mm"), 1e6.measured(in: .meter).convert(to: .megameter))
        try XCTAssertEqual(Measurement("1in"), 0.0254.measured(in: .meter).convert(to: .inch))
        try XCTAssertEqual(Measurement("1ft"), 0.3048.measured(in: .meter).convert(to: .foot))
        try XCTAssertEqual(Measurement("1yd"), 0.9144.measured(in: .meter).convert(to: .yard))
        try XCTAssertEqual(Measurement("1mi"), 1609.344.measured(in: .meter).convert(to: .mile))
        try XCTAssertEqual(Measurement("1smi"), 10000.measured(in: .meter).convert(to: .scandanavianMile))
        try XCTAssertEqual(Measurement("1NM"), 1852.measured(in: .meter).convert(to: .nauticalMile))
        try XCTAssertEqual(Measurement("1fathom"), 1.8288.measured(in: .meter).convert(to: .fathom))
        try XCTAssertEqual(Measurement("1furlong"), 201.168.measured(in: .meter).convert(to: .furlong))
        try XCTAssertEqual(Measurement("1au"), 1.495978707e11.measured(in: .meter).convert(to: .astronomicalUnit))
        try XCTAssertEqual(Measurement("1ly"), 9.4607304725808e15.measured(in: .meter).convert(to: .lightyear))
        try XCTAssertEqual(Measurement("1pc"), 3.0856775814913673e16.measured(in: .meter).convert(to: .parsec))
    }

    func testLuminousIntensity() throws {
        // Base unit: candela
        XCTAssertEqual(Measurement("1cd"), 1.measured(in: .candela))
    }

    func testLuminousFlux() throws {
        // Base unit: lumen
        XCTAssertEqual(Measurement("1lm"), 1.measured(in: .lumen))
    }

    func testMagneticFlux() throws {
        // Base unit: weber
        XCTAssertEqual(Measurement("1Wb"), 1.measured(in: .weber))
    }

    func testMagneticFluxDensity() throws {
        // Base unit: tesla
        XCTAssertEqual(Measurement("1T"), 1.measured(in: .tesla))
    }

    func testMass() throws {
        // Base unit: kilogram
        XCTAssertEqual(Measurement("1kg"), 1.measured(in: .kilogram))
        try XCTAssertEqual(Measurement("1pg"), 1e-15.measured(in: .kilogram).convert(to: .picogram))
        try XCTAssertEqual(Measurement("1ng"), 1e-12.measured(in: .kilogram).convert(to: .nanogram))
        try XCTAssertEqual(Measurement("1μg"), 1e-9.measured(in: .kilogram).convert(to: .microgram))
        try XCTAssertEqual(Measurement("1mg"), 1e-6.measured(in: .kilogram).convert(to: .milligram))
        try XCTAssertEqual(Measurement("1cg"), 0.00001.measured(in: .kilogram).convert(to: .centigram))
        try XCTAssertEqual(Measurement("1dg"), 0.0001.measured(in: .kilogram).convert(to: .decigram))
        try XCTAssertEqual(Measurement("1g"), 0.001.measured(in: .kilogram).convert(to: .gram))
        try XCTAssertEqual(Measurement("1t"), 1000.measured(in: .kilogram).convert(to: .metricTon))
        try XCTAssertEqual(Measurement("1ct"), 0.0002.measured(in: .kilogram).convert(to: .carat))
        try XCTAssertEqual(Measurement("1oz"), 0.028349523125.measured(in: .kilogram).convert(to: .ounce))
        try XCTAssertEqual(Measurement("1lb"), 0.45359237.measured(in: .kilogram).convert(to: .pound))
        try XCTAssertEqual(Measurement("1st"), 6.35029318.measured(in: .kilogram).convert(to: .stone))
        try XCTAssertEqual(Measurement("1ton"), 907.18474.measured(in: .kilogram).convert(to: .shortTon))
        try XCTAssertEqual(Measurement("1troyOunces"), 0.0311034768.measured(in: .kilogram).convert(to: .troyOunces))
        try XCTAssertEqual(Measurement("1slug"), 14.5939.measured(in: .kilogram).convert(to: .slug))
    }

    func testPower() throws {
        // Base unit: watt
        XCTAssertEqual(Measurement("1W"), 1.measured(in: .watt))
        try XCTAssertEqual(Measurement("1fW"), 1e-15.measured(in: .watt).convert(to: .femptowatt))
        try XCTAssertEqual(Measurement("1pW"), 1e-12.measured(in: .watt).convert(to: .picowatt))
        try XCTAssertEqual(Measurement("1nW"), 1e-9.measured(in: .watt).convert(to: .nanowatt))
        try XCTAssertEqual(Measurement("1μW"), 1e-6.measured(in: .watt).convert(to: .microwatt))
        try XCTAssertEqual(Measurement("1mW"), 0.001.measured(in: .watt).convert(to: .milliwatt))
        try XCTAssertEqual(Measurement("1kW"), 1000.measured(in: .watt).convert(to: .kilowatt))
        try XCTAssertEqual(Measurement("1MW"), 1e6.measured(in: .watt).convert(to: .megawatt))
        try XCTAssertEqual(Measurement("1GW"), 1e9.measured(in: .watt).convert(to: .gigawatt))
        try XCTAssertEqual(Measurement("1TW"), 1e12.measured(in: .watt).convert(to: .terawatt))
        try XCTAssertEqual(Measurement("1hp"), 745.6998715822702.measured(in: .watt).convert(to: .horsepower))
        try XCTAssertEqual(Measurement("1TR"), 3500.measured(in: .watt).convert(to: .tonRefrigeration))
    }

    func testPressure() throws {
        // Base unit: pascal
        XCTAssertEqual(Measurement("1Pa"), 1.measured(in: .pascal))
        try XCTAssertEqual(Measurement("1hPa"), 100.measured(in: .pascal).convert(to: .hectopascal))
        try XCTAssertEqual(Measurement("1kPa"), 1000.measured(in: .pascal).convert(to: .kilopascal))
        try XCTAssertEqual(Measurement("1MPa"), 1e6.measured(in: .pascal).convert(to: .megapascal))
        try XCTAssertEqual(Measurement("1GPa"), 1e9.measured(in: .pascal).convert(to: .gigapascal))
        try XCTAssertEqual(Measurement("1bar"), 100_000.measured(in: .pascal).convert(to: .bar))
        try XCTAssertEqual(Measurement("1mbar"), 100.measured(in: .pascal).convert(to: .millibar))
        try XCTAssertEqual(Measurement("1atm"), 101_317.1.measured(in: .pascal).convert(to: .atmosphere))
        try XCTAssertEqual(Measurement("1mmhg"), 133.322387415.measured(in: .pascal).convert(to: .millimeterOfMercury))
        try XCTAssertEqual(Measurement("1cmhg"), 1333.22387415.measured(in: .pascal).convert(to: .centimeterOfMercury))
        try XCTAssertEqual(Measurement("1inhg"), 3386.389.measured(in: .pascal).convert(to: .inchOfMercury))
        try XCTAssertEqual(Measurement("1cmH₂0"), 98.0665.measured(in: .pascal).convert(to: .centimeterOfWater))
        try XCTAssertEqual(Measurement("1inH₂0"), 249.082.measured(in: .pascal).convert(to: .inchOfWater))
    }

    func testResistance() throws {
        // Base unit: ohm
        XCTAssertEqual(Measurement("1Ω"), 1.measured(in: .ohm))
        try XCTAssertEqual(Measurement("1μΩ"), 1e-6.measured(in: .ohm).convert(to: .microohm))
        try XCTAssertEqual(Measurement("1mΩ"), 0.001.measured(in: .ohm).convert(to: .milliohm))
        try XCTAssertEqual(Measurement("1kΩ"), 1000.measured(in: .ohm).convert(to: .kiloohm))
        try XCTAssertEqual(Measurement("1MΩ"), 1e6.measured(in: .ohm).convert(to: .megaohm))
    }

    func testSolidAngle() throws {
        // Base unit: steridian
        XCTAssertEqual(Measurement("1sr"), 1.measured(in: .steradian))
    }

    func testTemperature() throws {
        // Base unit: kelvin
        XCTAssertEqual(Measurement("1K"), 1.measured(in: .kelvin))
        try XCTAssertEqual(Measurement("1°C"), (273.15.measured(in: .kelvin) + 1.measured(in: .kelvin)).convert(to: .celsius))
        try XCTAssertEqual(XCTUnwrap(Measurement("1°F")), try ((273.15 - (32 * 5.0 / 9.0)).measured(in: .kelvin) + (5.0 / 9.0).measured(in: .kelvin)).convert(to: .fahrenheit), accuracy: 0.0001)
        try XCTAssertEqual(Measurement("1°R"), (5.0 / 9.0).measured(in: .kelvin).convert(to: .rankine))
    }

    func testTime() throws {
        // Base unit: second
        XCTAssertEqual(Measurement("1s"), 1.measured(in: .second))
        try XCTAssertEqual(Measurement("1ns"), 1e-9.measured(in: .second).convert(to: .nanosecond))
        try XCTAssertEqual(Measurement("1μs"), 1e-6.measured(in: .second).convert(to: .microsecond))
        try XCTAssertEqual(Measurement("1ms"), 0.001.measured(in: .second).convert(to: .millisecond))
        try XCTAssertEqual(Measurement("1min"), 60.measured(in: .second).convert(to: .minute))
        try XCTAssertEqual(Measurement("1hr"), 3600.measured(in: .second).convert(to: .hour))
        try XCTAssertEqual(Measurement("1d"), 86400.measured(in: .second).convert(to: .day))
        try XCTAssertEqual(Measurement("1week"), 604_800.measured(in: .second).convert(to: .week))
        try XCTAssertEqual(Measurement("1yr"), 31_557_600.measured(in: .second).convert(to: .year))
    }

    func testVelocity() throws {
        // Base unit: meter / second
        try XCTAssertEqual(Measurement("1knot"), 0.514444.measured(in: .meter / .second).convert(to: .knots))
    }

    func testVolume() throws {
        // Base unit: meter^3
        try XCTAssertEqual(Measurement("1L"), 0.001.measured(in: .meter * .meter * .meter).convert(to: .liter))
        try XCTAssertEqual(Measurement("1mL"), 1e-6.measured(in: .meter * .meter * .meter).convert(to: .milliliter))
        try XCTAssertEqual(Measurement("1cL"), 1e-5.measured(in: .meter * .meter * .meter).convert(to: .centiliter))
        try XCTAssertEqual(Measurement("1dL"), 1e-4.measured(in: .meter * .meter * .meter).convert(to: .deciliter))
        try XCTAssertEqual(Measurement("1kL"), 1.measured(in: .meter * .meter * .meter).convert(to: .kiloliter))
        try XCTAssertEqual(Measurement("1ML"), 1000.measured(in: .meter * .meter * .meter).convert(to: .megaliter))

        try XCTAssertEqual(Measurement("1tsp"), 4.92892159375e-6.measured(in: .meter * .meter * .meter).convert(to: .teaspoon))
        try XCTAssertEqual(Measurement("1tbsp"), 14.7867647812e-6.measured(in: .meter * .meter * .meter).convert(to: .tablespoon))
        try XCTAssertEqual(Measurement("1fl_oz"), 29.5735295625e-6.measured(in: .meter * .meter * .meter).convert(to: .fluidOunce))
        try XCTAssertEqual(Measurement("1cup"), 236.5882365e-6.measured(in: .meter * .meter * .meter).convert(to: .cup))
        try XCTAssertEqual(Measurement("1pt"), 473.176473e-6.measured(in: .meter * .meter * .meter).convert(to: .pint))
        try XCTAssertEqual(Measurement("1qt"), 9.46352946e-4.measured(in: .meter * .meter * .meter).convert(to: .quart))
        try XCTAssertEqual(Measurement("1gal"), 0.003785411784.measured(in: .meter * .meter * .meter).convert(to: .gallon))

        try XCTAssertEqual(Measurement("1drypt"), 5.506104713575e-4.measured(in: .meter * .meter * .meter).convert(to: .dryPint))
        try XCTAssertEqual(Measurement("1dryqt"), 1.101220942715e-3.measured(in: .meter * .meter * .meter).convert(to: .dryQuart))
        try XCTAssertEqual(Measurement("1pk"), 8.80976754172e-3.measured(in: .meter * .meter * .meter).convert(to: .peck))
        try XCTAssertEqual(Measurement("1bu"), 0.035239070167.measured(in: .meter * .meter * .meter).convert(to: .bushel))

        try XCTAssertEqual(Measurement("1ifl_oz"), 28.4130625e-6.measured(in: .meter * .meter * .meter).convert(to: .imperialFluidOunce))
        try XCTAssertEqual(Measurement("1icup"), 197.15686375e-6.measured(in: .meter * .meter * .meter).convert(to: .imperialCup))
        try XCTAssertEqual(Measurement("1ipt"), 568.26125e-6.measured(in: .meter * .meter * .meter).convert(to: .imperialPint))
        try XCTAssertEqual(Measurement("1iqt"), 1.1365225e-3.measured(in: .meter * .meter * .meter).convert(to: .imperialQuart))
        try XCTAssertEqual(Measurement("1igal"), 0.00454609.measured(in: .meter * .meter * .meter).convert(to: .imperialGallon))
        try XCTAssertEqual(Measurement("1ipk"), 9.09218e-3.measured(in: .meter * .meter * .meter).convert(to: .imperialPeck))
        try XCTAssertEqual(Measurement("1mcup"), 0.00025.measured(in: .meter * .meter * .meter).convert(to: .metricCup))
    }
}
