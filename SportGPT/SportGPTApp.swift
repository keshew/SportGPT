import SwiftUI

@main
struct SportGPTApp: App {
    @StateObject var sportNewsModel = SportNewsViewModel()
    @StateObject var sportForecastModel = SportForecastViewModel()
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLoginIn() {
                SportTabBarView()
            } else {
                SportSignInView()
                    .onAppear {
                        sportNewsModel.loadNews(email: "123", password: "123")
                        sportForecastModel.loadForecasts(email: "123", password: "123")
                    }
                
                    .onChange(of: sportNewsModel.savedDate) { _ in
//                        print("Новости", sportNewsModel.savedDate)
                        UserDefaultsManager.shared.saveNews(sportNewsModel.savedDate)
                    }
                    .onChange(of: sportForecastModel.savedDate) { _ in
//                        print("Прогнозы", sportForecastModel.savedDate)
                        UserDefaultsManager.shared.saveForecasts(sportForecastModel.savedDate)
                    }
            }
        }
    }
}

