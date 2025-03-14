import SwiftUI

struct SportForecastView: View {
    @StateObject var sportForecastModel = SportForecastViewModel()
    @State private var selectedForecast: ForecastModel?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        Text("AI Forecasts")
                            .EpilogueBold(size: 18)
                            .padding(.top)
                        
                        Spacer(minLength: 40)
                        
                        HStack(spacing: 20) {
                            CustomForecast(image: SportImageName.forecast1.rawValue,
                                           date: "Feb 20",
                                           text: "Leicester City vs\nLiverpool")
                            
                            CustomForecast(image: SportImageName.forecast2.rawValue,
                                           date: "Feb 25",
                                           text: "Chelsea vs Brighton")
                        }
                        .padding(.horizontal, 15)
                        
                        if sportForecastModel.arrayOfForecast.isEmpty {
                            Text("Loading...")
                                .foregroundColor(.white)
                                .padding(.top)
                        } else {
                            ForEach(sportForecastModel.arrayOfForecast) { forecast in
                                CustomForecastMatch(
                                    geometry: geometry,
                                    image: forecast.image,
                                    match: forecast.name,
                                    timeLeft: forecast.timeLeft,
                                    chanches: forecast.desc) {
                                        selectedForecast = forecast
                                        sportForecastModel.isDetail = true
                                }
                                    .fullScreenCover(isPresented: $sportForecastModel.isDetail) {
                                        SportMatchForecastView(model: selectedForecast ?? ForecastModel(name: "",
                                                                                                                                    desc: "",
                                                                                                                                    probability: 0.3,image: "",
                                                                                                                                    timeLeft: ""))
                                      }
                                .padding(.top, 20)
                            }
                        }
                        
                        Color(.clear)
                            .frame(height: 65)
                    }
                }
            }
            .onAppear {
                sportForecastModel.loadForecasts()
            }
      
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    SportForecastView()
}

