import SwiftUI

struct SportMatchForecastView: View {
    @StateObject var sportMatchForecastModel =  SportMatchForecastViewModel()
    @Environment(\.presentationMode) var presentationMode
    let model: ForecastModel
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.backButton)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                            Text("Match Forecast")
                                .EpilogueRegular(size: 18)
                                .padding(.trailing, 40)
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        HStack {
                            Text(model.name)
                                .EpilogueBold(size: 22)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            Text("AI forecast: \(model.desc)")
                                .EpilogueRegular(size: 16)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 50)
                        
                        VStack(spacing: 20) {
                            HStack {
                                Text(model.desc)
                                    .EpilogueBold(size: 16)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text("\(String(describing: model.probability ?? 0))")
                                    .EpilogueBold(size: 32)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack {
                                HStack {
                                    Text("last 30 days")
                                        .EpilogueRegular(size: 16,
                                                         color: Color(red: 139/255, green: 158/255, blue: 191/255))
                                    
                                    Text("+5%")
                                        .EpilogueRegular(size: 16,
                                                         color: Color(red: 61/255, green: 222/255, blue: 122/255))
                                }
                                .padding(.leading)
                                
                                Spacer()
                            }
                        }
                        
                        Spacer(minLength: 50)
                        
                        HStack(spacing: -20) {
                            Image(.mf1)
                                .resizable()
                                .frame(width: 77, height: 77)
                            
                            Image(.mf2)
                                .resizable()
                                .frame(width: 77, height: 77)
                            
                            Image(.mf3)
                                .resizable()
                                .frame(width: 77, height: 77)
                        }
                        
                        Text("Based on 3 users' opinions. \(String(describing: model.probability ?? 0)) of them think that \(sportMatchForecastModel.insertWill(into: model.desc))")
                            .EpilogueRegular(size: 16)
                            .padding()
                        
                        Spacer(minLength: 30)
                        
                        if !sportMatchForecastModel.isAgree, !sportMatchForecastModel.isDisagree {
                            VStack(spacing: 15) {
                                CustomColorButton(geometry: geometry,
                                                  color: Color(red: 245/255, green: 199/255, blue: 85/255),
                                                  text: "I agree with the forecast") {
                                    sportMatchForecastModel.isAgree = true
                                }
                                
                                CustomColorButton(geometry: geometry,
                                                  color: Color(red: 41/255, green: 56/255, blue: 77/255),
                                                  text: "I disagree",
                                                  textColor: .white) {
                                    sportMatchForecastModel.isDisagree = true
                                }
                            }
                        } else if sportMatchForecastModel.isAgree {
                            AgreeForecast()
                        } else if sportMatchForecastModel.isDisagree {
                            DisagreeForecast()
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let forecast = ForecastModel(name: "", desc: "", probability: 0.3, image: "", timeLeft: "")
    SportMatchForecastView(model: forecast)
}

