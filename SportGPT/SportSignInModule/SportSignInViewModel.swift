import SwiftUI

class SportSignInViewModel: ObservableObject {
    let contact = SportSignInModel()
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogIn = false
}
