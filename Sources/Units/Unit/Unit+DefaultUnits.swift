// TODO: Make more
// - Concentration Mass
// - Dispersion
// - Information Storage: https://developer.apple.com/documentation/foundation/unitinformationstorage

public extension UnitRegistry {
    // Provided as easy access to UnitRegistry default units

    // MARK: Acceleration

    var standardGravity: Unit { Unit(definedBy: DefaultUnits.standardGravity) }

    // MARK: Amount

    var mole: Unit { Unit(definedBy: DefaultUnits.mole) }
    var millimole: Unit { Unit(definedBy: DefaultUnits.millimole) }
    var particle: Unit { Unit(definedBy: DefaultUnits.particle) }

    // MARK: Angle

    var radian: Unit { Unit(definedBy: DefaultUnits.radian) }
    var degree: Unit { Unit(definedBy: DefaultUnits.degree) }
    var revolution: Unit { Unit(definedBy: DefaultUnits.revolution) }

    // MARK: Area

    var acre: Unit { Unit(definedBy: DefaultUnits.acre) }
    var are: Unit { Unit(definedBy: DefaultUnits.are) }
    var hectare: Unit { Unit(definedBy: DefaultUnits.hectare) }

    // MARK: Capacitance

    var farad: Unit { Unit(definedBy: DefaultUnits.farad) }

    // MARK: Charge

    var coulomb: Unit { Unit(definedBy: DefaultUnits.coulomb) }

    // MARK: Current

    var ampere: Unit { Unit(definedBy: DefaultUnits.ampere) }
    var microampere: Unit { Unit(definedBy: DefaultUnits.microampere) }
    var milliampere: Unit { Unit(definedBy: DefaultUnits.milliampere) }
    var kiloampere: Unit { Unit(definedBy: DefaultUnits.kiloampere) }
    var megaampere: Unit { Unit(definedBy: DefaultUnits.megaampere) }

    // MARK: Data

    var bit: Unit { Unit(definedBy: DefaultUnits.bit) }
    var byte: Unit { Unit(definedBy: DefaultUnits.byte) }
    var kilobyte: Unit { Unit(definedBy: DefaultUnits.kilobyte) }
    var megabyte: Unit { Unit(definedBy: DefaultUnits.megabyte) }
    var gigabyte: Unit { Unit(definedBy: DefaultUnits.gigabyte) }
    var petabyte: Unit { Unit(definedBy: DefaultUnits.petabyte) }

    // MARK: Electric Potential Difference

    var volt: Unit { Unit(definedBy: DefaultUnits.volt) }
    var microvolt: Unit { Unit(definedBy: DefaultUnits.microvolt) }
    var millivolt: Unit { Unit(definedBy: DefaultUnits.millivolt) }
    var kilovolt: Unit { Unit(definedBy: DefaultUnits.kilovolt) }
    var megavolt: Unit { Unit(definedBy: DefaultUnits.megavolt) }

    // MARK: Energy

    var joule: Unit { Unit(definedBy: DefaultUnits.joule) }
    var kilojoule: Unit { Unit(definedBy: DefaultUnits.kilojoule) }
    var megajoule: Unit { Unit(definedBy: DefaultUnits.megajoule) }
    var calorie: Unit { Unit(definedBy: DefaultUnits.calorie) }
    var kilocalorie: Unit { Unit(definedBy: DefaultUnits.kilocalorie) }
    var btu: Unit { Unit(definedBy: DefaultUnits.btu) }
    var kilobtu: Unit { Unit(definedBy: DefaultUnits.kilobtu) }
    var megabtu: Unit { Unit(definedBy: DefaultUnits.megabtu) }
    var therm: Unit { Unit(definedBy: DefaultUnits.therm) }
    var electronVolt: Unit { Unit(definedBy: DefaultUnits.electronVolt) }

    // MARK: Force

    var newton: Unit { Unit(definedBy: DefaultUnits.newton) }
    var poundForce: Unit { Unit(definedBy: DefaultUnits.poundForce) }

    // MARK: Frequency

    var hertz: Unit { Unit(definedBy: DefaultUnits.hertz) }
    var nanohertz: Unit { Unit(definedBy: DefaultUnits.nanohertz) }
    var microhertz: Unit { Unit(definedBy: DefaultUnits.microhertz) }
    var millihertz: Unit { Unit(definedBy: DefaultUnits.millihertz) }
    var kilohertz: Unit { Unit(definedBy: DefaultUnits.kilohertz) }
    var megahertz: Unit { Unit(definedBy: DefaultUnits.megahertz) }
    var gigahertz: Unit { Unit(definedBy: DefaultUnits.gigahertz) }
    var terahertz: Unit { Unit(definedBy: DefaultUnits.terahertz) }

    // MARK: Illuminance

