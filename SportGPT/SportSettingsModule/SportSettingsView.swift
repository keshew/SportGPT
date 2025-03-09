import SwiftUI

struct SportSettingsView: View {
    @StateObject var sportSettingsModel =  SportSettingsViewModel()
    @State var isOn = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Text("Settings")
                            .EpilogueBold(size: 18)
                        
                        Spacer(minLength: 40)
                        
                        HStack {
                            Text("Notification")
                                .EpilogueBold(size: 18)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 10)
                        
                        HStack {
                            Text("Push Notifications")
                                .EpilogueRegular(size: 16)
                                .padding(.leading)
                                
                            Spacer()
                            
                            Toggle("", isOn: $isOn)
                                .toggleStyle(CustomToggleStyle())
                        }
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Text("About")
                                .EpilogueBold(size: 18)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        Link(destination: URL(string: "https://gsforlife.homes/privacy.html")!) {
                            HStack {
                                Text("Privacy Policy")
                                    .EpilogueRegular(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Image(.chevron)
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .padding(.trailing)
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        Link(destination: URL(string: "https://gsforlife.homes/terms.html")!) {
                            HStack {
                                Text("Terms of Use")
                                    .EpilogueRegular(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Image(.chevron)
                                    .resizable()
                                    .frame(width: 28, height: 28)
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SportSettingsView()
}


