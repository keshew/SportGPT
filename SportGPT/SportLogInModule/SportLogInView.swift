import SwiftUI

struct SportLogInView: View {
    @StateObject var sportLogInModel =  SportLogInViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    let apiManager = APIManager()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()

                VStack {
                    Text("Log in")
                        .EpilogueBold(size: 22)

                    VStack(spacing: 25) {
                        CustomTextFiled(text: $sportLogInModel.email, geometry: geometry, placeholder: "Email")

                        CustomSecureFiled(text: $sportLogInModel.password, geometry: geometry, placeholder: "Password")
                    }
                    .padding(.top)

                    Spacer()

                    VStack(spacing: 10) {
                        CustomColorButton(geometry: geometry,
                                          color: Color(red: 245/255, green: 199/255, blue: 85/255),
                                          text: "Log in") {
                            if sportLogInModel.email.isEmpty || sportLogInModel.password.isEmpty {
                                alertMessage = "Please fill in all fields."
                                showAlert = true
                            } else {
                                apiManager.loginUser(email: sportLogInModel.email, pass: sportLogInModel.password) { result in
                                    switch result {
                                    case .success(let response):
                                        if response.status == "success" {
                                            UserDefaultsManager().saveLoginStatus(true)
                                            DispatchQueue.main.async {
                                              if UserDefaultsManager().isFirstLaunch() {
                                                    sportLogInModel.isOnb = true
                                                } else {
                                                    sportLogInModel.isLogIn = true
                                                }
                                                UserDefaultsManager().saveUser(email: sportLogInModel.email,
                                                                               pass: sportLogInModel.password)
                                            }
                                        } else {
                                            alertMessage = "Incorrect email or password"
                                            showAlert = true
                                        }
                                    case .failure(_):
                                        alertMessage = "Incorrect email or password"
                                        showAlert = true
                                    }
                                }
                            }
                        }
                                          .fullScreenCover(isPresented: $sportLogInModel.isLogIn) {
                                              SportTabBarView()
                                          }
                        
                                          .fullScreenCover(isPresented: $sportLogInModel.isOnb) {
                                              SportOnboardingView()
                                          }


                        CustomColorButton(geometry: geometry,
                                          color: Color(red: 41/255, green: 56/255, blue: 77/255),
                                          text: "Register",
                                          textColor: .white) {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                    }
                    .padding(.bottom)
                }
                .padding(.top)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SportLogInView()
}
