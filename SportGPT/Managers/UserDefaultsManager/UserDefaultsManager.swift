import Foundation

class UserDefaultsManager: ObservableObject {
    
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

    func checkLogin() -> Bool {
        let userDefaults = UserDefaults.standard
        if let _ = userDefaults.dictionary(forKey: "user") {
            return true
        } else {
            return false
        }
    }

    func saveLoginStatus(_ isLoggedIn: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
    }
}
