import SwiftUI

class SportForecastViewModel: ObservableObject {
    let contact = SportForecastModel()
    @Published var arrayOfForecast: [ForecastModel] = []
    @Published var isDetail = false
    
    func loadForecasts() {
        let (email, pass) = UserDefaultsManager().getUser()
          if let email = email, let pass = pass {
              APIManager().getMatchForecast(email: email, pass: pass) { result in
                  switch result {
                  case .success(let forecasts):
                      DispatchQueue.main.async {
                          self.arrayOfForecast = forecasts.map { forecast in
                              ForecastModel(
                                  name: forecast.match,
                                  desc: forecast.prediction,
                                  probability: Double(forecast.prediction_confidence),
                                  image: forecast.stadium_image,
                                  timeLeft: "Soon"
                              )
                          }
                      }
                  case .failure(let error):
                      print("Ошибка загрузки прогнозов: \(error)")
                  }
              }
          } else {
              print("Пользователь не авторизован")
          }
      }
}
