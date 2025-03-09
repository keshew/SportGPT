import SwiftUI

class SportLogInViewModel: ObservableObject {
    let contact = SportLogInModel()
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogIn = false
    @Published var isOnb = false
}
