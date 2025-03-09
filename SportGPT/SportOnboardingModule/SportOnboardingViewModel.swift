import SwiftUI

class SportOnboardingViewModel: ObservableObject {
    let contact = SportOnboardingModel()
    @Published var currentIndex = 0
    @Published var isTabBar = false
    func increaseIndex() {
        currentIndex += 1
    }
    
    func lowerIndex() {
        currentIndex -= 1
    }
}
