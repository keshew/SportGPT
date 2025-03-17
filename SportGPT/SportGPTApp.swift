import SwiftUI

@main
struct SportGPTApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaultsManager().checkLoginIn() {
                SportTabBarView()
            } else {
                SportSignInView()
            }
        }
    }
}
