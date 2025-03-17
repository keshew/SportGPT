import SwiftUI

class SportSettingsViewModel: ObservableObject {
    let contact = SportSettingsModel()
    @Published var isDeleted = false
    @Published var isLogOut = false
}
