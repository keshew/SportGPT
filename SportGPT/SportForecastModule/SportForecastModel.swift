import SwiftUI

struct ForecastModel: Identifiable {
    let id = UUID()
    var name: String
    var desc: String
    let probability: Double?
    var image: String
    var timeLeft: String
}

struct ForecastItem: Codable {
    let match: String
    let prediction: String
    let prediction_confidence: Int // Изменили название и тип
    let stadium_image: String      // Изменили название
}

struct SportForecastModel {
    let arrayOfForecast = [ForecastModel(name: "Leicester City vs Liverpool",
                                         desc: "AI forecast: 63% chance of Leicester City winning",
                                         probability: 0.3,
                                         image: SportImageName.match1.rawValue,
                                         timeLeft: "Match starts in 4 hours"),
                           ForecastModel(name: "Chelsea vs Brighton",
                                         desc: "AI forecast: 78% chance of Chelsea winning",
                                         probability: 0.3,
                                         image: SportImageName.match2.rawValue,
                                         timeLeft: "Match starts in 7 hours")]
}


