import SwiftUI

struct SportSignInView: View {
    @StateObject var sportSignInModel =  SportSignInViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    let apiManager = APIManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Register")
                        .EpilogueBold(size: 22)
                    
                    VStack(spacing: 25) {
                        CustomTextFiled(text: $sportSignInModel.name, geometry: geometry, placeholder: "Name")
                        
                        CustomTextFiled(text: $sportSignInModel.email, geometry: geometry, placeholder: "Email")
                        
                        CustomSecureFiled(text: $sportSignInModel.password, geometry: geometry, placeholder: "Password")
                    }
                    .padding(.top)
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        CustomColorButton(geometry: geometry,
                                          color: Color(red: 245/255, green: 199/255, blue: 85/255),
                                          text: "Register") {
                            if sportSignInModel.name.isEmpty || sportSignInModel.email.isEmpty || sportSignInModel.password.isEmpty {
                                alertMessage = "Please fill in all fields."
                                showAlert = true
                            } else {
                                apiManager.registerUser(nic: sportSignInModel.name,
                                                        email: sportSignInModel.email,
                                                        pass: sportSignInModel.password) { result in
                                    switch result {
                                    case .success(_):
                                        UserDefaultsManager().saveLoginStatus(true)
                                        UserDefaultsManager().saveUser(email: sportSignInModel.email,
                                                                       pass: sportSignInModel.password)
                                        DispatchQueue.main.async {
                                            sportSignInModel.isLogIn = true
                                        }
                                    case .failure(_):
                                        showAlert = true
                                    }
                                }
                            }
                        }
                                          .fullScreenCover(isPresented: $sportSignInModel.isLogIn) {
                                              SportLogInView()
                                          }
                        
                        CustomColorButton(geometry: geometry,
                                          color: Color(red: 41/255, green: 56/255, blue: 77/255),
                                          text: "Log in",
                                          textColor: .white) {
                            sportSignInModel.isLogIn = true
                        }
                                          .fullScreenCover(isPresented: $sportSignInModel.isLogIn) {
                                              SportLogInView()
                                          }
                        
                        CustomColorButton(geometry: geometry,
                                          color: Color(red: 41/255, green: 56/255, blue: 77/255),
                                          text: "Enter as Guest",
                                          textColor: .white) {
                            sportSignInModel.isGuest = true
                            UserDefaultsManager().saveUser(email: "guest",
                                                           pass: "guest")
                        }
                                          .fullScreenCover(isPresented: $sportSignInModel.isGuest) {
                                              SportNewsView()
                                          }
                    }
                    .padding(.bottom)
                }
                .padding(.top)
                
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                NavigationLink(destination: SportLogInView(),
                               isActive: $sportSignInModel.isLogIn) {}
                    .hidden()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SportSignInView()
}
