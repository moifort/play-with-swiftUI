import Foundation

struct TastingSheet: Hashable, Identifiable {
    let id : String
    let method: Method
    let coffee: String
    let coffeeGrindSize: Int?
    let coffeeWeightInGrams: Int?
    let coffeeInfusionTimeInSeconds: Int?
    let waterQuantityInMilliliters: Int?
    let waterTemperatureInCelsius: Int?
    let tasteRatingOutOf5: Int?
}
