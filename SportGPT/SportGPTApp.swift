import SwiftUI

@main
struct SportGPTApp: App {
    @StateObject var sportNewsModel = SportNewsViewModel()
    @StateObject var sportForecastModel = SportForecastViewModel()
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLoginIn() {
                SportTabBarView()
                    .environmentObject(sportNewsModel)
                    .environmentObject(sportForecastModel)
            } else {
                SportSignInView()
            }
        }
    }
}

