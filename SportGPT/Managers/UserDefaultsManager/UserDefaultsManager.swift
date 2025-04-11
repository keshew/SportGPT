import Foundation

class UserDefaultsManager: ObservableObject {
    static let shared = UserDefaultsManager()
       
       private let defaults = UserDefaults.standard
    
    func isFirstLaunch() -> Bool {
          let defaults = UserDefaults.standard
          let isFirstLaunch = defaults.bool(forKey: "isFirstLaunch")
          
          if !isFirstLaunch {
              defaults.set(true, forKey: "isFirstLaunch")
              return true
          }
          
          return false
      }
    
    func saveUser(email: String, pass: String) {
        let userDefaults = UserDefaults.standard
        let user = ["email": email, "pass": pass]
        userDefaults.set(user, forKey: "user")
    }

    func getUser() -> (email: String?, pass: String?) {
        let userDefaults = UserDefaults.standard
        if let user = userDefaults.dictionary(forKey: "user") as? [String: String] {
            return (user["email"], user["pass"])
        } else {
            return (nil, nil)
        }
    }
    
    func checkLoginIn() -> Bool {
        let userDefaults = UserDefaults.standard
        return userDefaults.bool(forKey: "isLoggedIn")
    }

    func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
    
    func saveNews(_ news: [NewsModel]) {
         do {
             let data = try JSONEncoder().encode(news)
             defaults.set(data, forKey: "news")
         } catch {
             print("Ошибка сохранения новостей: \(error)")
         }
     }
     
     func loadNews() -> [NewsModel] {
         guard let data = defaults.data(forKey: "news") else { return [] }
         
         do {
             return try JSONDecoder().decode([NewsModel].self, from: data)
         } catch {
             print("Ошибка загрузки новостей: \(error)")
             return []
         }
     }
     
     func saveForecasts(_ forecasts: [ForecastModel]) {
         do {
             let data = try JSONEncoder().encode(forecasts)
             defaults.set(data, forKey: "forecasts")
         } catch {
             print("Ошибка сохранения прогнозов: \(error)")
         }
     }
     
     func loadForecasts() -> [ForecastModel] {
         guard let data = defaults.data(forKey: "forecasts") else { return [] }
         
         do {
             return try JSONDecoder().decode([ForecastModel].self, from: data)
         } catch {
             print("Ошибка загрузки прогнозов: \(error)")
             return []
         }
     }
}