    var lux: Unit { Unit(definedBy: DefaultUnits.lux) }
    var footCandle: Unit { Unit(definedBy: DefaultUnits.footCandle) }
    var phot: Unit { Unit(definedBy: DefaultUnits.phot) }

    // MARK: Inductance

    var henry: Unit { Unit(definedBy: DefaultUnits.henry) }

    // MARK: Length

    var meter: Unit { Unit(definedBy: DefaultUnits.meter) }
    var picometer: Unit { Unit(definedBy: DefaultUnits.picometer) }
    var nanoometer: Unit { Unit(definedBy: DefaultUnits.nanoometer) }
    var micrometer: Unit { Unit(definedBy: DefaultUnits.micrometer) }
    var millimeter: Unit { Unit(definedBy: DefaultUnits.millimeter) }
    var centimeter: Unit { Unit(definedBy: DefaultUnits.centimeter) }
    var decameter: Unit { Unit(definedBy: DefaultUnits.decameter) }
    var hectometer: Unit { Unit(definedBy: DefaultUnits.hectometer) }
    var kilometer: Unit { Unit(definedBy: DefaultUnits.kilometer) }
    var megameter: Unit { Unit(definedBy: DefaultUnits.megameter) }
    var inch: Unit { Unit(definedBy: DefaultUnits.inch) }
    var foot: Unit { Unit(definedBy: DefaultUnits.foot) }
    var yard: Unit { Unit(definedBy: DefaultUnits.yard) }
    var mile: Unit { Unit(definedBy: DefaultUnits.mile) }
    var scandanavianMile: Unit { Unit(definedBy: DefaultUnits.scandanavianMile) }
    var nauticalMile: Unit { Unit(definedBy: DefaultUnits.nauticalMile) }
    var fathom: Unit { Unit(definedBy: DefaultUnits.fathom) }
    var furlong: Unit { Unit(definedBy: DefaultUnits.furlong) }
    var astronomicalUnit: Unit { Unit(definedBy: DefaultUnits.astronomicalUnit) }
    var lightyear: Unit { Unit(definedBy: DefaultUnits.lightyear) }
    var parsec: Unit { Unit(definedBy: DefaultUnits.parsec) }

    // MARK: Luminous Intensity

    var candela: Unit { Unit(definedBy: DefaultUnits.candela) }

    // MARK: Luminous Flux

    var lumen: Unit { Unit(definedBy: DefaultUnits.lumen) }

    // MARK: Magnetic Flux

    var weber: Unit { Unit(definedBy: DefaultUnits.weber) }

    // MARK: Magnetic Flux Density

    var tesla: Unit { Unit(definedBy: DefaultUnits.tesla) }

    // MARK: Mass

    var kilogram: Unit { Unit(definedBy: DefaultUnits.kilogram) }
    var picogram: Unit { Unit(definedBy: DefaultUnits.picogram) }
    var nanogram: Unit { Unit(definedBy: DefaultUnits.nanogram) }
    var microgram: Unit { Unit(definedBy: DefaultUnits.microgram) }
    var milligram: Unit { Unit(definedBy: DefaultUnits.milligram) }
    var centigram: Unit { Unit(definedBy: DefaultUnits.centigram) }
    var decigram: Unit { Unit(definedBy: DefaultUnits.decigram) }
    var gram: Unit { Unit(definedBy: DefaultUnits.gram) }
    var metricTon: Unit { Unit(definedBy: DefaultUnits.metricTon) }
    var carat: Unit { Unit(definedBy: DefaultUnits.carat) }
    var ounce: Unit { Unit(definedBy: DefaultUnits.ounce) }
    var pound: Unit { Unit(definedBy: DefaultUnits.pound) }
    var stone: Unit { Unit(definedBy: DefaultUnits.stone) }
    var shortTon: Unit { Unit(definedBy: DefaultUnits.shortTon) }
    var troyOunces: Unit { Unit(definedBy: DefaultUnits.troyOunces) }
    var slug: Unit { Unit(definedBy: DefaultUnits.slug) }

    // MARK: Power

    var watt: Unit { Unit(definedBy: DefaultUnits.watt) }
    var femptowatt: Unit { Unit(definedBy: DefaultUnits.femptowatt) }
    var picowatt: Unit { Unit(definedBy: DefaultUnits.picowatt) }
    var nanowatt: Unit { Unit(definedBy: DefaultUnits.nanowatt) }
    var microwatt: Unit { Unit(definedBy: DefaultUnits.microwatt) }
    var milliwatt: Unit { Unit(definedBy: DefaultUnits.milliwatt) }
    var kilowatt: Unit { Unit(definedBy: DefaultUnits.kilowatt) }
    var megawatt: Unit { Unit(definedBy: DefaultUnits.megawatt) }
    var gigawatt: Unit { Unit(definedBy: DefaultUnits.gigawatt) }
    var terawatt: Unit { Unit(definedBy: DefaultUnits.terawatt) }
    var horsepower: Unit { Unit(definedBy: DefaultUnits.horsepower) }
    var tonRefrigeration: Unit { Unit(definedBy: DefaultUnits.tonRefrigeration) }

