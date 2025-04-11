import SwiftUI

class SportForecastViewModel: ObservableObject {
    let contact = SportForecastModel()
    @Published var arrayOfForecast: [ForecastModel] = []
    @Published var savedDate: [ForecastModel] = []
    @Published var isDetail = false
    
    func loadForecat() {
        arrayOfForecast = UserDefaultsManager.shared.loadForecasts()
    }
    
    func loadForecasts(email: String?, password: String?) {
          if let email = email, let pass = password {
              APIManager().getMatchForecast(email: email, pass: pass) { result in
                  switch result {
                  case .success(let forecasts):
                      DispatchQueue.main.async {
                          self.savedDate = forecasts.map { forecast in
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
