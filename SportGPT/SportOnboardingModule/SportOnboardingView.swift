import SwiftUI

struct SportOnboardingView: View {
    @StateObject var sportOnboardingModel =  SportOnboardingViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .ignoresSafeArea()
                
                Image(sportOnboardingModel.contact.arrayImage[sportOnboardingModel.currentIndex])
                    .resizable()
                    .frame(width: geometry.size.width * 0.65,
                           height: geometry.size.height * 0.727)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.52)
         
                Color(red: 18/255, green: 28/255, blue: 36/225)
                    .frame(width: geometry.size.width, height: 30)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 0.99)
                
                Image(.shadowOnboarding)
                    .resizable()
                    .frame(width: geometry.size.width, height: 207)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 1.1)
                
                VStack {
                    VStack(spacing: 20) {
                        Text(sportOnboardingModel.contact.arrayLabel[sportOnboardingModel.currentIndex])
                            .EpilogueBold(size: 24)
                            .multilineTextAlignment(.center)
                        
                        Text(sportOnboardingModel.contact.arrayDesc[sportOnboardingModel.currentIndex])
                            .EpilogueRegular(size: 16)
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    
                    VStack(spacing: 10) {
                        CustomColorButton(geometry: geometry,
                                          color: Color(red: 245/255, green: 199/255, blue: 85/255),
                                          text: "Next") {
                            if sportOnboardingModel.currentIndex <= 1 {
                                withAnimation {
                                    sportOnboardingModel.increaseIndex()
                                }
                            } else {
                                sportOnboardingModel.isTabBar = true
                            }
                        }
                        
                        CustomColorButton(geometry: geometry,
                                          color: Color(red: 41/255, green: 56/255, blue: 77/255),
                                          text: "Skip",
                                          textColor: .white) {
                            sportOnboardingModel.isTabBar = true
                        }
                    }
                    .padding(.bottom)
                }
            }
            NavigationLink(destination: SportTabBarView(),
                           isActive: $sportOnboardingModel.isTabBar) {}
                .hidden()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SportOnboardingView()
}