    // MARK: Pressure

    var pascal: Unit { Unit(definedBy: DefaultUnits.pascal) }
    var hectopascal: Unit { Unit(definedBy: DefaultUnits.hectopascal) }
    var kilopascal: Unit { Unit(definedBy: DefaultUnits.kilopascal) }
    var megapascal: Unit { Unit(definedBy: DefaultUnits.megapascal) }
    var gigapascal: Unit { Unit(definedBy: DefaultUnits.gigapascal) }
    var bar: Unit { Unit(definedBy: DefaultUnits.bar) }
    var millibar: Unit { Unit(definedBy: DefaultUnits.millibar) }
    var atmosphere: Unit { Unit(definedBy: DefaultUnits.atmosphere) }
    var millimeterOfMercury: Unit { Unit(definedBy: DefaultUnits.millimeterOfMercury) }
    var centimeterOfMercury: Unit { Unit(definedBy: DefaultUnits.centimeterOfMercury) }
    var inchOfMercury: Unit { Unit(definedBy: DefaultUnits.inchOfMercury) }
    var centimeterOfWater: Unit { Unit(definedBy: DefaultUnits.centimeterOfWater) }
    var inchOfWater: Unit { Unit(definedBy: DefaultUnits.inchOfWater) }

    // MARK: Resistance

    var ohm: Unit { Unit(definedBy: DefaultUnits.ohm) }
    var microohm: Unit { Unit(definedBy: DefaultUnits.microohm) }
    var milliohm: Unit { Unit(definedBy: DefaultUnits.milliohm) }
    var kiloohm: Unit { Unit(definedBy: DefaultUnits.kiloohm) }
    var megaohm: Unit { Unit(definedBy: DefaultUnits.megaohm) }

    // MARK: Solid Angle

    var steradian: Unit { Unit(definedBy: DefaultUnits.steradian) }

    // MARK: Temperature

    var kelvin: Unit { Unit(definedBy: DefaultUnits.kelvin) }
    var celsius: Unit { Unit(definedBy: DefaultUnits.celsius) }
    var fahrenheit: Unit { Unit(definedBy: DefaultUnits.fahrenheit) }
    var rankine: Unit { Unit(definedBy: DefaultUnits.rankine) }

    // MARK: Time

    var second: Unit { Unit(definedBy: DefaultUnits.second) }
    var nanosecond: Unit { Unit(definedBy: DefaultUnits.nanosecond) }
    var microsecond: Unit { Unit(definedBy: DefaultUnits.microsecond) }
    var millisecond: Unit { Unit(definedBy: DefaultUnits.millisecond) }
    var minute: Unit { Unit(definedBy: DefaultUnits.minute) }
    var hour: Unit { Unit(definedBy: DefaultUnits.hour) }
    var day: Unit { Unit(definedBy: DefaultUnits.day) }
    var week: Unit { Unit(definedBy: DefaultUnits.week) }
    var year: Unit { Unit(definedBy: DefaultUnits.year) }

    // MARK: Velocity

    var knots: Unit { Unit(definedBy: DefaultUnits.knots) }

    // MARK: Volume

    var liter: Unit { Unit(definedBy: DefaultUnits.liter) }
    var milliliter: Unit { Unit(definedBy: DefaultUnits.milliliter) }
    var centiliter: Unit { Unit(definedBy: DefaultUnits.centiliter) }
    var deciliter: Unit { Unit(definedBy: DefaultUnits.deciliter) }
    var kiloliter: Unit { Unit(definedBy: DefaultUnits.kiloliter) }
    var megaliter: Unit { Unit(definedBy: DefaultUnits.megaliter) }
    var bushel: Unit { Unit(definedBy: DefaultUnits.bushel) }
    var teaspoon: Unit { Unit(definedBy: DefaultUnits.teaspoon) }
    var tablespoon: Unit { Unit(definedBy: DefaultUnits.tablespoon) }
    var fluidOunce: Unit { Unit(definedBy: DefaultUnits.fluidOunce) }
    var cup: Unit { Unit(definedBy: DefaultUnits.cup) }
    var pint: Unit { Unit(definedBy: DefaultUnits.pint) }
    var gallon: Unit { Unit(definedBy: DefaultUnits.gallon) }
    var imperialFluidOunce: Unit { Unit(definedBy: DefaultUnits.imperialFluidOunce) }
    var imperialCup: Unit { Unit(definedBy: DefaultUnits.imperialCup) }
    var imperialPint: Unit { Unit(definedBy: DefaultUnits.imperialPint) }
    var imperialGallon: Unit { Unit(definedBy: DefaultUnits.imperialGallon) }
    var metricCup: Unit { Unit(definedBy: DefaultUnits.metricCup) }
}
